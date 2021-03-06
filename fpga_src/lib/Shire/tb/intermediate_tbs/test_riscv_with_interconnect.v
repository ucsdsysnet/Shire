/*

Copyright (c) 2019 Moein Khazraee
Copyright (c) 2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`resetall
`timescale 1ns / 1ps
`default_nettype none

/*
 * Testbench for axi_dma
 */
module test_riscv_with_interconnect;

// Parameters
parameter S_COUNT = 2;
parameter M_COUNT = 1;
parameter FORWARD_ID = 1;
parameter M_REGIONS = 1;
parameter M_BASE_ADDR = {16'h3000, 16'h2000, 16'h1000, 16'h0000};
parameter M_ADDR_WIDTH = {M_COUNT{{M_REGIONS{32'd16}}}};
parameter M_CONNECT_READ = {M_COUNT{{S_COUNT{1'b1}}}};
parameter M_CONNECT_WRITE = {M_COUNT{{S_COUNT{1'b1}}}};
parameter M_SECURE = {M_COUNT{1'b0}};

parameter DATA_WIDTH = 64;
parameter CTRL_WIDTH = (DATA_WIDTH/8);
parameter AXI_DATA_WIDTH = 64;
parameter AXI_ADDR_WIDTH = 16;
parameter AXI_STRB_WIDTH = (AXI_DATA_WIDTH/8);
parameter AXI_ID_WIDTH = 8;
parameter AXI_MAX_BURST_LEN = 16;
parameter AXIS_DATA_WIDTH = AXI_DATA_WIDTH;
parameter AXIS_KEEP_ENABLE = (AXIS_DATA_WIDTH>8);
parameter AXIS_KEEP_WIDTH = (AXIS_DATA_WIDTH/8);
parameter AXIS_LAST_ENABLE = 1;
parameter AXIS_ID_ENABLE = 1;
parameter AXIS_ID_WIDTH = 8;
parameter AXIS_DEST_ENABLE = 0;
parameter AXIS_DEST_WIDTH = 8;
parameter AXIS_USER_ENABLE = 1;
parameter AXIS_USER_WIDTH = 1;
parameter LEN_WIDTH = 20;
parameter TAG_WIDTH = 8;
parameter ENABLE_SG = 0;
parameter ENABLE_UNALIGNED = 1;
parameter IMEM_SIZE_BYTES = 8192;
parameter DMEM_SIZE_BYTES = 32768;
parameter INTERLEAVE      = 1;
parameter PIPELINE_OUTPUT = 0;
parameter STAT_ADDR_WIDTH = 1;
parameter ENABLE_PADDING = 1;
parameter ENABLE_DIC = 1;
parameter MIN_FRAME_LENGTH = 64;
parameter TX_FRAME_FIFO = 1;
parameter TX_DROP_WHEN_FULL = 0;
parameter RX_FRAME_FIFO = 1;

// Inputs
reg  rx_clk = 0;
reg  rx_rst = 0;
reg  tx_clk = 0;
reg  tx_rst = 0;
reg  logic_clk = 0;
reg  logic_rst = 0;
reg  [7:0] current_test = 0;

reg  [AXI_ADDR_WIDTH-1:0] s_axis_tx_desc_addr = 0;
reg  [LEN_WIDTH-1:0] s_axis_tx_desc_len = 0;
reg  [TAG_WIDTH-1:0] s_axis_tx_desc_tag = 0;
reg  [AXIS_USER_WIDTH-1:0] s_axis_tx_desc_user = 0;
reg  s_axis_tx_desc_valid = 0;
reg  [AXI_ADDR_WIDTH-1:0] s_axis_rx_desc_addr = 0;
reg  [LEN_WIDTH-1:0] s_axis_rx_desc_len = 0;
reg  [TAG_WIDTH-1:0] s_axis_rx_desc_tag = 0;
reg  s_axis_rx_desc_valid = 0;

reg [AXI_ID_WIDTH-1:0]   mc_axi_awid;
reg [AXI_ADDR_WIDTH-1:0] mc_axi_awaddr;
reg [7:0]                mc_axi_awlen;
reg [2:0]                mc_axi_awsize;
reg [1:0]                mc_axi_awburst;
reg                      mc_axi_awlock;
reg [3:0]                mc_axi_awcache;
reg [2:0]                mc_axi_awprot;
reg                      mc_axi_awvalid;
reg [AXI_DATA_WIDTH-1:0] mc_axi_wdata;
reg [AXI_STRB_WIDTH-1:0] mc_axi_wstrb;
reg                      mc_axi_wlast;
reg                      mc_axi_wvalid;
reg                      mc_axi_bready;
reg [AXI_ID_WIDTH-1:0]   mc_axi_arid;
reg [AXI_ADDR_WIDTH-1:0] mc_axi_araddr;
reg [7:0]                mc_axi_arlen;
reg [2:0]                mc_axi_arsize;
reg [1:0]                mc_axi_arburst;
reg                      mc_axi_arlock;
reg [3:0]                mc_axi_arcache;
reg [2:0]                mc_axi_arprot;
reg                      mc_axi_arvalid;
reg                      mc_axi_rready;

reg  tx_enable = 0;
reg  rx_enable = 0;
reg  rx_abort = 0;
reg [DATA_WIDTH-1:0] xgmii_rxd = 0;
reg [CTRL_WIDTH-1:0] xgmii_rxc = 0;
reg [7:0] ifg_delay = 0;

// Outputs
wire s_axis_tx_desc_ready;
wire [TAG_WIDTH-1:0] m_axis_tx_desc_status_tag;
wire m_axis_tx_desc_status_valid;
wire s_axis_rx_desc_ready;
wire [LEN_WIDTH-1:0] m_axis_rx_desc_status_len;
wire [TAG_WIDTH-1:0] m_axis_rx_desc_status_tag;
wire [AXIS_USER_WIDTH-1:0] m_axis_rx_desc_status_user;
wire m_axis_rx_desc_status_valid;

wire                      mc_axi_awready;
wire                      mc_axi_wready;
wire [AXI_ID_WIDTH-1:0]   mc_axi_bid;
wire [1:0]                mc_axi_bresp;
wire                      mc_axi_bvalid;
wire                      mc_axi_arready;
wire [AXI_ID_WIDTH-1:0]   mc_axi_rid;
wire [AXI_DATA_WIDTH-1:0] mc_axi_rdata;
wire [1:0]                mc_axi_rresp;
wire                      mc_axi_rlast;
wire                      mc_axi_rvalid;

wire [DATA_WIDTH-1:0] xgmii_txd;
wire [CTRL_WIDTH-1:0] xgmii_txc;

wire rx_error_bad_frame;
wire rx_error_bad_fcs;
wire tx_fifo_overflow;
wire tx_fifo_bad_frame;
wire tx_fifo_good_frame;
wire rx_fifo_overflow;
wire rx_fifo_bad_frame;
wire rx_fifo_good_frame;

wire status_update;

// Internal wires
wire [S_COUNT*AXI_ID_WIDTH-1:0] m_axi_awid;
wire [S_COUNT*AXI_ADDR_WIDTH-1:0] m_axi_awaddr;
wire [S_COUNT*8-1:0] m_axi_awlen;
wire [S_COUNT*3-1:0] m_axi_awsize;
wire [S_COUNT*2-1:0] m_axi_awburst;
wire [S_COUNT-1:0] m_axi_awlock;
wire [S_COUNT*4-1:0] m_axi_awcache;
wire [S_COUNT*3-1:0] m_axi_awprot;
wire [S_COUNT-1:0] m_axi_awvalid;
wire [S_COUNT*AXI_DATA_WIDTH-1:0] m_axi_wdata;
wire [S_COUNT*AXI_STRB_WIDTH-1:0] m_axi_wstrb;
wire [S_COUNT-1:0] m_axi_wlast;
wire [S_COUNT-1:0] m_axi_wvalid;
wire [S_COUNT-1:0] m_axi_bready;
wire [S_COUNT*AXI_ID_WIDTH-1:0] m_axi_arid;
wire [S_COUNT*AXI_ADDR_WIDTH-1:0] m_axi_araddr;
wire [S_COUNT*8-1:0] m_axi_arlen;
wire [S_COUNT*3-1:0] m_axi_arsize;
wire [S_COUNT*2-1:0] m_axi_arburst;
wire [S_COUNT-1:0] m_axi_arlock;
wire [S_COUNT*4-1:0] m_axi_arcache;
wire [S_COUNT*3-1:0] m_axi_arprot;
wire [S_COUNT-1:0] m_axi_arvalid;
wire [S_COUNT-1:0] m_axi_rready;

wire [S_COUNT-1:0] m_axi_awready;
wire [S_COUNT-1:0] m_axi_wready;
wire [S_COUNT*AXI_ID_WIDTH-1:0] m_axi_bid;
wire [S_COUNT*2-1:0] m_axi_bresp;
wire [S_COUNT-1:0] m_axi_bvalid;
wire [S_COUNT-1:0] m_axi_arready;
wire [S_COUNT*AXI_ID_WIDTH-1:0] m_axi_rid;
wire [S_COUNT*AXI_DATA_WIDTH-1:0] m_axi_rdata;
wire [S_COUNT*2-1:0] m_axi_rresp;
wire [S_COUNT-1:0] m_axi_rlast;
wire [S_COUNT-1:0] m_axi_rvalid;

wire [M_COUNT*AXI_ID_WIDTH-1:0] s_axi_awid;
wire [M_COUNT*AXI_ADDR_WIDTH-1:0] s_axi_awaddr;
wire [M_COUNT*8-1:0] s_axi_awlen;
wire [M_COUNT*3-1:0] s_axi_awsize;
wire [M_COUNT*2-1:0] s_axi_awburst;
wire [M_COUNT-1:0] s_axi_awlock;
wire [M_COUNT*4-1:0] s_axi_awcache;
wire [M_COUNT*3-1:0] s_axi_awprot;
wire [M_COUNT-1:0] s_axi_awvalid;
wire [M_COUNT*AXI_DATA_WIDTH-1:0] s_axi_wdata;
wire [M_COUNT*AXI_STRB_WIDTH-1:0] s_axi_wstrb;
wire [M_COUNT-1:0] s_axi_wlast;
wire [M_COUNT-1:0] s_axi_wvalid;
wire [M_COUNT-1:0] s_axi_bready;
wire [M_COUNT*AXI_ID_WIDTH-1:0] s_axi_arid;
wire [M_COUNT*AXI_ADDR_WIDTH-1:0] s_axi_araddr;
wire [M_COUNT*8-1:0] s_axi_arlen;
wire [M_COUNT*3-1:0] s_axi_arsize;
wire [M_COUNT*2-1:0] s_axi_arburst;
wire [M_COUNT-1:0] s_axi_arlock;
wire [M_COUNT*4-1:0] s_axi_arcache;
wire [M_COUNT*3-1:0] s_axi_arprot;
wire [M_COUNT-1:0] s_axi_arvalid;
wire [M_COUNT-1:0] s_axi_rready;

wire [M_COUNT-1:0] s_axi_awready;
wire [M_COUNT-1:0] s_axi_wready;
wire [M_COUNT*AXI_ID_WIDTH-1:0] s_axi_bid;
wire [M_COUNT*2-1:0] s_axi_bresp;
wire [M_COUNT-1:0] s_axi_bvalid;
wire [M_COUNT-1:0] s_axi_arready;
wire [M_COUNT*AXI_ID_WIDTH-1:0] s_axi_rid;
wire [M_COUNT*AXI_DATA_WIDTH-1:0] s_axi_rdata;
wire [M_COUNT*2-1:0] s_axi_rresp;
wire [M_COUNT-1:0] s_axi_rlast;
wire [M_COUNT-1:0] s_axi_rvalid;

// connection to testbench master controller
assign m_axi_awid[1*AXI_ID_WIDTH +: AXI_ID_WIDTH] = mc_axi_awid;
assign m_axi_awaddr[1*AXI_ADDR_WIDTH +: AXI_ADDR_WIDTH] = mc_axi_awaddr;
assign m_axi_awlen[1*8 +: 8] =  mc_axi_awlen;
assign m_axi_awsize[1*3 +: 3] = mc_axi_awsize;
assign m_axi_awburst[1*2 +: 2] = mc_axi_awburst;
assign m_axi_awlock[1] = mc_axi_awlock;
assign m_axi_awcache[1*4 +: 4] = mc_axi_awcache;
assign m_axi_awprot[1*3 +: 3] = mc_axi_awprot;
assign m_axi_awvalid[1] = mc_axi_awvalid;
assign m_axi_wdata[1*AXI_DATA_WIDTH +: AXI_DATA_WIDTH] = mc_axi_wdata;
assign m_axi_wstrb[1*AXI_STRB_WIDTH +: AXI_STRB_WIDTH] =  mc_axi_wstrb;
assign m_axi_wlast[1] = mc_axi_wlast;
assign m_axi_wvalid[1] = mc_axi_wvalid;
assign m_axi_bready[1] = mc_axi_bready;
assign m_axi_arid[1*AXI_ID_WIDTH +: AXI_ID_WIDTH] = mc_axi_arid;
assign m_axi_araddr[1*AXI_ADDR_WIDTH +: AXI_ADDR_WIDTH] = mc_axi_araddr;
assign m_axi_arlen[1*8 +: 8] = mc_axi_arlen;
assign m_axi_arsize[1*3 +: 3] = mc_axi_arsize;
assign m_axi_arburst[1*2 +: 2] = mc_axi_arburst;
assign m_axi_arlock[1] = mc_axi_arlock;
assign m_axi_arcache[1*4 +: 4] = mc_axi_arcache;
assign m_axi_arprot[1*3 +: 3] = mc_axi_arprot;
assign m_axi_arvalid[1] = mc_axi_arvalid;
assign m_axi_rready[1] = mc_axi_rready;

assign mc_axi_awready = m_axi_awready[1];
assign mc_axi_wready  = m_axi_wready[1];
assign mc_axi_bid     = m_axi_bid[1*AXI_ID_WIDTH +: AXI_ID_WIDTH];
assign mc_axi_bresp   = m_axi_bresp[1*2 +: 2];
assign mc_axi_bvalid  = m_axi_bvalid[1];
assign mc_axi_arready = m_axi_arready[1];
assign mc_axi_rid     = m_axi_rid[1*AXI_ID_WIDTH +: AXI_ID_WIDTH];
assign mc_axi_rdata   = m_axi_rdata[1*AXI_DATA_WIDTH +: AXI_DATA_WIDTH];
assign mc_axi_rresp   = m_axi_rresp[1*2 +: 2];
assign mc_axi_rlast   = m_axi_rlast[1];
assign mc_axi_rvalid  = m_axi_rvalid[1];

// Integration to myhdl
initial begin
    // myhdl integration
    $from_myhdl(
        logic_clk,
        logic_rst,
        rx_clk,
        rx_rst,
        tx_clk,
        tx_rst,
        current_test,

        s_axis_tx_desc_addr,
        s_axis_tx_desc_len,
        s_axis_tx_desc_tag,
        s_axis_tx_desc_user,
        s_axis_tx_desc_valid,
        s_axis_rx_desc_addr,
        s_axis_rx_desc_len,
        s_axis_rx_desc_tag,
        s_axis_rx_desc_valid,

        mc_axi_awid,
        mc_axi_awaddr,
        mc_axi_awlen,
        mc_axi_awsize,
        mc_axi_awburst,
        mc_axi_awlock,
        mc_axi_awcache,
        mc_axi_awprot,
        mc_axi_awvalid,
        mc_axi_wdata,
        mc_axi_wstrb,
        mc_axi_wlast,
        mc_axi_wvalid,
        mc_axi_bready,
        mc_axi_arid,
        mc_axi_araddr,
        mc_axi_arlen,
        mc_axi_arsize,
        mc_axi_arburst,
        mc_axi_arlock,
        mc_axi_arcache,
        mc_axi_arprot,
        mc_axi_arvalid,
        mc_axi_rready,
        
        xgmii_rxd,
        xgmii_rxc,
        ifg_delay,

        tx_enable,
        rx_enable,
        rx_abort
    );
    $to_myhdl(
        s_axis_tx_desc_ready,
        m_axis_tx_desc_status_tag,
        m_axis_tx_desc_status_valid,
        s_axis_rx_desc_ready,
        m_axis_rx_desc_status_len,
        m_axis_rx_desc_status_tag,
        m_axis_rx_desc_status_user,
        m_axis_rx_desc_status_valid,

        mc_axi_awready,
        mc_axi_wready,
        mc_axi_bid,
        mc_axi_bresp,
        mc_axi_bvalid,
        mc_axi_arready,
        mc_axi_rid,
        mc_axi_rdata,
        mc_axi_rresp,
        mc_axi_rlast,
        mc_axi_rvalid,
        
        xgmii_txd,
        xgmii_txc,
        rx_error_bad_frame,
        rx_error_bad_fcs,
        tx_fifo_overflow,
        tx_fifo_bad_frame,
        tx_fifo_good_frame,
        rx_fifo_overflow,
        rx_fifo_bad_frame,
        rx_fifo_good_frame,

        status_update
    );

    // dump file
    $dumpfile("test_riscv_with_interconnect.lxt");
    $dumpvars(0, test_riscv_with_interconnect);
end

eth_interface #(
    .DATA_WIDTH(DATA_WIDTH),
    .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
    .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
    .AXI_ID_WIDTH(AXI_ID_WIDTH),
    .AXI_MAX_BURST_LEN(AXI_MAX_BURST_LEN),
    .LEN_WIDTH(LEN_WIDTH),
    .TAG_WIDTH(TAG_WIDTH),
    .ENABLE_SG(ENABLE_SG),
    .ENABLE_UNALIGNED(ENABLE_UNALIGNED),
    .ENABLE_PADDING(ENABLE_PADDING),
    .ENABLE_DIC(ENABLE_DIC),
    .MIN_FRAME_LENGTH(MIN_FRAME_LENGTH),
    .TX_FRAME_FIFO(TX_FRAME_FIFO),
    .TX_DROP_WHEN_FULL(TX_DROP_WHEN_FULL),
    .RX_FRAME_FIFO(RX_FRAME_FIFO)  
)
eth_dma (
    .logic_clk(logic_clk),
    .logic_rst(logic_rst),
    .rx_clk(rx_clk),
    .rx_rst(rx_rst),
    .tx_clk(tx_clk),
    .tx_rst(tx_rst),

    .s_axis_tx_desc_addr(s_axis_tx_desc_addr),
    .s_axis_tx_desc_len(s_axis_tx_desc_len),
    .s_axis_tx_desc_tag(s_axis_tx_desc_tag),
    .s_axis_tx_desc_user(s_axis_tx_desc_user),
    .s_axis_tx_desc_valid(s_axis_tx_desc_valid),
    .s_axis_tx_desc_ready(s_axis_tx_desc_ready),

    .m_axis_tx_desc_status_tag(m_axis_tx_desc_status_tag),
    .m_axis_tx_desc_status_valid(m_axis_tx_desc_status_valid),

    .s_axis_rx_desc_addr(s_axis_rx_desc_addr),
    .s_axis_rx_desc_len(s_axis_rx_desc_len),
    .s_axis_rx_desc_tag(s_axis_rx_desc_tag),
    .s_axis_rx_desc_valid(s_axis_rx_desc_valid),
    .s_axis_rx_desc_ready(s_axis_rx_desc_ready),

    .m_axis_rx_desc_status_len(m_axis_rx_desc_status_len),
    .m_axis_rx_desc_status_tag(m_axis_rx_desc_status_tag),
    .m_axis_rx_desc_status_user(m_axis_rx_desc_status_user),
    .m_axis_rx_desc_status_valid(m_axis_rx_desc_status_valid),

    .m_axi_awid(m_axi_awid[0 +: AXI_ID_WIDTH]),
    .m_axi_awaddr(m_axi_awaddr[0 +: AXI_ADDR_WIDTH]),
    .m_axi_awlen(m_axi_awlen[0 +: 8]),
    .m_axi_awsize(m_axi_awsize[0 +: 3]),
    .m_axi_awburst(m_axi_awburst[0 +: 2]),
    .m_axi_awlock(m_axi_awlock[0]),
    .m_axi_awcache(m_axi_awcache[0 +: 4]),
    .m_axi_awprot(m_axi_awprot[0 +: 3]),
    .m_axi_awvalid(m_axi_awvalid[0]),
    .m_axi_awready(m_axi_awready[0]),
    .m_axi_wdata(m_axi_wdata[0 +: AXI_DATA_WIDTH]),
    .m_axi_wstrb(m_axi_wstrb[0 +: AXI_STRB_WIDTH]),
    .m_axi_wlast(m_axi_wlast[0]),
    .m_axi_wvalid(m_axi_wvalid[0]),
    .m_axi_wready(m_axi_wready[0]),
    .m_axi_bid(m_axi_bid[0 +: AXI_ID_WIDTH]),
    .m_axi_bresp(m_axi_bresp[0 +: 2]),
    .m_axi_bvalid(m_axi_bvalid[0]),
    .m_axi_bready(m_axi_bready[0]),
    .m_axi_arid(m_axi_arid[0 +: AXI_ID_WIDTH]),
    .m_axi_araddr(m_axi_araddr[0 +: AXI_ADDR_WIDTH]),
    .m_axi_arlen(m_axi_arlen[0 +: 8]),
    .m_axi_arsize(m_axi_arsize[0 +: 3]),
    .m_axi_arburst(m_axi_arburst[0 +: 2]),
    .m_axi_arlock(m_axi_arlock[0]),
    .m_axi_arcache(m_axi_arcache[0 +: 4]),
    .m_axi_arprot(m_axi_arprot[0 +: 3]),
    .m_axi_arvalid(m_axi_arvalid[0]),
    .m_axi_arready(m_axi_arready[0]),
    .m_axi_rid(m_axi_rid[0 +: AXI_ID_WIDTH]),
    .m_axi_rdata(m_axi_rdata[0 +: AXI_DATA_WIDTH]),
    .m_axi_rresp(m_axi_rresp[0 +: 2]),
    .m_axi_rlast(m_axi_rlast[0]),
    .m_axi_rvalid(m_axi_rvalid[0]),
    .m_axi_rready(m_axi_rready[0]),

    .xgmii_rxd(xgmii_rxd),
    .xgmii_rxc(xgmii_rxc),
    .xgmii_txd(xgmii_txd),
    .xgmii_txc(xgmii_txc),
    
    .rx_error_bad_frame(rx_error_bad_frame),
    .rx_error_bad_fcs(rx_error_bad_fcs),
    
    .tx_fifo_overflow(tx_fifo_overflow),
    .tx_fifo_bad_frame(tx_fifo_bad_frame),
    .tx_fifo_good_frame(tx_fifo_good_frame),
    
    .rx_fifo_overflow(rx_fifo_overflow),
    .rx_fifo_bad_frame(rx_fifo_bad_frame),
    .rx_fifo_good_frame(rx_fifo_good_frame),

    .tx_enable(tx_enable),
    .rx_enable(rx_enable),
    .rx_abort(rx_abort),
    .ifg_delay(ifg_delay)
);

axi_interconnect #
(
    .S_COUNT(S_COUNT),
    .M_COUNT(M_COUNT),
    .DATA_WIDTH(AXI_DATA_WIDTH),
    .ADDR_WIDTH(AXI_ADDR_WIDTH),
    .STRB_WIDTH(AXI_STRB_WIDTH),
    .ID_WIDTH(AXI_ID_WIDTH),
    .FORWARD_ID(FORWARD_ID),
    .M_REGIONS(M_REGIONS),
    .M_BASE_ADDR(M_BASE_ADDR),
    .M_ADDR_WIDTH(M_ADDR_WIDTH),
    .M_CONNECT_READ(M_CONNECT_READ),
    .M_CONNECT_WRITE(M_CONNECT_WRITE),
    .M_SECURE(M_SECURE)
)
interconnect (
    .clk(logic_clk),
    .rst(logic_rst),
    .s_axi_awid(m_axi_awid),
    .s_axi_awaddr(m_axi_awaddr),
    .s_axi_awlen(m_axi_awlen),
    .s_axi_awsize(m_axi_awsize),
    .s_axi_awburst(m_axi_awburst),
    .s_axi_awlock(m_axi_awlock),
    .s_axi_awcache(m_axi_awcache),
    .s_axi_awprot(m_axi_awprot),
    .s_axi_awqos(),
    .s_axi_awuser(),
    .s_axi_awvalid(m_axi_awvalid),
    .s_axi_awready(m_axi_awready),
    .s_axi_wdata(m_axi_wdata),
    .s_axi_wstrb(m_axi_wstrb),
    .s_axi_wlast(m_axi_wlast),
    .s_axi_wuser(),
    .s_axi_wvalid(m_axi_wvalid),
    .s_axi_wready(m_axi_wready),
    .s_axi_bid(m_axi_bid),
    .s_axi_bresp(m_axi_bresp),
    .s_axi_buser(),
    .s_axi_bvalid(m_axi_bvalid),
    .s_axi_bready(m_axi_bready),
    .s_axi_arid(m_axi_arid),
    .s_axi_araddr(m_axi_araddr),
    .s_axi_arlen(m_axi_arlen),
    .s_axi_arsize(m_axi_arsize),
    .s_axi_arburst(m_axi_arburst),
    .s_axi_arlock(m_axi_arlock),
    .s_axi_arcache(m_axi_arcache),
    .s_axi_arprot(m_axi_arprot),
    .s_axi_arqos(),
    .s_axi_aruser(),
    .s_axi_arvalid(m_axi_arvalid),
    .s_axi_arready(m_axi_arready),
    .s_axi_rid(m_axi_rid),
    .s_axi_rdata(m_axi_rdata),
    .s_axi_rresp(m_axi_rresp),
    .s_axi_rlast(m_axi_rlast),
    .s_axi_ruser(),
    .s_axi_rvalid(m_axi_rvalid),
    .s_axi_rready(m_axi_rready),
    .m_axi_awid(s_axi_awid),
    .m_axi_awaddr(s_axi_awaddr),
    .m_axi_awlen(s_axi_awlen),
    .m_axi_awsize(s_axi_awsize),
    .m_axi_awburst(s_axi_awburst),
    .m_axi_awlock(s_axi_awlock),
    .m_axi_awcache(s_axi_awcache),
    .m_axi_awprot(s_axi_awprot),
    .m_axi_awqos(),
    .m_axi_awregion(),
    .m_axi_awuser(),
    .m_axi_awvalid(s_axi_awvalid),
    .m_axi_awready(s_axi_awready),
    .m_axi_wdata(s_axi_wdata),
    .m_axi_wstrb(s_axi_wstrb),
    .m_axi_wlast(s_axi_wlast),
    .m_axi_wuser(),
    .m_axi_wvalid(s_axi_wvalid),
    .m_axi_wready(s_axi_wready),
    .m_axi_bid(s_axi_bid),
    .m_axi_bresp(s_axi_bresp),
    .m_axi_buser(),
    .m_axi_bvalid(s_axi_bvalid),
    .m_axi_bready(s_axi_bready),
    .m_axi_arid(s_axi_arid),
    .m_axi_araddr(s_axi_araddr),
    .m_axi_arlen(s_axi_arlen),
    .m_axi_arsize(s_axi_arsize),
    .m_axi_arburst(s_axi_arburst),
    .m_axi_arlock(s_axi_arlock),
    .m_axi_arcache(s_axi_arcache),
    .m_axi_arprot(s_axi_arprot),
    .m_axi_arqos(),
    .m_axi_arregion(),
    .m_axi_aruser(),
    .m_axi_arvalid(s_axi_arvalid),
    .m_axi_arready(s_axi_arready),
    .m_axi_rid(s_axi_rid),
    .m_axi_rdata(s_axi_rdata),
    .m_axi_rresp(s_axi_rresp),
    .m_axi_rlast(s_axi_rlast),
    .m_axi_ruser(),
    .m_axi_rvalid(s_axi_rvalid),
    .m_axi_rready(s_axi_rready)
);

riscv_axi_wrapper #(
    .DATA_WIDTH(AXI_DATA_WIDTH),
    .ADDR_WIDTH(AXI_ADDR_WIDTH),
    .ID_WIDTH(AXI_ID_WIDTH),
    .PIPELINE_OUTPUT(PIPELINE_OUTPUT),
    .IMEM_SIZE_BYTES(IMEM_SIZE_BYTES),
    .DMEM_SIZE_BYTES(DMEM_SIZE_BYTES),
    .STAT_ADDR_WIDTH(STAT_ADDR_WIDTH),
    .INTERLEAVE(INTERLEAVE)
)
RISCV (
    .clk(logic_clk),
    .rst(logic_rst),
    .s_axi_awid(s_axi_awid),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awlen(s_axi_awlen),
    .s_axi_awsize(s_axi_awsize),
    .s_axi_awburst(s_axi_awburst),
    .s_axi_awlock(s_axi_awlock),
    .s_axi_awcache(s_axi_awcache),
    .s_axi_awprot(s_axi_awprot),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wlast(s_axi_wlast),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bid(s_axi_bid),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_arid(s_axi_arid),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arlen(s_axi_arlen),
    .s_axi_arsize(s_axi_arsize),
    .s_axi_arburst(s_axi_arburst),
    .s_axi_arlock(s_axi_arlock),
    .s_axi_arcache(s_axi_arcache),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rid(s_axi_rid),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rlast(s_axi_rlast),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),

    .status_update(status_update)
);


integer i,j;

initial begin
    // two nested loops for smaller number of iterations per loop
    // workaround for synthesizer complaints about large loop counts
    for (i = 0; i < 2**(AXI_ADDR_WIDTH-1); i = i + 2**((AXI_ADDR_WIDTH-1)/2)) begin
        for (j = i; j < i + 2**((AXI_ADDR_WIDTH-1)/2); j = j + 1) begin
            RISCV.core.dmem.mem[j] = 0;
        end
    end
end

// For now before adding second DMA master for instructions
initial begin
    $readmemh("../../riscv_code/test.hex", RISCV.core.imem.mem);
end 
  
endmodule

`resetall
