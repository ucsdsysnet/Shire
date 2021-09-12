#include "core.h"
#include "packet_headers.h"

#if 0
#define PROFILE_A(x) do {DEBUG_OUT_L = (x);} while (0)
#define PROFILE_B(x) do {DEBUG_OUT_H = (x);} while (0)
#else
#define PROFILE_A(x) do {} while (0)
#define PROFILE_B(x) do {} while (0)
#endif

#define bswap_16(x) \
  (((x & 0xff00) >> 8) | ((x & 0x00ff) << 8))

#define bswap_32(x) \
  (((x & 0xff000000) >> 24) | ((x & 0x00ff0000) >>  8) | \
   ((x & 0x0000ff00) <<  8) | ((x & 0x000000ff) << 24))

// maximum number of slots (number of context objects)
#define MAX_CTX_COUNT 32
#define REORDER_LIMIT 8
#define HASH_SCHED

// packet start offset
// DWORD align Ethernet payload
// provide space for header modifications
#define PKT_OFFSET 10
// PMEM in 8 blocks of 128 KB
// accelerators only connected to upper 2 blocks
#define PKTS_START ((8-(MAX_CTX_COUNT/8))*128*1024)

#ifdef HASH_SCHED
  #define DATA_OFFSET 4
#else
  #define DATA_OFFSET 0
#endif

// flows
struct flow {
  unsigned short tag;
  unsigned short ts;
  unsigned int   exp_seq;
  union {
    volatile unsigned long long state_64;
    volatile unsigned int       state_32[2];
    volatile unsigned char      state_8[8];
  } state;
};

// Accel wrapper registers mapping
#define ACC_PIG_CTRL     (*((volatile unsigned char      *)(IO_EXT_BASE + 0x00)))
#define ACC_PIG_MATCH    (*((volatile unsigned char      *)(IO_EXT_BASE + 0x00)))
#define ACC_PIG_STATE    (*((volatile unsigned long long *)(IO_EXT_BASE + 0x10)))
#define ACC_PIG_STATE_L  (*((volatile unsigned int       *)(IO_EXT_BASE + 0x10)))
#define ACC_PIG_STATE_H  (*((volatile unsigned int       *)(IO_EXT_BASE + 0x14)))
#define ACC_PIG_PORTS    (*((volatile unsigned int       *)(IO_EXT_BASE + 0x0c)))
#define ACC_PIG_SRC_PORT (*((volatile unsigned short     *)(IO_EXT_BASE + 0x0c)))
#define ACC_PIG_DST_PORT (*((volatile unsigned short     *)(IO_EXT_BASE + 0x0e)))
#define ACC_PIG_SLOT     (*((volatile unsigned char      *)(IO_EXT_BASE + 0x18)))
#define ACC_PIG_RULE_ID  (*((volatile unsigned int       *)(IO_EXT_BASE + 0x1c)))

#define FLOW_TABLE_ENTRY   ((volatile struct flow        *)(IO_EXT_BASE + 0x40))
#define HASH_LOOKUP      (*((volatile unsigned short     *)(IO_EXT_BASE + 0x60)))
#define HASH_BLOCK_32B   (*((volatile unsigned char      *)(IO_EXT_BASE + 0x64)))

#define ACC_DMA_LEN      (*((volatile unsigned int       *)(IO_EXT_BASE + 0x04)))
#define ACC_DMA_ADDR     (*((volatile unsigned int       *)(IO_EXT_BASE + 0x08)))
#define ACC_DMA_STAT     (*((volatile unsigned int       *)(IO_EXT_BASE + 0x78)))
#define ACC_DMA_BUSY     (*((volatile unsigned char      *)(IO_EXT_BASE + 0x78)))
#define ACC_DMA_DONE     (*((volatile unsigned char      *)(IO_EXT_BASE + 0x79)))
#define ACC_DMA_DONE_ERR (*((volatile unsigned char      *)(IO_EXT_BASE + 0x7a)))

