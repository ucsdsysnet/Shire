/*

Copyright (c) 2019-2021 Moein Khazraee

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

module simple_sync_fifo # (
  parameter DEPTH      = 32,
  parameter DATA_WIDTH = 64
)(
  input  wire                  clk,
  input  wire                  rst,

  input  wire                  din_valid,
  input  wire [DATA_WIDTH-1:0] din,
  output wire                  din_ready,

  output wire                  dout_valid,
  output wire [DATA_WIDTH-1:0] dout,
  input  wire                  dout_ready
);

  axis_fifo # (
    .DEPTH(DEPTH),
    .DATA_WIDTH(DATA_WIDTH),
    .KEEP_ENABLE(0),
    .KEEP_WIDTH(1),
    .LAST_ENABLE(0),
    .ID_ENABLE(0),
    .DEST_ENABLE(0),
    .USER_ENABLE(0),
    .PIPELINE_OUTPUT(2),
    .FRAME_FIFO(0)
  ) sync_fifo_inst (
    .clk(clk),
    .rst(rst),

    .s_axis_tdata(din),
    .s_axis_tkeep(1'b0),
    .s_axis_tvalid(din_valid),
    .s_axis_tready(din_ready),
    .s_axis_tlast(1'b1),
    .s_axis_tid(8'd0),
    .s_axis_tdest(8'd0),
    .s_axis_tuser(1'b0),

    .m_axis_tdata(dout),
    .m_axis_tkeep(),
    .m_axis_tvalid(dout_valid),
    .m_axis_tready(dout_ready),
    .m_axis_tlast(),
    .m_axis_tid(),
    .m_axis_tdest(),
    .m_axis_tuser(),

    .status_overflow(),
    .status_bad_frame(),
    .status_good_frame()
  );

endmodule

module simple_fifo # (
  parameter ADDR_WIDTH = 5,
  parameter DATA_WIDTH = 32,
  parameter INIT_ZERO  = 0
)(
  input  wire                  clk,
  input  wire                  rst,
  input  wire                  clear,

  input  wire                  din_valid,
  input  wire [DATA_WIDTH-1:0] din,
  output wire                  din_ready,

  output wire                  dout_valid,
  output wire [DATA_WIDTH-1:0] dout,
  input  wire                  dout_ready,

  output wire [ADDR_WIDTH:0]   item_count,
  output wire                  full,
  output wire                  empty
);

reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];
reg [ADDR_WIDTH-1:0] rptr, wptr;
reg [ADDR_WIDTH:0]   item_count_r;

wire enque = din_valid  & din_ready;
wire deque = dout_valid & dout_ready;

always @ (posedge clk)
  if (rst || clear) begin
    wptr <= {ADDR_WIDTH{1'b0}};
    rptr <= {ADDR_WIDTH{1'b0}};
  end else begin
    if (enque) begin
      mem[wptr] <= din;
      wptr      <= wptr + {{(ADDR_WIDTH-1){1'b0}},1'b1};
    end
    if (deque) begin
      rptr      <= rptr + {{(ADDR_WIDTH-1){1'b0}},1'b1};
    end
  end

assign dout = mem[rptr];

// Latching last transaction to know FIFO is full or empty
reg full_r, empty_r;

always @ (posedge clk)
  if (rst || clear) begin
    full_r  <= 1'b0;
    empty_r <= 1'b1;
  end else if (enque ^ deque) begin
    full_r  <= ((wptr + {{(ADDR_WIDTH-1){1'b0}},1'b1}) == rptr) && enque;
    empty_r <= ((rptr + {{(ADDR_WIDTH-1){1'b0}},1'b1}) == wptr) && deque;
  end

always @ (posedge clk)
  if (rst || clear)
    item_count_r <= {(ADDR_WIDTH+1){1'b0}};
  else
    if (enque && !deque)
      item_count_r <= item_count_r + {{(ADDR_WIDTH){1'b0}},1'b1};
    else if (!enque && deque)
      item_count_r <= item_count_r - {{(ADDR_WIDTH){1'b0}},1'b1};

assign empty = empty_r;
assign full  = full_r;

assign din_ready  = ~full_r & ~rst & ~clear;
assign dout_valid = ~empty_r;

assign item_count = item_count_r;

integer i;
initial begin
  if (INIT_ZERO)
    for (i=0; i<2**ADDR_WIDTH; i=i+1)
      mem[i] <= {DATA_WIDTH{1'b0}};
end

endmodule

module simple_pipe_reg # (
  parameter DATA_WIDTH = 64,
  parameter REG_TYPE   = 2,
  parameter REG_LENGTH = 1
) (
  input  wire                  clk,
  input  wire                  rst,

  input  wire [DATA_WIDTH-1:0] s_data,
  input  wire                  s_valid,
  output wire                  s_ready,

  output wire [DATA_WIDTH-1:0] m_data,
  output wire                  m_valid,
  input  wire                  m_ready
);

axis_pipeline_register # (
  .DATA_WIDTH(DATA_WIDTH),
  .KEEP_ENABLE(0),
  .KEEP_WIDTH(1),
  .LAST_ENABLE(0),
  .DEST_ENABLE(0),
  .USER_ENABLE(0),
  .ID_ENABLE(0),
  .REG_TYPE(REG_TYPE),
  .LENGTH(REG_LENGTH)
) simple_reg (
  .clk(clk),
  .rst(rst),

  .s_axis_tdata(s_data),
  .s_axis_tkeep(1'b0),
  .s_axis_tvalid(s_valid),
  .s_axis_tready(s_ready),
  .s_axis_tlast(1'b0),
  .s_axis_tid(8'd0),
  .s_axis_tdest(8'd0),
  .s_axis_tuser(1'b0),

  .m_axis_tdata(m_data),
  .m_axis_tkeep(),
  .m_axis_tvalid(m_valid),
  .m_axis_tready(m_ready),
  .m_axis_tlast(),
  .m_axis_tid(),
  .m_axis_tdest(),
  .m_axis_tuser()
);

endmodule

`resetall
