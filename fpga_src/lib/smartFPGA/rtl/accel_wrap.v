module accel_wrap #(
  parameter DATA_WIDTH           = 128,
  parameter STRB_WIDTH           = (DATA_WIDTH/8),
  parameter SLOW_DMEM_ADDR_WIDTH = 8,
  parameter ADDR_WIDTH           = SLOW_DMEM_ADDR_WIDTH+2,
  parameter SLOW_M_B_LINES       = 4096,
  parameter ACC_ADDR_WIDTH       = $clog2(SLOW_M_B_LINES),
  parameter SLOW_DMEM_SEL_BITS   = SLOW_DMEM_ADDR_WIDTH-$clog2(STRB_WIDTH)
                                   -1-$clog2(SLOW_M_B_LINES),
  parameter ACC_MEM_BLOCKS       = 2**SLOW_DMEM_SEL_BITS
) (
  input  wire                                     clk,
  input  wire                                     rst,

  input  wire [ADDR_WIDTH-1:0]                    io_addr,
  input  wire [STRB_WIDTH-1:0]                    io_strb,
  input  wire                                     io_write,
  input  wire                                     io_read,
  output wire [DATA_WIDTH-1:0]                    io_rd_data,
  input  wire [DATA_WIDTH-1:0]                    io_wr_data,

  output wire [ACC_MEM_BLOCKS-1:0]                acc_en_b1,
  output wire [ACC_MEM_BLOCKS*STRB_WIDTH-1:0]     acc_wen_b1,
  output wire [ACC_MEM_BLOCKS*ACC_ADDR_WIDTH-1:0] acc_addr_b1,
  output wire [ACC_MEM_BLOCKS*DATA_WIDTH-1:0]     acc_wr_data_b1,
  input  wire [ACC_MEM_BLOCKS*DATA_WIDTH-1:0]     acc_rd_data_b1,

  output wire [ACC_MEM_BLOCKS-1:0]                acc_en_b2,
  output wire [ACC_MEM_BLOCKS*STRB_WIDTH-1:0]     acc_wen_b2,
  output wire [ACC_MEM_BLOCKS*ACC_ADDR_WIDTH-1:0] acc_addr_b2,
  output wire [ACC_MEM_BLOCKS*DATA_WIDTH-1:0]     acc_wr_data_b2,
  input  wire [ACC_MEM_BLOCKS*DATA_WIDTH-1:0]     acc_rd_data_b2
);

assign acc_en_b1 = 0;
assign acc_wen_b1 = 0;
assign acc_addr_b1 = 0;
assign acc_wr_data_b1 = 0;

assign acc_en_b2 = 0;
assign acc_wen_b2 = 0;
assign acc_addr_b2 = 0;
assign acc_wr_data_b2 = 0;

assign io_rd_data = 0;

endmodule