// Slot contexts
struct slot_context {
  int index;
  struct Desc desc;

  // Pointers
  unsigned char  *eop;
  unsigned short *hash_L;
  unsigned short *hash_H;
  unsigned char  *header;

  struct eth_header *eth_hdr;
  union {
    struct ipv4_header *ipv4_hdr;
  } l3_header;
  union {
    struct tcp_header *tcp_hdr;
    struct udp_header *udp_hdr;
  } l4_header;

  union {
    struct tcp_header *tcp_hdr;
    struct udp_header *udp_hdr;
  } l4_header_swapped;

  // Packet metadata
  unsigned int payload_addr;
  unsigned int payload_length;
  unsigned int match_cnt;
  unsigned int set_mask;
  unsigned int rst_mask;

  // Flow metadata
  struct   flow  flow;
  unsigned short flow_id;
  int            is_tcp;
};

struct slot_context context[MAX_CTX_COUNT];

unsigned int slot_count;
unsigned int slot_size;
unsigned int header_slot_base;
unsigned int header_slot_size;

static inline void slot_rx_packet(struct slot_context *slot)
{
  char ch;
  unsigned int   payload_offset = ETH_HEADER_SIZE + IPV4_HEADER_SIZE;
  unsigned int   packet_length  = slot->desc.len;

  PROFILE_B(0x00010005);

  // check eth type
  if (slot->eth_hdr->type == bswap_16(0x0800))
  {
    // IPv4 packet

    // check protocol
    switch (slot->l3_header.ipv4_hdr->protocol)
    {
      case 0x06: // TCP
        PROFILE_B(0x00010007);
        payload_offset += TCP_HEADER_SIZE;

        // ch = ((char *)slot->l4_header.tcp_hdr)[12];
        // payload_offset += (ch & 0xF0) >> 2;

        // // no payload
        // if (payload_offset >= packet_length)
        //   goto drop;

        ACC_DMA_ADDR  = (unsigned int)(slot->desc.data)+payload_offset;
        ACC_DMA_LEN   = packet_length - payload_offset;
        ACC_PIG_PORTS = * (unsigned int *) slot->l4_header.tcp_hdr; // both ports
        ACC_PIG_STATE_H = 0x01FFFFFF;
        ACC_PIG_STATE_L = 0xFFFFFFFF;
        ACC_PIG_SLOT  = slot->index;
        ACC_PIG_CTRL  = 1;
        slot->eop     = slot->desc.data + slot->desc.len;

        return;

      case 0x11: // UDP
        PROFILE_B(0x00010006);
        payload_offset += UDP_HEADER_SIZE;

        // // no payload
        // if (payload_offset >= packet_length)
        //   goto drop;

        ACC_DMA_ADDR  = (unsigned int)(slot->desc.data)+payload_offset;
        ACC_DMA_LEN   = packet_length - payload_offset;
        ACC_PIG_PORTS = * (unsigned int *) slot->l4_header.udp_hdr; // both ports
        ACC_PIG_STATE = 0;
        ACC_PIG_SLOT  = slot->index;
        ACC_PIG_CTRL  = 1;
        slot -> eop   = slot->desc.data + slot->desc.len;

        return;
    }
  }

drop:
  slot->desc.len = 0;
  pkt_send(&slot->desc);
}

