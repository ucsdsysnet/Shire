/*

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

`timescale 1ns / 1ps

/*
 * AXI4 crossbar address decode and admission control
 */
module axi_crossbar_addr #
(
    parameter S = 0,
    parameter S_COUNT = 4,
    parameter M_COUNT = 4,
    parameter ADDR_WIDTH = 32,
    parameter ID_WIDTH = 8,
    parameter S_THREADS = 32'd2,
    parameter S_ACCEPT = 32'd16,
    parameter M_REGIONS = 1,
    parameter M_BASE_ADDR = {32'h03000000, 32'h02000000, 32'h01000000, 32'h00000000},
    parameter M_ADDR_WIDTH = {M_COUNT{{M_REGIONS{32'd24}}}},
    parameter M_CONNECT = {M_COUNT{{S_COUNT{1'b1}}}},
    parameter M_SECURE = {M_COUNT{1'b0}},
    parameter WC_OUTPUT = 0
)
(
    input  wire                       clk,
    input  wire                       rst,

    /*
     * Address input
     */
    input  wire [ID_WIDTH-1:0]        s_axi_aid,
    input  wire [ADDR_WIDTH-1:0]      s_axi_aaddr,
    input  wire [2:0]                 s_axi_aprot,
    input  wire [3:0]                 s_axi_aqos,
    input  wire                       s_axi_avalid,
    output wire                       s_axi_aready,

    /*
     * Address output
     */
    output wire [3:0]                 m_axi_aregion,
    output wire [$clog2(M_COUNT)-1:0] m_select,
    output wire                       m_axi_avalid,
    input  wire                       m_axi_aready,

    /*
     * Write command output
     */
    output wire [$clog2(M_COUNT)-1:0] m_wc_select,
    output wire                       m_wc_decerr,
    output wire                       m_wc_valid,
    input  wire                       m_wc_ready,

    /*
     * Reply command output
     */
    output wire                       m_rc_decerr,
    output wire                       m_rc_valid,
    input  wire                       m_rc_ready,

    /*
     * Completion input
     */
    input  wire [ID_WIDTH-1:0]        s_cpl_id,
    input  wire                       s_cpl_valid
);

parameter CL_S_COUNT = $clog2(S_COUNT);
parameter CL_M_COUNT = $clog2(M_COUNT);

parameter S_INT_THREADS = S_THREADS > S_ACCEPT ? S_ACCEPT : S_THREADS;
parameter CL_S_INT_THREADS = $clog2(S_INT_THREADS);
parameter CL_S_ACCEPT = $clog2(S_ACCEPT);

integer i, j;

// check configuration
initial begin
    if (S_ACCEPT < 1) begin
        $error("Error: need at least 1 accept");
        $finish;
    end

    if (S_THREADS < 1) begin
        $error("Error: need at least 1 thread");
        $finish;
    end

    if (S_THREADS > S_ACCEPT) begin
        $warning("Warning: requested thread count larger than accept count; limiting thread count to accept count");
    end

    if (M_REGIONS < 1) begin
        $error("Error: need at least 1 region");
        $finish;
    end

    for (i = 0; i < M_COUNT*M_REGIONS; i = i + 1) begin
        if (M_ADDR_WIDTH[i*32 +: 32] && (M_ADDR_WIDTH[i*32 +: 32] < 12 || M_ADDR_WIDTH[i*32 +: 32] > ADDR_WIDTH)) begin
            $error("Error: address width out of range");
            $finish;
        end
    end

    for (i = 0; i < M_COUNT*M_REGIONS; i = i + 1) begin
        for (j = i+1; j < M_COUNT*M_REGIONS; j = j + 1) begin
            if (M_ADDR_WIDTH[i*32 +: 32] && M_ADDR_WIDTH[j*32 +: 32]) begin
                if (((M_BASE_ADDR[i*ADDR_WIDTH +: ADDR_WIDTH] & ({ADDR_WIDTH{1'b1}} << M_ADDR_WIDTH[i*32 +: 32])) <= (M_BASE_ADDR[j*ADDR_WIDTH +: ADDR_WIDTH] | ({ADDR_WIDTH{1'b1}} >> (ADDR_WIDTH - M_ADDR_WIDTH[j*32 +: 32])))) && ((M_BASE_ADDR[j*ADDR_WIDTH +: ADDR_WIDTH] & ({ADDR_WIDTH{1'b1}} << M_ADDR_WIDTH[j*32 +: 32])) <= (M_BASE_ADDR[i*ADDR_WIDTH +: ADDR_WIDTH] | ({ADDR_WIDTH{1'b1}} >> (ADDR_WIDTH - M_ADDR_WIDTH[i*32 +: 32]))))) begin
                    $display("%d: %08x / %02d -- %08x-%08x", i, M_BASE_ADDR[i*ADDR_WIDTH +: ADDR_WIDTH], M_ADDR_WIDTH[i*32 +: 32], M_BASE_ADDR[i*ADDR_WIDTH +: ADDR_WIDTH] & ({ADDR_WIDTH{1'b1}} << M_ADDR_WIDTH[i*32 +: 32]), M_BASE_ADDR[i*ADDR_WIDTH +: ADDR_WIDTH] | ({ADDR_WIDTH{1'b1}} >> (ADDR_WIDTH - M_ADDR_WIDTH[i*32 +: 32])));
                    $display("%d: %08x / %02d -- %08x-%08x", j, M_BASE_ADDR[j*ADDR_WIDTH +: ADDR_WIDTH], M_ADDR_WIDTH[j*32 +: 32], M_BASE_ADDR[j*ADDR_WIDTH +: ADDR_WIDTH] & ({ADDR_WIDTH{1'b1}} << M_ADDR_WIDTH[j*32 +: 32]), M_BASE_ADDR[j*ADDR_WIDTH +: ADDR_WIDTH] | ({ADDR_WIDTH{1'b1}} >> (ADDR_WIDTH - M_ADDR_WIDTH[j*32 +: 32])));
                    $error("Error: address ranges overlap");
                    $finish;
                end
            end
        end
    end
end

localparam [2:0]
    STATE_IDLE = 3'd0,
    STATE_DECODE = 3'd1;

reg [2:0] state_reg = STATE_IDLE, state_next;

reg match;
reg trans_start;
reg [CL_S_INT_THREADS-1:0] trans_start_thread;
reg trans_complete;
reg [CL_S_INT_THREADS-1:0] trans_complete_thread;

reg [$clog2(S_ACCEPT+1)-1:0] trans_count_reg = 0;
wire trans_limit = trans_count_reg >= S_ACCEPT && !trans_complete;

reg [ID_WIDTH-1:0] thread_id_reg[S_INT_THREADS-1:0];
reg [CL_M_COUNT-1:0] thread_m_reg[S_INT_THREADS-1:0];
reg [3:0] thread_region_reg[S_INT_THREADS-1:0];
reg [$clog2(S_ACCEPT+1)-1:0] thread_count_reg[S_INT_THREADS-1:0];

initial begin
    for (i = 0; i < S_INT_THREADS; i = i + 1) begin
        thread_count_reg[i] <= 0;
    end
end

wire [S_INT_THREADS-1:0] thread_active;
wire [S_INT_THREADS-1:0] thread_match;
wire [S_INT_THREADS-1:0] thread_cpl_match;

generate
    genvar n;

    for (n = 0; n < S_INT_THREADS; n = n + 1) begin
        assign thread_active[n] = thread_count_reg[n] != 0;
        assign thread_match[n] = thread_active[n] && thread_id_reg[n] == s_axi_aid;
        assign thread_cpl_match[n] = thread_active[n] && thread_id_reg[n] == s_cpl_id;
    end
endgenerate

reg s_axi_aready_reg = 0, s_axi_aready_next;

reg [3:0] m_axi_aregion_reg = 4'd0, m_axi_aregion_next;
reg [CL_M_COUNT-1:0] m_select_reg = {CL_M_COUNT{1'b0}}, m_select_next;
reg m_axi_avalid_reg = 1'b0, m_axi_avalid_next;
reg m_decerr_reg = 1'b0, m_decerr_next;
reg m_wc_valid_reg = 1'b0, m_wc_valid_next;
reg m_rc_valid_reg = 1'b0, m_rc_valid_next;

assign s_axi_aready = s_axi_aready_reg;

assign m_axi_aregion = m_axi_aregion_reg;
assign m_select = m_select_reg;
assign m_axi_avalid = m_axi_avalid_reg;

assign m_wc_select = m_select_reg;
assign m_wc_decerr = m_decerr_reg;
assign m_wc_valid = m_wc_valid_reg;

assign m_rc_decerr = m_decerr_reg;
assign m_rc_valid = m_rc_valid_reg;

always @* begin
    state_next = STATE_IDLE;

    match = 1'b0;
    trans_start = 1'b0;
    trans_complete = 1'b0;

    s_axi_aready_next = 1'b0;

    m_axi_aregion_next = m_axi_aregion_reg;
    m_select_next = m_select_reg;
    m_select_next = m_select_reg;
    m_axi_avalid_next = m_axi_avalid_reg && !m_axi_aready;
    m_decerr_next = m_decerr_reg;
    m_wc_valid_next = m_wc_valid_reg && !m_wc_ready;
    m_rc_valid_next = m_rc_valid_reg && !m_rc_ready;

    case (state_reg)
        STATE_IDLE: begin
            // idle state, store values
            s_axi_aready_next = 1'b0;

            if (s_axi_avalid && !s_axi_aready) begin
                match = 1'b0;
                for (i = 0; i < M_COUNT; i = i + 1) begin
                    for (j = 0; j < M_REGIONS; j = j + 1) begin
                        if (M_ADDR_WIDTH[(i*M_REGIONS+j)*32 +: 32] && (!M_SECURE[i] || !s_axi_aprot[1]) && (M_CONNECT & (1 << (S+i*S_COUNT))) && (s_axi_aaddr >> M_ADDR_WIDTH[(i*M_REGIONS+j)*32 +: 32]) == (M_BASE_ADDR[(i*M_REGIONS+j)*ADDR_WIDTH +: ADDR_WIDTH] >> M_ADDR_WIDTH[(i*M_REGIONS+j)*32 +: 32])) begin
                            m_select_next = i;
                            m_axi_aregion_next = j;
                            match = 1'b1;
                        end
                    end
                end

                if (match) begin
                    if (!trans_limit) begin
                        m_axi_avalid_next = 1'b1;
                        m_decerr_next = 1'b0;
                        m_wc_valid_next = WC_OUTPUT;
                        m_rc_valid_next = 1'b0;
                        trans_start = 1'b1;
                        state_next = STATE_DECODE;
                    end else begin
                        state_next = STATE_IDLE;
                    end
                end else begin
                    // TODO handle decode error
                    m_axi_avalid_next = 1'b0;
                    m_decerr_next = 1'b1;
                    m_wc_valid_next = WC_OUTPUT;
                    m_rc_valid_next = 1'b1;
                    state_next = STATE_DECODE;
                end
            end else begin
                state_next = STATE_IDLE;
            end
        end
        STATE_DECODE: begin
            if (!m_axi_avalid_next && (!m_wc_valid_next || !WC_OUTPUT) && !m_rc_valid_next) begin
                s_axi_aready_next = 1'b1;
                state_next = STATE_IDLE;
            end else begin
                state_next = STATE_DECODE;
            end
        end
    endcase

    // manage completions
    trans_complete = s_cpl_valid;
end

always @(posedge clk) begin
    if (rst) begin
        state_reg <= STATE_IDLE;
        s_axi_aready_reg <= 1'b0;
        m_axi_avalid_reg <= 1'b0;
        m_wc_valid_reg <= 1'b0;
        m_rc_valid_reg <= 1'b0;

        trans_count_reg <= 0;

        for (i = 0; i < S_INT_THREADS; i = i + 1) begin
            thread_count_reg[i] <= 0;
        end
    end else begin
        state_reg <= state_next;
        s_axi_aready_reg <= s_axi_aready_next;
        m_axi_avalid_reg <= m_axi_avalid_next;
        m_wc_valid_reg <= m_wc_valid_next;
        m_rc_valid_reg <= m_rc_valid_next;

        if (trans_start && !trans_complete) begin
            trans_count_reg <= trans_count_reg + 1;
        end else if (!trans_start && trans_complete) begin
            trans_count_reg <= trans_count_reg - 1;
        end

        if (trans_start_thread == trans_complete_thread) begin
            if (trans_start && !trans_complete) begin
                thread_count_reg[trans_start_thread] <= thread_count_reg[trans_start_thread] + 1;
            end
            if (!trans_start && trans_complete) begin
                thread_count_reg[trans_complete_thread] <= thread_count_reg[trans_complete_thread] - 1;
            end
        end else begin
            if (trans_start) begin
                thread_count_reg[trans_start_thread] <= thread_count_reg[trans_start_thread] + 1;
            end
            if (trans_complete) begin
                thread_count_reg[trans_complete_thread] <= thread_count_reg[trans_complete_thread] - 1;
            end
        end
    end

    m_axi_aregion_reg <= m_axi_aregion_next;
    m_select_reg <= m_select_next;
    m_decerr_reg <= m_decerr_next;

    if (trans_start) begin
        thread_id_reg[trans_start_thread] <= s_axi_aid;
        thread_m_reg[trans_start_thread] <= m_select_next;
        thread_region_reg[trans_start_thread] <= m_axi_aregion_next;
    end
end

endmodule