static inline void slot_match(struct slot_context *slot){
  unsigned int rule_id;
  PROFILE_B(0xDEAD6666);

  while (1){
    rule_id = ACC_PIG_RULE_ID;
    asm volatile("" ::: "memory");

    if (rule_id!=0){
      ACC_PIG_CTRL = 2; // release the match
      asm volatile("" ::: "memory");
      // Add rule IDs to the end of the packet
      * slot->eop = rule_id;
      slot->eop += 4;
      slot->desc.len += 4;
      slot->match_cnt ++;
      PROFILE_B(0xDEAD0001);
    } else { // EoP

      // pkt_num ++;
      PROFILE_B(0xDEAD0002);

      // Decide what to do with the packet
      if (slot->match_cnt!=0){
        slot->desc.port = 2;
        PROFILE_B(0xDEAD0003);
        // PROFILE_A(0xDDDD0000|pkt_num);
      } else {// IDS: drop, IPS: forward
        slot->desc.len = 0;
        PROFILE_B(0xDEAD0004);
        // slot->desc.port ^= 0x1;
      }

      ACC_PIG_CTRL    = 2; // release the EoP
      asm volatile("" ::: "memory");
      slot->match_cnt = 0; // Done with current packet
      pkt_send(&slot->desc);
      return; // Go back to main loop when done with a packet
    }

    if (ACC_PIG_MATCH) // continue draining FIFO
      slot = &context[ACC_PIG_SLOT];
    else
      break;
  }

}

int main(void)
{
  struct slot_context *slot;
  unsigned int reorder_mask;
  unsigned int reorder_left_mask;
  unsigned int init_left_mask;

  DEBUG_OUT_L = 0;
  DEBUG_OUT_H = 0;

  // set slot configuration parameters
  slot_count       = 32;
  slot_size        = 16*1024;
  header_slot_base = DMEM_BASE + (DMEM_SIZE >> 1);
  header_slot_size = 128;

  if (slot_count > MAX_SLOT_COUNT)
    slot_count = MAX_SLOT_COUNT;

  if (slot_count > MAX_CTX_COUNT)
    slot_count = MAX_CTX_COUNT;

  // Do this at the beginning, so scheduler can fill the slots while
  // initializing other things.
  init_hdr_slots(slot_count, header_slot_base, header_slot_size);
  init_slots(slot_count, PKTS_START+PKT_OFFSET, slot_size);
  set_masks(0x30); // Enable only Evict + Poke
  set_sched_offset(DATA_OFFSET);

  // init slot context structures
  for (int i = 0; i < slot_count; i++)
  {
    context[i].index     = i;
    context[i].desc.tag  = i+1;
    context[i].desc.data = (unsigned char *)(PMEM_BASE + PKTS_START + PKT_OFFSET + DATA_OFFSET + i*slot_size);
    context[i].header    = (unsigned char *)(header_slot_base + PKT_OFFSET + DATA_OFFSET + i*header_slot_size);
    context[i].hash_L    = (unsigned short *)(header_slot_base + PKT_OFFSET + i*header_slot_size);
    context[i].hash_H    = (unsigned short *)(header_slot_base + PKT_OFFSET + i*header_slot_size + 2);
    context[i].eth_hdr   = (struct eth_header*)(context[i].header);
    context[i].match_cnt = 0;
    context[i].set_mask  =   0x1L << i;
    context[i].rst_mask  = ~(0x1L << i);

    context[i].l3_header.ipv4_hdr = (struct ipv4_header*)(context[i].header +
                                     ETH_HEADER_SIZE);
    context[i].l4_header.tcp_hdr  = (struct tcp_header*) (context[i].header +
                                     ETH_HEADER_SIZE + IPV4_HEADER_SIZE);
  }

  ACC_PIG_STATE_L = 0xFFFFFFFF;
  // pkt_num = 0;

  PROFILE_A(0x00000005);

  while (1)
  {
    // check for new packets
    if (in_pkt_ready())
    {
      PROFILE_A(0x00010001);

      // compute index
      slot = &context[RECV_DESC.tag-1];

      // copy descriptor into context, we already know the data pointer
      slot->desc.desc_low = RECV_DESC.desc_low;
      asm volatile("" ::: "memory");
      RECV_DESC_RELEASE = 1;

      // handle packet
      slot_rx_packet(slot);
    }

    if (ACC_PIG_MATCH) {
      PROFILE_A(0x00010003);
      slot_match(&context[ACC_PIG_SLOT]);
    }

  }

  return 1;
}
