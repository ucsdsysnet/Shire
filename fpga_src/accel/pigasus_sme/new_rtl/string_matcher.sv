`include "struct_s.sv"
//`define DUMMY
module string_matcher (
    input  logic                 clk,
    input  logic                 rst,
    input  logic [FP_DWIDTH-1:0] in_pkt_data,
    input  logic                 in_pkt_valid,
    input  logic                 in_pkt_sop,
    input  logic                 in_pkt_eop,
    input  logic [FP_EWIDTH-1:0] in_pkt_empty,
    output logic                 in_pkt_ready,
    output logic [511:0]         out_usr_data,
    output logic                 out_usr_valid,
    output logic                 out_usr_sop,
    output logic                 out_usr_eop,
    output logic [5:0]           out_usr_empty,
    input  logic                 out_usr_ready
);

logic [FP_DWIDTH-1:0]  piped_pkt_data;
logic                  piped_pkt_valid;
logic                  piped_pkt_sop;
logic                  piped_pkt_eop;
logic [FP_EWIDTH-1:0]  piped_pkt_empty;
logic [FP_DWIDTH-1:0]  piped_pkt_data_swap;
logic                  piped_pkt_almost_full;

//debug
logic [31:0] in_pkt_cnt;
logic [31:0] out_rule_cnt;
logic [31:0] out_rule_last_cnt;


logic [RID_WIDTH-1:0] hash_out_0_0;
logic hash_out_valid_filter_0_0;
rule_s_t din_0_0;
rule_s_t din_0_0_r1;
rule_s_t din_0_0_r2;
logic din_valid_0_0;
logic din_valid_0_0_r1;
logic din_valid_0_0_r2;
logic din_ready_0_0;
logic din_almost_full_0_0;
logic [31:0] din_csr_readdata_0_0;
rule_s_t back_data_0_0;
logic    back_valid_0_0;
logic    back_ready_0_0;
logic [RID_WIDTH-1:0] hash_out_0_1;
logic hash_out_valid_filter_0_1;
rule_s_t din_0_1;
rule_s_t din_0_1_r1;
rule_s_t din_0_1_r2;
logic din_valid_0_1;
logic din_valid_0_1_r1;
logic din_valid_0_1_r2;
logic din_ready_0_1;
logic din_almost_full_0_1;
logic [31:0] din_csr_readdata_0_1;
rule_s_t back_data_0_1;
logic    back_valid_0_1;
logic    back_ready_0_1;
logic [RID_WIDTH-1:0] hash_out_0_2;
logic hash_out_valid_filter_0_2;
rule_s_t din_0_2;
rule_s_t din_0_2_r1;
rule_s_t din_0_2_r2;
logic din_valid_0_2;
logic din_valid_0_2_r1;
logic din_valid_0_2_r2;
logic din_ready_0_2;
logic din_almost_full_0_2;
logic [31:0] din_csr_readdata_0_2;
rule_s_t back_data_0_2;
logic    back_valid_0_2;
logic    back_ready_0_2;
logic [RID_WIDTH-1:0] hash_out_0_3;
logic hash_out_valid_filter_0_3;
rule_s_t din_0_3;
rule_s_t din_0_3_r1;
rule_s_t din_0_3_r2;
logic din_valid_0_3;
logic din_valid_0_3_r1;
logic din_valid_0_3_r2;
logic din_ready_0_3;
logic din_almost_full_0_3;
logic [31:0] din_csr_readdata_0_3;
rule_s_t back_data_0_3;
logic    back_valid_0_3;
logic    back_ready_0_3;
logic [RID_WIDTH-1:0] hash_out_0_4;
logic hash_out_valid_filter_0_4;
rule_s_t din_0_4;
rule_s_t din_0_4_r1;
rule_s_t din_0_4_r2;
logic din_valid_0_4;
logic din_valid_0_4_r1;
logic din_valid_0_4_r2;
logic din_ready_0_4;
logic din_almost_full_0_4;
logic [31:0] din_csr_readdata_0_4;
rule_s_t back_data_0_4;
logic    back_valid_0_4;
logic    back_ready_0_4;
logic [RID_WIDTH-1:0] hash_out_0_5;
logic hash_out_valid_filter_0_5;
rule_s_t din_0_5;
rule_s_t din_0_5_r1;
rule_s_t din_0_5_r2;
logic din_valid_0_5;
logic din_valid_0_5_r1;
logic din_valid_0_5_r2;
logic din_ready_0_5;
logic din_almost_full_0_5;
logic [31:0] din_csr_readdata_0_5;
rule_s_t back_data_0_5;
logic    back_valid_0_5;
logic    back_ready_0_5;
logic [RID_WIDTH-1:0] hash_out_0_6;
logic hash_out_valid_filter_0_6;
rule_s_t din_0_6;
rule_s_t din_0_6_r1;
rule_s_t din_0_6_r2;
logic din_valid_0_6;
logic din_valid_0_6_r1;
logic din_valid_0_6_r2;
logic din_ready_0_6;
logic din_almost_full_0_6;
logic [31:0] din_csr_readdata_0_6;
rule_s_t back_data_0_6;
logic    back_valid_0_6;
logic    back_ready_0_6;
logic [RID_WIDTH-1:0] hash_out_0_7;
logic hash_out_valid_filter_0_7;
rule_s_t din_0_7;
rule_s_t din_0_7_r1;
rule_s_t din_0_7_r2;
logic din_valid_0_7;
logic din_valid_0_7_r1;
logic din_valid_0_7_r2;
logic din_ready_0_7;
logic din_almost_full_0_7;
logic [31:0] din_csr_readdata_0_7;
rule_s_t back_data_0_7;
logic    back_valid_0_7;
logic    back_ready_0_7;
logic [RID_WIDTH-1:0] hash_out_0_8;
logic hash_out_valid_filter_0_8;
rule_s_t din_0_8;
rule_s_t din_0_8_r1;
rule_s_t din_0_8_r2;
logic din_valid_0_8;
logic din_valid_0_8_r1;
logic din_valid_0_8_r2;
logic din_ready_0_8;
logic din_almost_full_0_8;
logic [31:0] din_csr_readdata_0_8;
rule_s_t back_data_0_8;
logic    back_valid_0_8;
logic    back_ready_0_8;
logic [RID_WIDTH-1:0] hash_out_0_9;
logic hash_out_valid_filter_0_9;
rule_s_t din_0_9;
rule_s_t din_0_9_r1;
rule_s_t din_0_9_r2;
logic din_valid_0_9;
logic din_valid_0_9_r1;
logic din_valid_0_9_r2;
logic din_ready_0_9;
logic din_almost_full_0_9;
logic [31:0] din_csr_readdata_0_9;
rule_s_t back_data_0_9;
logic    back_valid_0_9;
logic    back_ready_0_9;
logic [RID_WIDTH-1:0] hash_out_0_10;
logic hash_out_valid_filter_0_10;
rule_s_t din_0_10;
rule_s_t din_0_10_r1;
rule_s_t din_0_10_r2;
logic din_valid_0_10;
logic din_valid_0_10_r1;
logic din_valid_0_10_r2;
logic din_ready_0_10;
logic din_almost_full_0_10;
logic [31:0] din_csr_readdata_0_10;
rule_s_t back_data_0_10;
logic    back_valid_0_10;
logic    back_ready_0_10;
logic [RID_WIDTH-1:0] hash_out_0_11;
logic hash_out_valid_filter_0_11;
rule_s_t din_0_11;
rule_s_t din_0_11_r1;
rule_s_t din_0_11_r2;
logic din_valid_0_11;
logic din_valid_0_11_r1;
logic din_valid_0_11_r2;
logic din_ready_0_11;
logic din_almost_full_0_11;
logic [31:0] din_csr_readdata_0_11;
rule_s_t back_data_0_11;
logic    back_valid_0_11;
logic    back_ready_0_11;
logic [RID_WIDTH-1:0] hash_out_0_12;
logic hash_out_valid_filter_0_12;
rule_s_t din_0_12;
rule_s_t din_0_12_r1;
rule_s_t din_0_12_r2;
logic din_valid_0_12;
logic din_valid_0_12_r1;
logic din_valid_0_12_r2;
logic din_ready_0_12;
logic din_almost_full_0_12;
logic [31:0] din_csr_readdata_0_12;
rule_s_t back_data_0_12;
logic    back_valid_0_12;
logic    back_ready_0_12;
logic [RID_WIDTH-1:0] hash_out_0_13;
logic hash_out_valid_filter_0_13;
rule_s_t din_0_13;
rule_s_t din_0_13_r1;
rule_s_t din_0_13_r2;
logic din_valid_0_13;
logic din_valid_0_13_r1;
logic din_valid_0_13_r2;
logic din_ready_0_13;
logic din_almost_full_0_13;
logic [31:0] din_csr_readdata_0_13;
rule_s_t back_data_0_13;
logic    back_valid_0_13;
logic    back_ready_0_13;
logic [RID_WIDTH-1:0] hash_out_0_14;
logic hash_out_valid_filter_0_14;
rule_s_t din_0_14;
rule_s_t din_0_14_r1;
rule_s_t din_0_14_r2;
logic din_valid_0_14;
logic din_valid_0_14_r1;
logic din_valid_0_14_r2;
logic din_ready_0_14;
logic din_almost_full_0_14;
logic [31:0] din_csr_readdata_0_14;
rule_s_t back_data_0_14;
logic    back_valid_0_14;
logic    back_ready_0_14;
logic [RID_WIDTH-1:0] hash_out_0_15;
logic hash_out_valid_filter_0_15;
rule_s_t din_0_15;
rule_s_t din_0_15_r1;
rule_s_t din_0_15_r2;
logic din_valid_0_15;
logic din_valid_0_15_r1;
logic din_valid_0_15_r2;
logic din_ready_0_15;
logic din_almost_full_0_15;
logic [31:0] din_csr_readdata_0_15;
rule_s_t back_data_0_15;
logic    back_valid_0_15;
logic    back_ready_0_15;
logic [RID_WIDTH-1:0] hash_out_1_0;
logic hash_out_valid_filter_1_0;
rule_s_t din_1_0;
rule_s_t din_1_0_r1;
rule_s_t din_1_0_r2;
logic din_valid_1_0;
logic din_valid_1_0_r1;
logic din_valid_1_0_r2;
logic din_ready_1_0;
logic din_almost_full_1_0;
logic [31:0] din_csr_readdata_1_0;
rule_s_t back_data_1_0;
logic    back_valid_1_0;
logic    back_ready_1_0;
logic [RID_WIDTH-1:0] hash_out_1_1;
logic hash_out_valid_filter_1_1;
rule_s_t din_1_1;
rule_s_t din_1_1_r1;
rule_s_t din_1_1_r2;
logic din_valid_1_1;
logic din_valid_1_1_r1;
logic din_valid_1_1_r2;
logic din_ready_1_1;
logic din_almost_full_1_1;
logic [31:0] din_csr_readdata_1_1;
rule_s_t back_data_1_1;
logic    back_valid_1_1;
logic    back_ready_1_1;
logic [RID_WIDTH-1:0] hash_out_1_2;
logic hash_out_valid_filter_1_2;
rule_s_t din_1_2;
rule_s_t din_1_2_r1;
rule_s_t din_1_2_r2;
logic din_valid_1_2;
logic din_valid_1_2_r1;
logic din_valid_1_2_r2;
logic din_ready_1_2;
logic din_almost_full_1_2;
logic [31:0] din_csr_readdata_1_2;
rule_s_t back_data_1_2;
logic    back_valid_1_2;
logic    back_ready_1_2;
logic [RID_WIDTH-1:0] hash_out_1_3;
logic hash_out_valid_filter_1_3;
rule_s_t din_1_3;
rule_s_t din_1_3_r1;
rule_s_t din_1_3_r2;
logic din_valid_1_3;
logic din_valid_1_3_r1;
logic din_valid_1_3_r2;
logic din_ready_1_3;
logic din_almost_full_1_3;
logic [31:0] din_csr_readdata_1_3;
rule_s_t back_data_1_3;
logic    back_valid_1_3;
logic    back_ready_1_3;
logic [RID_WIDTH-1:0] hash_out_1_4;
logic hash_out_valid_filter_1_4;
rule_s_t din_1_4;
rule_s_t din_1_4_r1;
rule_s_t din_1_4_r2;
logic din_valid_1_4;
logic din_valid_1_4_r1;
logic din_valid_1_4_r2;
logic din_ready_1_4;
logic din_almost_full_1_4;
logic [31:0] din_csr_readdata_1_4;
rule_s_t back_data_1_4;
logic    back_valid_1_4;
logic    back_ready_1_4;
logic [RID_WIDTH-1:0] hash_out_1_5;
logic hash_out_valid_filter_1_5;
rule_s_t din_1_5;
rule_s_t din_1_5_r1;
rule_s_t din_1_5_r2;
logic din_valid_1_5;
logic din_valid_1_5_r1;
logic din_valid_1_5_r2;
logic din_ready_1_5;
logic din_almost_full_1_5;
logic [31:0] din_csr_readdata_1_5;
rule_s_t back_data_1_5;
logic    back_valid_1_5;
logic    back_ready_1_5;
logic [RID_WIDTH-1:0] hash_out_1_6;
logic hash_out_valid_filter_1_6;
rule_s_t din_1_6;
rule_s_t din_1_6_r1;
rule_s_t din_1_6_r2;
logic din_valid_1_6;
logic din_valid_1_6_r1;
logic din_valid_1_6_r2;
logic din_ready_1_6;
logic din_almost_full_1_6;
logic [31:0] din_csr_readdata_1_6;
rule_s_t back_data_1_6;
logic    back_valid_1_6;
logic    back_ready_1_6;
logic [RID_WIDTH-1:0] hash_out_1_7;
logic hash_out_valid_filter_1_7;
rule_s_t din_1_7;
rule_s_t din_1_7_r1;
rule_s_t din_1_7_r2;
logic din_valid_1_7;
logic din_valid_1_7_r1;
logic din_valid_1_7_r2;
logic din_ready_1_7;
logic din_almost_full_1_7;
logic [31:0] din_csr_readdata_1_7;
rule_s_t back_data_1_7;
logic    back_valid_1_7;
logic    back_ready_1_7;
logic [RID_WIDTH-1:0] hash_out_1_8;
logic hash_out_valid_filter_1_8;
rule_s_t din_1_8;
rule_s_t din_1_8_r1;
rule_s_t din_1_8_r2;
logic din_valid_1_8;
logic din_valid_1_8_r1;
logic din_valid_1_8_r2;
logic din_ready_1_8;
logic din_almost_full_1_8;
logic [31:0] din_csr_readdata_1_8;
rule_s_t back_data_1_8;
logic    back_valid_1_8;
logic    back_ready_1_8;
logic [RID_WIDTH-1:0] hash_out_1_9;
logic hash_out_valid_filter_1_9;
rule_s_t din_1_9;
rule_s_t din_1_9_r1;
rule_s_t din_1_9_r2;
logic din_valid_1_9;
logic din_valid_1_9_r1;
logic din_valid_1_9_r2;
logic din_ready_1_9;
logic din_almost_full_1_9;
logic [31:0] din_csr_readdata_1_9;
rule_s_t back_data_1_9;
logic    back_valid_1_9;
logic    back_ready_1_9;
logic [RID_WIDTH-1:0] hash_out_1_10;
logic hash_out_valid_filter_1_10;
rule_s_t din_1_10;
rule_s_t din_1_10_r1;
rule_s_t din_1_10_r2;
logic din_valid_1_10;
logic din_valid_1_10_r1;
logic din_valid_1_10_r2;
logic din_ready_1_10;
logic din_almost_full_1_10;
logic [31:0] din_csr_readdata_1_10;
rule_s_t back_data_1_10;
logic    back_valid_1_10;
logic    back_ready_1_10;
logic [RID_WIDTH-1:0] hash_out_1_11;
logic hash_out_valid_filter_1_11;
rule_s_t din_1_11;
rule_s_t din_1_11_r1;
rule_s_t din_1_11_r2;
logic din_valid_1_11;
logic din_valid_1_11_r1;
logic din_valid_1_11_r2;
logic din_ready_1_11;
logic din_almost_full_1_11;
logic [31:0] din_csr_readdata_1_11;
rule_s_t back_data_1_11;
logic    back_valid_1_11;
logic    back_ready_1_11;
logic [RID_WIDTH-1:0] hash_out_1_12;
logic hash_out_valid_filter_1_12;
rule_s_t din_1_12;
rule_s_t din_1_12_r1;
rule_s_t din_1_12_r2;
logic din_valid_1_12;
logic din_valid_1_12_r1;
logic din_valid_1_12_r2;
logic din_ready_1_12;
logic din_almost_full_1_12;
logic [31:0] din_csr_readdata_1_12;
rule_s_t back_data_1_12;
logic    back_valid_1_12;
logic    back_ready_1_12;
logic [RID_WIDTH-1:0] hash_out_1_13;
logic hash_out_valid_filter_1_13;
rule_s_t din_1_13;
rule_s_t din_1_13_r1;
rule_s_t din_1_13_r2;
logic din_valid_1_13;
logic din_valid_1_13_r1;
logic din_valid_1_13_r2;
logic din_ready_1_13;
logic din_almost_full_1_13;
logic [31:0] din_csr_readdata_1_13;
rule_s_t back_data_1_13;
logic    back_valid_1_13;
logic    back_ready_1_13;
logic [RID_WIDTH-1:0] hash_out_1_14;
logic hash_out_valid_filter_1_14;
rule_s_t din_1_14;
rule_s_t din_1_14_r1;
rule_s_t din_1_14_r2;
logic din_valid_1_14;
logic din_valid_1_14_r1;
logic din_valid_1_14_r2;
logic din_ready_1_14;
logic din_almost_full_1_14;
logic [31:0] din_csr_readdata_1_14;
rule_s_t back_data_1_14;
logic    back_valid_1_14;
logic    back_ready_1_14;
logic [RID_WIDTH-1:0] hash_out_1_15;
logic hash_out_valid_filter_1_15;
rule_s_t din_1_15;
rule_s_t din_1_15_r1;
rule_s_t din_1_15_r2;
logic din_valid_1_15;
logic din_valid_1_15_r1;
logic din_valid_1_15_r2;
logic din_ready_1_15;
logic din_almost_full_1_15;
logic [31:0] din_csr_readdata_1_15;
rule_s_t back_data_1_15;
logic    back_valid_1_15;
logic    back_ready_1_15;
logic [RID_WIDTH-1:0] hash_out_2_0;
logic hash_out_valid_filter_2_0;
rule_s_t din_2_0;
rule_s_t din_2_0_r1;
rule_s_t din_2_0_r2;
logic din_valid_2_0;
logic din_valid_2_0_r1;
logic din_valid_2_0_r2;
logic din_ready_2_0;
logic din_almost_full_2_0;
logic [31:0] din_csr_readdata_2_0;
rule_s_t back_data_2_0;
logic    back_valid_2_0;
logic    back_ready_2_0;
logic [RID_WIDTH-1:0] hash_out_2_1;
logic hash_out_valid_filter_2_1;
rule_s_t din_2_1;
rule_s_t din_2_1_r1;
rule_s_t din_2_1_r2;
logic din_valid_2_1;
logic din_valid_2_1_r1;
logic din_valid_2_1_r2;
logic din_ready_2_1;
logic din_almost_full_2_1;
logic [31:0] din_csr_readdata_2_1;
rule_s_t back_data_2_1;
logic    back_valid_2_1;
logic    back_ready_2_1;
logic [RID_WIDTH-1:0] hash_out_2_2;
logic hash_out_valid_filter_2_2;
rule_s_t din_2_2;
rule_s_t din_2_2_r1;
rule_s_t din_2_2_r2;
logic din_valid_2_2;
logic din_valid_2_2_r1;
logic din_valid_2_2_r2;
logic din_ready_2_2;
logic din_almost_full_2_2;
logic [31:0] din_csr_readdata_2_2;
rule_s_t back_data_2_2;
logic    back_valid_2_2;
logic    back_ready_2_2;
logic [RID_WIDTH-1:0] hash_out_2_3;
logic hash_out_valid_filter_2_3;
rule_s_t din_2_3;
rule_s_t din_2_3_r1;
rule_s_t din_2_3_r2;
logic din_valid_2_3;
logic din_valid_2_3_r1;
logic din_valid_2_3_r2;
logic din_ready_2_3;
logic din_almost_full_2_3;
logic [31:0] din_csr_readdata_2_3;
rule_s_t back_data_2_3;
logic    back_valid_2_3;
logic    back_ready_2_3;
logic [RID_WIDTH-1:0] hash_out_2_4;
logic hash_out_valid_filter_2_4;
rule_s_t din_2_4;
rule_s_t din_2_4_r1;
rule_s_t din_2_4_r2;
logic din_valid_2_4;
logic din_valid_2_4_r1;
logic din_valid_2_4_r2;
logic din_ready_2_4;
logic din_almost_full_2_4;
logic [31:0] din_csr_readdata_2_4;
rule_s_t back_data_2_4;
logic    back_valid_2_4;
logic    back_ready_2_4;
logic [RID_WIDTH-1:0] hash_out_2_5;
logic hash_out_valid_filter_2_5;
rule_s_t din_2_5;
rule_s_t din_2_5_r1;
rule_s_t din_2_5_r2;
logic din_valid_2_5;
logic din_valid_2_5_r1;
logic din_valid_2_5_r2;
logic din_ready_2_5;
logic din_almost_full_2_5;
logic [31:0] din_csr_readdata_2_5;
rule_s_t back_data_2_5;
logic    back_valid_2_5;
logic    back_ready_2_5;
logic [RID_WIDTH-1:0] hash_out_2_6;
logic hash_out_valid_filter_2_6;
rule_s_t din_2_6;
rule_s_t din_2_6_r1;
rule_s_t din_2_6_r2;
logic din_valid_2_6;
logic din_valid_2_6_r1;
logic din_valid_2_6_r2;
logic din_ready_2_6;
logic din_almost_full_2_6;
logic [31:0] din_csr_readdata_2_6;
rule_s_t back_data_2_6;
logic    back_valid_2_6;
logic    back_ready_2_6;
logic [RID_WIDTH-1:0] hash_out_2_7;
logic hash_out_valid_filter_2_7;
rule_s_t din_2_7;
rule_s_t din_2_7_r1;
rule_s_t din_2_7_r2;
logic din_valid_2_7;
logic din_valid_2_7_r1;
logic din_valid_2_7_r2;
logic din_ready_2_7;
logic din_almost_full_2_7;
logic [31:0] din_csr_readdata_2_7;
rule_s_t back_data_2_7;
logic    back_valid_2_7;
logic    back_ready_2_7;
logic [RID_WIDTH-1:0] hash_out_2_8;
logic hash_out_valid_filter_2_8;
rule_s_t din_2_8;
rule_s_t din_2_8_r1;
rule_s_t din_2_8_r2;
logic din_valid_2_8;
logic din_valid_2_8_r1;
logic din_valid_2_8_r2;
logic din_ready_2_8;
logic din_almost_full_2_8;
logic [31:0] din_csr_readdata_2_8;
rule_s_t back_data_2_8;
logic    back_valid_2_8;
logic    back_ready_2_8;
logic [RID_WIDTH-1:0] hash_out_2_9;
logic hash_out_valid_filter_2_9;
rule_s_t din_2_9;
rule_s_t din_2_9_r1;
rule_s_t din_2_9_r2;
logic din_valid_2_9;
logic din_valid_2_9_r1;
logic din_valid_2_9_r2;
logic din_ready_2_9;
logic din_almost_full_2_9;
logic [31:0] din_csr_readdata_2_9;
rule_s_t back_data_2_9;
logic    back_valid_2_9;
logic    back_ready_2_9;
logic [RID_WIDTH-1:0] hash_out_2_10;
logic hash_out_valid_filter_2_10;
rule_s_t din_2_10;
rule_s_t din_2_10_r1;
rule_s_t din_2_10_r2;
logic din_valid_2_10;
logic din_valid_2_10_r1;
logic din_valid_2_10_r2;
logic din_ready_2_10;
logic din_almost_full_2_10;
logic [31:0] din_csr_readdata_2_10;
rule_s_t back_data_2_10;
logic    back_valid_2_10;
logic    back_ready_2_10;
logic [RID_WIDTH-1:0] hash_out_2_11;
logic hash_out_valid_filter_2_11;
rule_s_t din_2_11;
rule_s_t din_2_11_r1;
rule_s_t din_2_11_r2;
logic din_valid_2_11;
logic din_valid_2_11_r1;
logic din_valid_2_11_r2;
logic din_ready_2_11;
logic din_almost_full_2_11;
logic [31:0] din_csr_readdata_2_11;
rule_s_t back_data_2_11;
logic    back_valid_2_11;
logic    back_ready_2_11;
logic [RID_WIDTH-1:0] hash_out_2_12;
logic hash_out_valid_filter_2_12;
rule_s_t din_2_12;
rule_s_t din_2_12_r1;
rule_s_t din_2_12_r2;
logic din_valid_2_12;
logic din_valid_2_12_r1;
logic din_valid_2_12_r2;
logic din_ready_2_12;
logic din_almost_full_2_12;
logic [31:0] din_csr_readdata_2_12;
rule_s_t back_data_2_12;
logic    back_valid_2_12;
logic    back_ready_2_12;
logic [RID_WIDTH-1:0] hash_out_2_13;
logic hash_out_valid_filter_2_13;
rule_s_t din_2_13;
rule_s_t din_2_13_r1;
rule_s_t din_2_13_r2;
logic din_valid_2_13;
logic din_valid_2_13_r1;
logic din_valid_2_13_r2;
logic din_ready_2_13;
logic din_almost_full_2_13;
logic [31:0] din_csr_readdata_2_13;
rule_s_t back_data_2_13;
logic    back_valid_2_13;
logic    back_ready_2_13;
logic [RID_WIDTH-1:0] hash_out_2_14;
logic hash_out_valid_filter_2_14;
rule_s_t din_2_14;
rule_s_t din_2_14_r1;
rule_s_t din_2_14_r2;
logic din_valid_2_14;
logic din_valid_2_14_r1;
logic din_valid_2_14_r2;
logic din_ready_2_14;
logic din_almost_full_2_14;
logic [31:0] din_csr_readdata_2_14;
rule_s_t back_data_2_14;
logic    back_valid_2_14;
logic    back_ready_2_14;
logic [RID_WIDTH-1:0] hash_out_2_15;
logic hash_out_valid_filter_2_15;
rule_s_t din_2_15;
rule_s_t din_2_15_r1;
rule_s_t din_2_15_r2;
logic din_valid_2_15;
logic din_valid_2_15_r1;
logic din_valid_2_15_r2;
logic din_ready_2_15;
logic din_almost_full_2_15;
logic [31:0] din_csr_readdata_2_15;
rule_s_t back_data_2_15;
logic    back_valid_2_15;
logic    back_ready_2_15;
logic [RID_WIDTH-1:0] hash_out_3_0;
logic hash_out_valid_filter_3_0;
rule_s_t din_3_0;
rule_s_t din_3_0_r1;
rule_s_t din_3_0_r2;
logic din_valid_3_0;
logic din_valid_3_0_r1;
logic din_valid_3_0_r2;
logic din_ready_3_0;
logic din_almost_full_3_0;
logic [31:0] din_csr_readdata_3_0;
rule_s_t back_data_3_0;
logic    back_valid_3_0;
logic    back_ready_3_0;
logic [RID_WIDTH-1:0] hash_out_3_1;
logic hash_out_valid_filter_3_1;
rule_s_t din_3_1;
rule_s_t din_3_1_r1;
rule_s_t din_3_1_r2;
logic din_valid_3_1;
logic din_valid_3_1_r1;
logic din_valid_3_1_r2;
logic din_ready_3_1;
logic din_almost_full_3_1;
logic [31:0] din_csr_readdata_3_1;
rule_s_t back_data_3_1;
logic    back_valid_3_1;
logic    back_ready_3_1;
logic [RID_WIDTH-1:0] hash_out_3_2;
logic hash_out_valid_filter_3_2;
rule_s_t din_3_2;
rule_s_t din_3_2_r1;
rule_s_t din_3_2_r2;
logic din_valid_3_2;
logic din_valid_3_2_r1;
logic din_valid_3_2_r2;
logic din_ready_3_2;
logic din_almost_full_3_2;
logic [31:0] din_csr_readdata_3_2;
rule_s_t back_data_3_2;
logic    back_valid_3_2;
logic    back_ready_3_2;
logic [RID_WIDTH-1:0] hash_out_3_3;
logic hash_out_valid_filter_3_3;
rule_s_t din_3_3;
rule_s_t din_3_3_r1;
rule_s_t din_3_3_r2;
logic din_valid_3_3;
logic din_valid_3_3_r1;
logic din_valid_3_3_r2;
logic din_ready_3_3;
logic din_almost_full_3_3;
logic [31:0] din_csr_readdata_3_3;
rule_s_t back_data_3_3;
logic    back_valid_3_3;
logic    back_ready_3_3;
logic [RID_WIDTH-1:0] hash_out_3_4;
logic hash_out_valid_filter_3_4;
rule_s_t din_3_4;
rule_s_t din_3_4_r1;
rule_s_t din_3_4_r2;
logic din_valid_3_4;
logic din_valid_3_4_r1;
logic din_valid_3_4_r2;
logic din_ready_3_4;
logic din_almost_full_3_4;
logic [31:0] din_csr_readdata_3_4;
rule_s_t back_data_3_4;
logic    back_valid_3_4;
logic    back_ready_3_4;
logic [RID_WIDTH-1:0] hash_out_3_5;
logic hash_out_valid_filter_3_5;
rule_s_t din_3_5;
rule_s_t din_3_5_r1;
rule_s_t din_3_5_r2;
logic din_valid_3_5;
logic din_valid_3_5_r1;
logic din_valid_3_5_r2;
logic din_ready_3_5;
logic din_almost_full_3_5;
logic [31:0] din_csr_readdata_3_5;
rule_s_t back_data_3_5;
logic    back_valid_3_5;
logic    back_ready_3_5;
logic [RID_WIDTH-1:0] hash_out_3_6;
logic hash_out_valid_filter_3_6;
rule_s_t din_3_6;
rule_s_t din_3_6_r1;
rule_s_t din_3_6_r2;
logic din_valid_3_6;
logic din_valid_3_6_r1;
logic din_valid_3_6_r2;
logic din_ready_3_6;
logic din_almost_full_3_6;
logic [31:0] din_csr_readdata_3_6;
rule_s_t back_data_3_6;
logic    back_valid_3_6;
logic    back_ready_3_6;
logic [RID_WIDTH-1:0] hash_out_3_7;
logic hash_out_valid_filter_3_7;
rule_s_t din_3_7;
rule_s_t din_3_7_r1;
rule_s_t din_3_7_r2;
logic din_valid_3_7;
logic din_valid_3_7_r1;
logic din_valid_3_7_r2;
logic din_ready_3_7;
logic din_almost_full_3_7;
logic [31:0] din_csr_readdata_3_7;
rule_s_t back_data_3_7;
logic    back_valid_3_7;
logic    back_ready_3_7;
logic [RID_WIDTH-1:0] hash_out_3_8;
logic hash_out_valid_filter_3_8;
rule_s_t din_3_8;
rule_s_t din_3_8_r1;
rule_s_t din_3_8_r2;
logic din_valid_3_8;
logic din_valid_3_8_r1;
logic din_valid_3_8_r2;
logic din_ready_3_8;
logic din_almost_full_3_8;
logic [31:0] din_csr_readdata_3_8;
rule_s_t back_data_3_8;
logic    back_valid_3_8;
logic    back_ready_3_8;
logic [RID_WIDTH-1:0] hash_out_3_9;
logic hash_out_valid_filter_3_9;
rule_s_t din_3_9;
rule_s_t din_3_9_r1;
rule_s_t din_3_9_r2;
logic din_valid_3_9;
logic din_valid_3_9_r1;
logic din_valid_3_9_r2;
logic din_ready_3_9;
logic din_almost_full_3_9;
logic [31:0] din_csr_readdata_3_9;
rule_s_t back_data_3_9;
logic    back_valid_3_9;
logic    back_ready_3_9;
logic [RID_WIDTH-1:0] hash_out_3_10;
logic hash_out_valid_filter_3_10;
rule_s_t din_3_10;
rule_s_t din_3_10_r1;
rule_s_t din_3_10_r2;
logic din_valid_3_10;
logic din_valid_3_10_r1;
logic din_valid_3_10_r2;
logic din_ready_3_10;
logic din_almost_full_3_10;
logic [31:0] din_csr_readdata_3_10;
rule_s_t back_data_3_10;
logic    back_valid_3_10;
logic    back_ready_3_10;
logic [RID_WIDTH-1:0] hash_out_3_11;
logic hash_out_valid_filter_3_11;
rule_s_t din_3_11;
rule_s_t din_3_11_r1;
rule_s_t din_3_11_r2;
logic din_valid_3_11;
logic din_valid_3_11_r1;
logic din_valid_3_11_r2;
logic din_ready_3_11;
logic din_almost_full_3_11;
logic [31:0] din_csr_readdata_3_11;
rule_s_t back_data_3_11;
logic    back_valid_3_11;
logic    back_ready_3_11;
logic [RID_WIDTH-1:0] hash_out_3_12;
logic hash_out_valid_filter_3_12;
rule_s_t din_3_12;
rule_s_t din_3_12_r1;
rule_s_t din_3_12_r2;
logic din_valid_3_12;
logic din_valid_3_12_r1;
logic din_valid_3_12_r2;
logic din_ready_3_12;
logic din_almost_full_3_12;
logic [31:0] din_csr_readdata_3_12;
rule_s_t back_data_3_12;
logic    back_valid_3_12;
logic    back_ready_3_12;
logic [RID_WIDTH-1:0] hash_out_3_13;
logic hash_out_valid_filter_3_13;
rule_s_t din_3_13;
rule_s_t din_3_13_r1;
rule_s_t din_3_13_r2;
logic din_valid_3_13;
logic din_valid_3_13_r1;
logic din_valid_3_13_r2;
logic din_ready_3_13;
logic din_almost_full_3_13;
logic [31:0] din_csr_readdata_3_13;
rule_s_t back_data_3_13;
logic    back_valid_3_13;
logic    back_ready_3_13;
logic [RID_WIDTH-1:0] hash_out_3_14;
logic hash_out_valid_filter_3_14;
rule_s_t din_3_14;
rule_s_t din_3_14_r1;
rule_s_t din_3_14_r2;
logic din_valid_3_14;
logic din_valid_3_14_r1;
logic din_valid_3_14_r2;
logic din_ready_3_14;
logic din_almost_full_3_14;
logic [31:0] din_csr_readdata_3_14;
rule_s_t back_data_3_14;
logic    back_valid_3_14;
logic    back_ready_3_14;
logic [RID_WIDTH-1:0] hash_out_3_15;
logic hash_out_valid_filter_3_15;
rule_s_t din_3_15;
rule_s_t din_3_15_r1;
rule_s_t din_3_15_r2;
logic din_valid_3_15;
logic din_valid_3_15_r1;
logic din_valid_3_15_r2;
logic din_ready_3_15;
logic din_almost_full_3_15;
logic [31:0] din_csr_readdata_3_15;
rule_s_t back_data_3_15;
logic    back_valid_3_15;
logic    back_ready_3_15;
logic [RID_WIDTH-1:0] hash_out_4_0;
logic hash_out_valid_filter_4_0;
rule_s_t din_4_0;
rule_s_t din_4_0_r1;
rule_s_t din_4_0_r2;
logic din_valid_4_0;
logic din_valid_4_0_r1;
logic din_valid_4_0_r2;
logic din_ready_4_0;
logic din_almost_full_4_0;
logic [31:0] din_csr_readdata_4_0;
rule_s_t back_data_4_0;
logic    back_valid_4_0;
logic    back_ready_4_0;
logic [RID_WIDTH-1:0] hash_out_4_1;
logic hash_out_valid_filter_4_1;
rule_s_t din_4_1;
rule_s_t din_4_1_r1;
rule_s_t din_4_1_r2;
logic din_valid_4_1;
logic din_valid_4_1_r1;
logic din_valid_4_1_r2;
logic din_ready_4_1;
logic din_almost_full_4_1;
logic [31:0] din_csr_readdata_4_1;
rule_s_t back_data_4_1;
logic    back_valid_4_1;
logic    back_ready_4_1;
logic [RID_WIDTH-1:0] hash_out_4_2;
logic hash_out_valid_filter_4_2;
rule_s_t din_4_2;
rule_s_t din_4_2_r1;
rule_s_t din_4_2_r2;
logic din_valid_4_2;
logic din_valid_4_2_r1;
logic din_valid_4_2_r2;
logic din_ready_4_2;
logic din_almost_full_4_2;
logic [31:0] din_csr_readdata_4_2;
rule_s_t back_data_4_2;
logic    back_valid_4_2;
logic    back_ready_4_2;
logic [RID_WIDTH-1:0] hash_out_4_3;
logic hash_out_valid_filter_4_3;
rule_s_t din_4_3;
rule_s_t din_4_3_r1;
rule_s_t din_4_3_r2;
logic din_valid_4_3;
logic din_valid_4_3_r1;
logic din_valid_4_3_r2;
logic din_ready_4_3;
logic din_almost_full_4_3;
logic [31:0] din_csr_readdata_4_3;
rule_s_t back_data_4_3;
logic    back_valid_4_3;
logic    back_ready_4_3;
logic [RID_WIDTH-1:0] hash_out_4_4;
logic hash_out_valid_filter_4_4;
rule_s_t din_4_4;
rule_s_t din_4_4_r1;
rule_s_t din_4_4_r2;
logic din_valid_4_4;
logic din_valid_4_4_r1;
logic din_valid_4_4_r2;
logic din_ready_4_4;
logic din_almost_full_4_4;
logic [31:0] din_csr_readdata_4_4;
rule_s_t back_data_4_4;
logic    back_valid_4_4;
logic    back_ready_4_4;
logic [RID_WIDTH-1:0] hash_out_4_5;
logic hash_out_valid_filter_4_5;
rule_s_t din_4_5;
rule_s_t din_4_5_r1;
rule_s_t din_4_5_r2;
logic din_valid_4_5;
logic din_valid_4_5_r1;
logic din_valid_4_5_r2;
logic din_ready_4_5;
logic din_almost_full_4_5;
logic [31:0] din_csr_readdata_4_5;
rule_s_t back_data_4_5;
logic    back_valid_4_5;
logic    back_ready_4_5;
logic [RID_WIDTH-1:0] hash_out_4_6;
logic hash_out_valid_filter_4_6;
rule_s_t din_4_6;
rule_s_t din_4_6_r1;
rule_s_t din_4_6_r2;
logic din_valid_4_6;
logic din_valid_4_6_r1;
logic din_valid_4_6_r2;
logic din_ready_4_6;
logic din_almost_full_4_6;
logic [31:0] din_csr_readdata_4_6;
rule_s_t back_data_4_6;
logic    back_valid_4_6;
logic    back_ready_4_6;
logic [RID_WIDTH-1:0] hash_out_4_7;
logic hash_out_valid_filter_4_7;
rule_s_t din_4_7;
rule_s_t din_4_7_r1;
rule_s_t din_4_7_r2;
logic din_valid_4_7;
logic din_valid_4_7_r1;
logic din_valid_4_7_r2;
logic din_ready_4_7;
logic din_almost_full_4_7;
logic [31:0] din_csr_readdata_4_7;
rule_s_t back_data_4_7;
logic    back_valid_4_7;
logic    back_ready_4_7;
logic [RID_WIDTH-1:0] hash_out_4_8;
logic hash_out_valid_filter_4_8;
rule_s_t din_4_8;
rule_s_t din_4_8_r1;
rule_s_t din_4_8_r2;
logic din_valid_4_8;
logic din_valid_4_8_r1;
logic din_valid_4_8_r2;
logic din_ready_4_8;
logic din_almost_full_4_8;
logic [31:0] din_csr_readdata_4_8;
rule_s_t back_data_4_8;
logic    back_valid_4_8;
logic    back_ready_4_8;
logic [RID_WIDTH-1:0] hash_out_4_9;
logic hash_out_valid_filter_4_9;
rule_s_t din_4_9;
rule_s_t din_4_9_r1;
rule_s_t din_4_9_r2;
logic din_valid_4_9;
logic din_valid_4_9_r1;
logic din_valid_4_9_r2;
logic din_ready_4_9;
logic din_almost_full_4_9;
logic [31:0] din_csr_readdata_4_9;
rule_s_t back_data_4_9;
logic    back_valid_4_9;
logic    back_ready_4_9;
logic [RID_WIDTH-1:0] hash_out_4_10;
logic hash_out_valid_filter_4_10;
rule_s_t din_4_10;
rule_s_t din_4_10_r1;
rule_s_t din_4_10_r2;
logic din_valid_4_10;
logic din_valid_4_10_r1;
logic din_valid_4_10_r2;
logic din_ready_4_10;
logic din_almost_full_4_10;
logic [31:0] din_csr_readdata_4_10;
rule_s_t back_data_4_10;
logic    back_valid_4_10;
logic    back_ready_4_10;
logic [RID_WIDTH-1:0] hash_out_4_11;
logic hash_out_valid_filter_4_11;
rule_s_t din_4_11;
rule_s_t din_4_11_r1;
rule_s_t din_4_11_r2;
logic din_valid_4_11;
logic din_valid_4_11_r1;
logic din_valid_4_11_r2;
logic din_ready_4_11;
logic din_almost_full_4_11;
logic [31:0] din_csr_readdata_4_11;
rule_s_t back_data_4_11;
logic    back_valid_4_11;
logic    back_ready_4_11;
logic [RID_WIDTH-1:0] hash_out_4_12;
logic hash_out_valid_filter_4_12;
rule_s_t din_4_12;
rule_s_t din_4_12_r1;
rule_s_t din_4_12_r2;
logic din_valid_4_12;
logic din_valid_4_12_r1;
logic din_valid_4_12_r2;
logic din_ready_4_12;
logic din_almost_full_4_12;
logic [31:0] din_csr_readdata_4_12;
rule_s_t back_data_4_12;
logic    back_valid_4_12;
logic    back_ready_4_12;
logic [RID_WIDTH-1:0] hash_out_4_13;
logic hash_out_valid_filter_4_13;
rule_s_t din_4_13;
rule_s_t din_4_13_r1;
rule_s_t din_4_13_r2;
logic din_valid_4_13;
logic din_valid_4_13_r1;
logic din_valid_4_13_r2;
logic din_ready_4_13;
logic din_almost_full_4_13;
logic [31:0] din_csr_readdata_4_13;
rule_s_t back_data_4_13;
logic    back_valid_4_13;
logic    back_ready_4_13;
logic [RID_WIDTH-1:0] hash_out_4_14;
logic hash_out_valid_filter_4_14;
rule_s_t din_4_14;
rule_s_t din_4_14_r1;
rule_s_t din_4_14_r2;
logic din_valid_4_14;
logic din_valid_4_14_r1;
logic din_valid_4_14_r2;
logic din_ready_4_14;
logic din_almost_full_4_14;
logic [31:0] din_csr_readdata_4_14;
rule_s_t back_data_4_14;
logic    back_valid_4_14;
logic    back_ready_4_14;
logic [RID_WIDTH-1:0] hash_out_4_15;
logic hash_out_valid_filter_4_15;
rule_s_t din_4_15;
rule_s_t din_4_15_r1;
rule_s_t din_4_15_r2;
logic din_valid_4_15;
logic din_valid_4_15_r1;
logic din_valid_4_15_r2;
logic din_ready_4_15;
logic din_almost_full_4_15;
logic [31:0] din_csr_readdata_4_15;
rule_s_t back_data_4_15;
logic    back_valid_4_15;
logic    back_ready_4_15;
logic [RID_WIDTH-1:0] hash_out_5_0;
logic hash_out_valid_filter_5_0;
rule_s_t din_5_0;
rule_s_t din_5_0_r1;
rule_s_t din_5_0_r2;
logic din_valid_5_0;
logic din_valid_5_0_r1;
logic din_valid_5_0_r2;
logic din_ready_5_0;
logic din_almost_full_5_0;
logic [31:0] din_csr_readdata_5_0;
rule_s_t back_data_5_0;
logic    back_valid_5_0;
logic    back_ready_5_0;
logic [RID_WIDTH-1:0] hash_out_5_1;
logic hash_out_valid_filter_5_1;
rule_s_t din_5_1;
rule_s_t din_5_1_r1;
rule_s_t din_5_1_r2;
logic din_valid_5_1;
logic din_valid_5_1_r1;
logic din_valid_5_1_r2;
logic din_ready_5_1;
logic din_almost_full_5_1;
logic [31:0] din_csr_readdata_5_1;
rule_s_t back_data_5_1;
logic    back_valid_5_1;
logic    back_ready_5_1;
logic [RID_WIDTH-1:0] hash_out_5_2;
logic hash_out_valid_filter_5_2;
rule_s_t din_5_2;
rule_s_t din_5_2_r1;
rule_s_t din_5_2_r2;
logic din_valid_5_2;
logic din_valid_5_2_r1;
logic din_valid_5_2_r2;
logic din_ready_5_2;
logic din_almost_full_5_2;
logic [31:0] din_csr_readdata_5_2;
rule_s_t back_data_5_2;
logic    back_valid_5_2;
logic    back_ready_5_2;
logic [RID_WIDTH-1:0] hash_out_5_3;
logic hash_out_valid_filter_5_3;
rule_s_t din_5_3;
rule_s_t din_5_3_r1;
rule_s_t din_5_3_r2;
logic din_valid_5_3;
logic din_valid_5_3_r1;
logic din_valid_5_3_r2;
logic din_ready_5_3;
logic din_almost_full_5_3;
logic [31:0] din_csr_readdata_5_3;
rule_s_t back_data_5_3;
logic    back_valid_5_3;
logic    back_ready_5_3;
logic [RID_WIDTH-1:0] hash_out_5_4;
logic hash_out_valid_filter_5_4;
rule_s_t din_5_4;
rule_s_t din_5_4_r1;
rule_s_t din_5_4_r2;
logic din_valid_5_4;
logic din_valid_5_4_r1;
logic din_valid_5_4_r2;
logic din_ready_5_4;
logic din_almost_full_5_4;
logic [31:0] din_csr_readdata_5_4;
rule_s_t back_data_5_4;
logic    back_valid_5_4;
logic    back_ready_5_4;
logic [RID_WIDTH-1:0] hash_out_5_5;
logic hash_out_valid_filter_5_5;
rule_s_t din_5_5;
rule_s_t din_5_5_r1;
rule_s_t din_5_5_r2;
logic din_valid_5_5;
logic din_valid_5_5_r1;
logic din_valid_5_5_r2;
logic din_ready_5_5;
logic din_almost_full_5_5;
logic [31:0] din_csr_readdata_5_5;
rule_s_t back_data_5_5;
logic    back_valid_5_5;
logic    back_ready_5_5;
logic [RID_WIDTH-1:0] hash_out_5_6;
logic hash_out_valid_filter_5_6;
rule_s_t din_5_6;
rule_s_t din_5_6_r1;
rule_s_t din_5_6_r2;
logic din_valid_5_6;
logic din_valid_5_6_r1;
logic din_valid_5_6_r2;
logic din_ready_5_6;
logic din_almost_full_5_6;
logic [31:0] din_csr_readdata_5_6;
rule_s_t back_data_5_6;
logic    back_valid_5_6;
logic    back_ready_5_6;
logic [RID_WIDTH-1:0] hash_out_5_7;
logic hash_out_valid_filter_5_7;
rule_s_t din_5_7;
rule_s_t din_5_7_r1;
rule_s_t din_5_7_r2;
logic din_valid_5_7;
logic din_valid_5_7_r1;
logic din_valid_5_7_r2;
logic din_ready_5_7;
logic din_almost_full_5_7;
logic [31:0] din_csr_readdata_5_7;
rule_s_t back_data_5_7;
logic    back_valid_5_7;
logic    back_ready_5_7;
logic [RID_WIDTH-1:0] hash_out_5_8;
logic hash_out_valid_filter_5_8;
rule_s_t din_5_8;
rule_s_t din_5_8_r1;
rule_s_t din_5_8_r2;
logic din_valid_5_8;
logic din_valid_5_8_r1;
logic din_valid_5_8_r2;
logic din_ready_5_8;
logic din_almost_full_5_8;
logic [31:0] din_csr_readdata_5_8;
rule_s_t back_data_5_8;
logic    back_valid_5_8;
logic    back_ready_5_8;
logic [RID_WIDTH-1:0] hash_out_5_9;
logic hash_out_valid_filter_5_9;
rule_s_t din_5_9;
rule_s_t din_5_9_r1;
rule_s_t din_5_9_r2;
logic din_valid_5_9;
logic din_valid_5_9_r1;
logic din_valid_5_9_r2;
logic din_ready_5_9;
logic din_almost_full_5_9;
logic [31:0] din_csr_readdata_5_9;
rule_s_t back_data_5_9;
logic    back_valid_5_9;
logic    back_ready_5_9;
logic [RID_WIDTH-1:0] hash_out_5_10;
logic hash_out_valid_filter_5_10;
rule_s_t din_5_10;
rule_s_t din_5_10_r1;
rule_s_t din_5_10_r2;
logic din_valid_5_10;
logic din_valid_5_10_r1;
logic din_valid_5_10_r2;
logic din_ready_5_10;
logic din_almost_full_5_10;
logic [31:0] din_csr_readdata_5_10;
rule_s_t back_data_5_10;
logic    back_valid_5_10;
logic    back_ready_5_10;
logic [RID_WIDTH-1:0] hash_out_5_11;
logic hash_out_valid_filter_5_11;
rule_s_t din_5_11;
rule_s_t din_5_11_r1;
rule_s_t din_5_11_r2;
logic din_valid_5_11;
logic din_valid_5_11_r1;
logic din_valid_5_11_r2;
logic din_ready_5_11;
logic din_almost_full_5_11;
logic [31:0] din_csr_readdata_5_11;
rule_s_t back_data_5_11;
logic    back_valid_5_11;
logic    back_ready_5_11;
logic [RID_WIDTH-1:0] hash_out_5_12;
logic hash_out_valid_filter_5_12;
rule_s_t din_5_12;
rule_s_t din_5_12_r1;
rule_s_t din_5_12_r2;
logic din_valid_5_12;
logic din_valid_5_12_r1;
logic din_valid_5_12_r2;
logic din_ready_5_12;
logic din_almost_full_5_12;
logic [31:0] din_csr_readdata_5_12;
rule_s_t back_data_5_12;
logic    back_valid_5_12;
logic    back_ready_5_12;
logic [RID_WIDTH-1:0] hash_out_5_13;
logic hash_out_valid_filter_5_13;
rule_s_t din_5_13;
rule_s_t din_5_13_r1;
rule_s_t din_5_13_r2;
logic din_valid_5_13;
logic din_valid_5_13_r1;
logic din_valid_5_13_r2;
logic din_ready_5_13;
logic din_almost_full_5_13;
logic [31:0] din_csr_readdata_5_13;
rule_s_t back_data_5_13;
logic    back_valid_5_13;
logic    back_ready_5_13;
logic [RID_WIDTH-1:0] hash_out_5_14;
logic hash_out_valid_filter_5_14;
rule_s_t din_5_14;
rule_s_t din_5_14_r1;
rule_s_t din_5_14_r2;
logic din_valid_5_14;
logic din_valid_5_14_r1;
logic din_valid_5_14_r2;
logic din_ready_5_14;
logic din_almost_full_5_14;
logic [31:0] din_csr_readdata_5_14;
rule_s_t back_data_5_14;
logic    back_valid_5_14;
logic    back_ready_5_14;
logic [RID_WIDTH-1:0] hash_out_5_15;
logic hash_out_valid_filter_5_15;
rule_s_t din_5_15;
rule_s_t din_5_15_r1;
rule_s_t din_5_15_r2;
logic din_valid_5_15;
logic din_valid_5_15_r1;
logic din_valid_5_15_r2;
logic din_ready_5_15;
logic din_almost_full_5_15;
logic [31:0] din_csr_readdata_5_15;
rule_s_t back_data_5_15;
logic    back_valid_5_15;
logic    back_ready_5_15;
logic [RID_WIDTH-1:0] hash_out_6_0;
logic hash_out_valid_filter_6_0;
rule_s_t din_6_0;
rule_s_t din_6_0_r1;
rule_s_t din_6_0_r2;
logic din_valid_6_0;
logic din_valid_6_0_r1;
logic din_valid_6_0_r2;
logic din_ready_6_0;
logic din_almost_full_6_0;
logic [31:0] din_csr_readdata_6_0;
rule_s_t back_data_6_0;
logic    back_valid_6_0;
logic    back_ready_6_0;
logic [RID_WIDTH-1:0] hash_out_6_1;
logic hash_out_valid_filter_6_1;
rule_s_t din_6_1;
rule_s_t din_6_1_r1;
rule_s_t din_6_1_r2;
logic din_valid_6_1;
logic din_valid_6_1_r1;
logic din_valid_6_1_r2;
logic din_ready_6_1;
logic din_almost_full_6_1;
logic [31:0] din_csr_readdata_6_1;
rule_s_t back_data_6_1;
logic    back_valid_6_1;
logic    back_ready_6_1;
logic [RID_WIDTH-1:0] hash_out_6_2;
logic hash_out_valid_filter_6_2;
rule_s_t din_6_2;
rule_s_t din_6_2_r1;
rule_s_t din_6_2_r2;
logic din_valid_6_2;
logic din_valid_6_2_r1;
logic din_valid_6_2_r2;
logic din_ready_6_2;
logic din_almost_full_6_2;
logic [31:0] din_csr_readdata_6_2;
rule_s_t back_data_6_2;
logic    back_valid_6_2;
logic    back_ready_6_2;
logic [RID_WIDTH-1:0] hash_out_6_3;
logic hash_out_valid_filter_6_3;
rule_s_t din_6_3;
rule_s_t din_6_3_r1;
rule_s_t din_6_3_r2;
logic din_valid_6_3;
logic din_valid_6_3_r1;
logic din_valid_6_3_r2;
logic din_ready_6_3;
logic din_almost_full_6_3;
logic [31:0] din_csr_readdata_6_3;
rule_s_t back_data_6_3;
logic    back_valid_6_3;
logic    back_ready_6_3;
logic [RID_WIDTH-1:0] hash_out_6_4;
logic hash_out_valid_filter_6_4;
rule_s_t din_6_4;
rule_s_t din_6_4_r1;
rule_s_t din_6_4_r2;
logic din_valid_6_4;
logic din_valid_6_4_r1;
logic din_valid_6_4_r2;
logic din_ready_6_4;
logic din_almost_full_6_4;
logic [31:0] din_csr_readdata_6_4;
rule_s_t back_data_6_4;
logic    back_valid_6_4;
logic    back_ready_6_4;
logic [RID_WIDTH-1:0] hash_out_6_5;
logic hash_out_valid_filter_6_5;
rule_s_t din_6_5;
rule_s_t din_6_5_r1;
rule_s_t din_6_5_r2;
logic din_valid_6_5;
logic din_valid_6_5_r1;
logic din_valid_6_5_r2;
logic din_ready_6_5;
logic din_almost_full_6_5;
logic [31:0] din_csr_readdata_6_5;
rule_s_t back_data_6_5;
logic    back_valid_6_5;
logic    back_ready_6_5;
logic [RID_WIDTH-1:0] hash_out_6_6;
logic hash_out_valid_filter_6_6;
rule_s_t din_6_6;
rule_s_t din_6_6_r1;
rule_s_t din_6_6_r2;
logic din_valid_6_6;
logic din_valid_6_6_r1;
logic din_valid_6_6_r2;
logic din_ready_6_6;
logic din_almost_full_6_6;
logic [31:0] din_csr_readdata_6_6;
rule_s_t back_data_6_6;
logic    back_valid_6_6;
logic    back_ready_6_6;
logic [RID_WIDTH-1:0] hash_out_6_7;
logic hash_out_valid_filter_6_7;
rule_s_t din_6_7;
rule_s_t din_6_7_r1;
rule_s_t din_6_7_r2;
logic din_valid_6_7;
logic din_valid_6_7_r1;
logic din_valid_6_7_r2;
logic din_ready_6_7;
logic din_almost_full_6_7;
logic [31:0] din_csr_readdata_6_7;
rule_s_t back_data_6_7;
logic    back_valid_6_7;
logic    back_ready_6_7;
logic [RID_WIDTH-1:0] hash_out_6_8;
logic hash_out_valid_filter_6_8;
rule_s_t din_6_8;
rule_s_t din_6_8_r1;
rule_s_t din_6_8_r2;
logic din_valid_6_8;
logic din_valid_6_8_r1;
logic din_valid_6_8_r2;
logic din_ready_6_8;
logic din_almost_full_6_8;
logic [31:0] din_csr_readdata_6_8;
rule_s_t back_data_6_8;
logic    back_valid_6_8;
logic    back_ready_6_8;
logic [RID_WIDTH-1:0] hash_out_6_9;
logic hash_out_valid_filter_6_9;
rule_s_t din_6_9;
rule_s_t din_6_9_r1;
rule_s_t din_6_9_r2;
logic din_valid_6_9;
logic din_valid_6_9_r1;
logic din_valid_6_9_r2;
logic din_ready_6_9;
logic din_almost_full_6_9;
logic [31:0] din_csr_readdata_6_9;
rule_s_t back_data_6_9;
logic    back_valid_6_9;
logic    back_ready_6_9;
logic [RID_WIDTH-1:0] hash_out_6_10;
logic hash_out_valid_filter_6_10;
rule_s_t din_6_10;
rule_s_t din_6_10_r1;
rule_s_t din_6_10_r2;
logic din_valid_6_10;
logic din_valid_6_10_r1;
logic din_valid_6_10_r2;
logic din_ready_6_10;
logic din_almost_full_6_10;
logic [31:0] din_csr_readdata_6_10;
rule_s_t back_data_6_10;
logic    back_valid_6_10;
logic    back_ready_6_10;
logic [RID_WIDTH-1:0] hash_out_6_11;
logic hash_out_valid_filter_6_11;
rule_s_t din_6_11;
rule_s_t din_6_11_r1;
rule_s_t din_6_11_r2;
logic din_valid_6_11;
logic din_valid_6_11_r1;
logic din_valid_6_11_r2;
logic din_ready_6_11;
logic din_almost_full_6_11;
logic [31:0] din_csr_readdata_6_11;
rule_s_t back_data_6_11;
logic    back_valid_6_11;
logic    back_ready_6_11;
logic [RID_WIDTH-1:0] hash_out_6_12;
logic hash_out_valid_filter_6_12;
rule_s_t din_6_12;
rule_s_t din_6_12_r1;
rule_s_t din_6_12_r2;
logic din_valid_6_12;
logic din_valid_6_12_r1;
logic din_valid_6_12_r2;
logic din_ready_6_12;
logic din_almost_full_6_12;
logic [31:0] din_csr_readdata_6_12;
rule_s_t back_data_6_12;
logic    back_valid_6_12;
logic    back_ready_6_12;
logic [RID_WIDTH-1:0] hash_out_6_13;
logic hash_out_valid_filter_6_13;
rule_s_t din_6_13;
rule_s_t din_6_13_r1;
rule_s_t din_6_13_r2;
logic din_valid_6_13;
logic din_valid_6_13_r1;
logic din_valid_6_13_r2;
logic din_ready_6_13;
logic din_almost_full_6_13;
logic [31:0] din_csr_readdata_6_13;
rule_s_t back_data_6_13;
logic    back_valid_6_13;
logic    back_ready_6_13;
logic [RID_WIDTH-1:0] hash_out_6_14;
logic hash_out_valid_filter_6_14;
rule_s_t din_6_14;
rule_s_t din_6_14_r1;
rule_s_t din_6_14_r2;
logic din_valid_6_14;
logic din_valid_6_14_r1;
logic din_valid_6_14_r2;
logic din_ready_6_14;
logic din_almost_full_6_14;
logic [31:0] din_csr_readdata_6_14;
rule_s_t back_data_6_14;
logic    back_valid_6_14;
logic    back_ready_6_14;
logic [RID_WIDTH-1:0] hash_out_6_15;
logic hash_out_valid_filter_6_15;
rule_s_t din_6_15;
rule_s_t din_6_15_r1;
rule_s_t din_6_15_r2;
logic din_valid_6_15;
logic din_valid_6_15_r1;
logic din_valid_6_15_r2;
logic din_ready_6_15;
logic din_almost_full_6_15;
logic [31:0] din_csr_readdata_6_15;
rule_s_t back_data_6_15;
logic    back_valid_6_15;
logic    back_ready_6_15;
logic [RID_WIDTH-1:0] hash_out_7_0;
logic hash_out_valid_filter_7_0;
rule_s_t din_7_0;
rule_s_t din_7_0_r1;
rule_s_t din_7_0_r2;
logic din_valid_7_0;
logic din_valid_7_0_r1;
logic din_valid_7_0_r2;
logic din_ready_7_0;
logic din_almost_full_7_0;
logic [31:0] din_csr_readdata_7_0;
rule_s_t back_data_7_0;
logic    back_valid_7_0;
logic    back_ready_7_0;
logic [RID_WIDTH-1:0] hash_out_7_1;
logic hash_out_valid_filter_7_1;
rule_s_t din_7_1;
rule_s_t din_7_1_r1;
rule_s_t din_7_1_r2;
logic din_valid_7_1;
logic din_valid_7_1_r1;
logic din_valid_7_1_r2;
logic din_ready_7_1;
logic din_almost_full_7_1;
logic [31:0] din_csr_readdata_7_1;
rule_s_t back_data_7_1;
logic    back_valid_7_1;
logic    back_ready_7_1;
logic [RID_WIDTH-1:0] hash_out_7_2;
logic hash_out_valid_filter_7_2;
rule_s_t din_7_2;
rule_s_t din_7_2_r1;
rule_s_t din_7_2_r2;
logic din_valid_7_2;
logic din_valid_7_2_r1;
logic din_valid_7_2_r2;
logic din_ready_7_2;
logic din_almost_full_7_2;
logic [31:0] din_csr_readdata_7_2;
rule_s_t back_data_7_2;
logic    back_valid_7_2;
logic    back_ready_7_2;
logic [RID_WIDTH-1:0] hash_out_7_3;
logic hash_out_valid_filter_7_3;
rule_s_t din_7_3;
rule_s_t din_7_3_r1;
rule_s_t din_7_3_r2;
logic din_valid_7_3;
logic din_valid_7_3_r1;
logic din_valid_7_3_r2;
logic din_ready_7_3;
logic din_almost_full_7_3;
logic [31:0] din_csr_readdata_7_3;
rule_s_t back_data_7_3;
logic    back_valid_7_3;
logic    back_ready_7_3;
logic [RID_WIDTH-1:0] hash_out_7_4;
logic hash_out_valid_filter_7_4;
rule_s_t din_7_4;
rule_s_t din_7_4_r1;
rule_s_t din_7_4_r2;
logic din_valid_7_4;
logic din_valid_7_4_r1;
logic din_valid_7_4_r2;
logic din_ready_7_4;
logic din_almost_full_7_4;
logic [31:0] din_csr_readdata_7_4;
rule_s_t back_data_7_4;
logic    back_valid_7_4;
logic    back_ready_7_4;
logic [RID_WIDTH-1:0] hash_out_7_5;
logic hash_out_valid_filter_7_5;
rule_s_t din_7_5;
rule_s_t din_7_5_r1;
rule_s_t din_7_5_r2;
logic din_valid_7_5;
logic din_valid_7_5_r1;
logic din_valid_7_5_r2;
logic din_ready_7_5;
logic din_almost_full_7_5;
logic [31:0] din_csr_readdata_7_5;
rule_s_t back_data_7_5;
logic    back_valid_7_5;
logic    back_ready_7_5;
logic [RID_WIDTH-1:0] hash_out_7_6;
logic hash_out_valid_filter_7_6;
rule_s_t din_7_6;
rule_s_t din_7_6_r1;
rule_s_t din_7_6_r2;
logic din_valid_7_6;
logic din_valid_7_6_r1;
logic din_valid_7_6_r2;
logic din_ready_7_6;
logic din_almost_full_7_6;
logic [31:0] din_csr_readdata_7_6;
rule_s_t back_data_7_6;
logic    back_valid_7_6;
logic    back_ready_7_6;
logic [RID_WIDTH-1:0] hash_out_7_7;
logic hash_out_valid_filter_7_7;
rule_s_t din_7_7;
rule_s_t din_7_7_r1;
rule_s_t din_7_7_r2;
logic din_valid_7_7;
logic din_valid_7_7_r1;
logic din_valid_7_7_r2;
logic din_ready_7_7;
logic din_almost_full_7_7;
logic [31:0] din_csr_readdata_7_7;
rule_s_t back_data_7_7;
logic    back_valid_7_7;
logic    back_ready_7_7;
logic [RID_WIDTH-1:0] hash_out_7_8;
logic hash_out_valid_filter_7_8;
rule_s_t din_7_8;
rule_s_t din_7_8_r1;
rule_s_t din_7_8_r2;
logic din_valid_7_8;
logic din_valid_7_8_r1;
logic din_valid_7_8_r2;
logic din_ready_7_8;
logic din_almost_full_7_8;
logic [31:0] din_csr_readdata_7_8;
rule_s_t back_data_7_8;
logic    back_valid_7_8;
logic    back_ready_7_8;
logic [RID_WIDTH-1:0] hash_out_7_9;
logic hash_out_valid_filter_7_9;
rule_s_t din_7_9;
rule_s_t din_7_9_r1;
rule_s_t din_7_9_r2;
logic din_valid_7_9;
logic din_valid_7_9_r1;
logic din_valid_7_9_r2;
logic din_ready_7_9;
logic din_almost_full_7_9;
logic [31:0] din_csr_readdata_7_9;
rule_s_t back_data_7_9;
logic    back_valid_7_9;
logic    back_ready_7_9;
logic [RID_WIDTH-1:0] hash_out_7_10;
logic hash_out_valid_filter_7_10;
rule_s_t din_7_10;
rule_s_t din_7_10_r1;
rule_s_t din_7_10_r2;
logic din_valid_7_10;
logic din_valid_7_10_r1;
logic din_valid_7_10_r2;
logic din_ready_7_10;
logic din_almost_full_7_10;
logic [31:0] din_csr_readdata_7_10;
rule_s_t back_data_7_10;
logic    back_valid_7_10;
logic    back_ready_7_10;
logic [RID_WIDTH-1:0] hash_out_7_11;
logic hash_out_valid_filter_7_11;
rule_s_t din_7_11;
rule_s_t din_7_11_r1;
rule_s_t din_7_11_r2;
logic din_valid_7_11;
logic din_valid_7_11_r1;
logic din_valid_7_11_r2;
logic din_ready_7_11;
logic din_almost_full_7_11;
logic [31:0] din_csr_readdata_7_11;
rule_s_t back_data_7_11;
logic    back_valid_7_11;
logic    back_ready_7_11;
logic [RID_WIDTH-1:0] hash_out_7_12;
logic hash_out_valid_filter_7_12;
rule_s_t din_7_12;
rule_s_t din_7_12_r1;
rule_s_t din_7_12_r2;
logic din_valid_7_12;
logic din_valid_7_12_r1;
logic din_valid_7_12_r2;
logic din_ready_7_12;
logic din_almost_full_7_12;
logic [31:0] din_csr_readdata_7_12;
rule_s_t back_data_7_12;
logic    back_valid_7_12;
logic    back_ready_7_12;
logic [RID_WIDTH-1:0] hash_out_7_13;
logic hash_out_valid_filter_7_13;
rule_s_t din_7_13;
rule_s_t din_7_13_r1;
rule_s_t din_7_13_r2;
logic din_valid_7_13;
logic din_valid_7_13_r1;
logic din_valid_7_13_r2;
logic din_ready_7_13;
logic din_almost_full_7_13;
logic [31:0] din_csr_readdata_7_13;
rule_s_t back_data_7_13;
logic    back_valid_7_13;
logic    back_ready_7_13;
logic [RID_WIDTH-1:0] hash_out_7_14;
logic hash_out_valid_filter_7_14;
rule_s_t din_7_14;
rule_s_t din_7_14_r1;
rule_s_t din_7_14_r2;
logic din_valid_7_14;
logic din_valid_7_14_r1;
logic din_valid_7_14_r2;
logic din_ready_7_14;
logic din_almost_full_7_14;
logic [31:0] din_csr_readdata_7_14;
rule_s_t back_data_7_14;
logic    back_valid_7_14;
logic    back_ready_7_14;
logic [RID_WIDTH-1:0] hash_out_7_15;
logic hash_out_valid_filter_7_15;
rule_s_t din_7_15;
rule_s_t din_7_15_r1;
rule_s_t din_7_15_r2;
logic din_valid_7_15;
logic din_valid_7_15_r1;
logic din_valid_7_15_r2;
logic din_ready_7_15;
logic din_almost_full_7_15;
logic [31:0] din_csr_readdata_7_15;
rule_s_t back_data_7_15;
logic    back_valid_7_15;
logic    back_ready_7_15;

logic out_new_pkt;

assign piped_pkt_data_swap[7+0*8:0+0*8] = piped_pkt_data[FP_DWIDTH-1-0*8:FP_DWIDTH-8-0*8];
assign piped_pkt_data_swap[7+1*8:0+1*8] = piped_pkt_data[FP_DWIDTH-1-1*8:FP_DWIDTH-8-1*8];
assign piped_pkt_data_swap[7+2*8:0+2*8] = piped_pkt_data[FP_DWIDTH-1-2*8:FP_DWIDTH-8-2*8];
assign piped_pkt_data_swap[7+3*8:0+3*8] = piped_pkt_data[FP_DWIDTH-1-3*8:FP_DWIDTH-8-3*8];
assign piped_pkt_data_swap[7+4*8:0+4*8] = piped_pkt_data[FP_DWIDTH-1-4*8:FP_DWIDTH-8-4*8];
assign piped_pkt_data_swap[7+5*8:0+5*8] = piped_pkt_data[FP_DWIDTH-1-5*8:FP_DWIDTH-8-5*8];
assign piped_pkt_data_swap[7+6*8:0+6*8] = piped_pkt_data[FP_DWIDTH-1-6*8:FP_DWIDTH-8-6*8];
assign piped_pkt_data_swap[7+7*8:0+7*8] = piped_pkt_data[FP_DWIDTH-1-7*8:FP_DWIDTH-8-7*8];
assign piped_pkt_data_swap[7+8*8:0+8*8] = piped_pkt_data[FP_DWIDTH-1-8*8:FP_DWIDTH-8-8*8];
assign piped_pkt_data_swap[7+9*8:0+9*8] = piped_pkt_data[FP_DWIDTH-1-9*8:FP_DWIDTH-8-9*8];
assign piped_pkt_data_swap[7+10*8:0+10*8] = piped_pkt_data[FP_DWIDTH-1-10*8:FP_DWIDTH-8-10*8];
assign piped_pkt_data_swap[7+11*8:0+11*8] = piped_pkt_data[FP_DWIDTH-1-11*8:FP_DWIDTH-8-11*8];
assign piped_pkt_data_swap[7+12*8:0+12*8] = piped_pkt_data[FP_DWIDTH-1-12*8:FP_DWIDTH-8-12*8];
assign piped_pkt_data_swap[7+13*8:0+13*8] = piped_pkt_data[FP_DWIDTH-1-13*8:FP_DWIDTH-8-13*8];
assign piped_pkt_data_swap[7+14*8:0+14*8] = piped_pkt_data[FP_DWIDTH-1-14*8:FP_DWIDTH-8-14*8];
assign piped_pkt_data_swap[7+15*8:0+15*8] = piped_pkt_data[FP_DWIDTH-1-15*8:FP_DWIDTH-8-15*8];

//Insert retiming register for better timing
always @ (posedge clk) begin
    if(rst)begin
        piped_pkt_almost_full <= 0;
    end else begin
        piped_pkt_almost_full <=   din_almost_full_0_0 |  din_almost_full_0_1 |  din_almost_full_0_2 |  din_almost_full_0_3 |  din_almost_full_0_4 |  din_almost_full_0_5 |  din_almost_full_0_6 |  din_almost_full_0_7 |  din_almost_full_0_8 |  din_almost_full_0_9 |  din_almost_full_0_10 |  din_almost_full_0_11 |  din_almost_full_0_12 |  din_almost_full_0_13 |  din_almost_full_0_14 |  din_almost_full_0_15 |    din_almost_full_1_0 |  din_almost_full_1_1 |  din_almost_full_1_2 |  din_almost_full_1_3 |  din_almost_full_1_4 |  din_almost_full_1_5 |  din_almost_full_1_6 |  din_almost_full_1_7 |  din_almost_full_1_8 |  din_almost_full_1_9 |  din_almost_full_1_10 |  din_almost_full_1_11 |  din_almost_full_1_12 |  din_almost_full_1_13 |  din_almost_full_1_14 |  din_almost_full_1_15 |    din_almost_full_2_0 |  din_almost_full_2_1 |  din_almost_full_2_2 |  din_almost_full_2_3 |  din_almost_full_2_4 |  din_almost_full_2_5 |  din_almost_full_2_6 |  din_almost_full_2_7 |  din_almost_full_2_8 |  din_almost_full_2_9 |  din_almost_full_2_10 |  din_almost_full_2_11 |  din_almost_full_2_12 |  din_almost_full_2_13 |  din_almost_full_2_14 |  din_almost_full_2_15 |    din_almost_full_3_0 |  din_almost_full_3_1 |  din_almost_full_3_2 |  din_almost_full_3_3 |  din_almost_full_3_4 |  din_almost_full_3_5 |  din_almost_full_3_6 |  din_almost_full_3_7 |  din_almost_full_3_8 |  din_almost_full_3_9 |  din_almost_full_3_10 |  din_almost_full_3_11 |  din_almost_full_3_12 |  din_almost_full_3_13 |  din_almost_full_3_14 |  din_almost_full_3_15 |    din_almost_full_4_0 |  din_almost_full_4_1 |  din_almost_full_4_2 |  din_almost_full_4_3 |  din_almost_full_4_4 |  din_almost_full_4_5 |  din_almost_full_4_6 |  din_almost_full_4_7 |  din_almost_full_4_8 |  din_almost_full_4_9 |  din_almost_full_4_10 |  din_almost_full_4_11 |  din_almost_full_4_12 |  din_almost_full_4_13 |  din_almost_full_4_14 |  din_almost_full_4_15 |    din_almost_full_5_0 |  din_almost_full_5_1 |  din_almost_full_5_2 |  din_almost_full_5_3 |  din_almost_full_5_4 |  din_almost_full_5_5 |  din_almost_full_5_6 |  din_almost_full_5_7 |  din_almost_full_5_8 |  din_almost_full_5_9 |  din_almost_full_5_10 |  din_almost_full_5_11 |  din_almost_full_5_12 |  din_almost_full_5_13 |  din_almost_full_5_14 |  din_almost_full_5_15 |    din_almost_full_6_0 |  din_almost_full_6_1 |  din_almost_full_6_2 |  din_almost_full_6_3 |  din_almost_full_6_4 |  din_almost_full_6_5 |  din_almost_full_6_6 |  din_almost_full_6_7 |  din_almost_full_6_8 |  din_almost_full_6_9 |  din_almost_full_6_10 |  din_almost_full_6_11 |  din_almost_full_6_12 |  din_almost_full_6_13 |  din_almost_full_6_14 |  din_almost_full_6_15 |    din_almost_full_7_0 |  din_almost_full_7_1 |  din_almost_full_7_2 |  din_almost_full_7_3 |  din_almost_full_7_4 |  din_almost_full_7_5 |  din_almost_full_7_6 |  din_almost_full_7_7 |  din_almost_full_7_8 |  din_almost_full_7_9 |  din_almost_full_7_10 |  din_almost_full_7_11 |  din_almost_full_7_12 |  din_almost_full_7_13 |  din_almost_full_7_14 |  din_almost_full_7_15 |   0;
    end
end

//Debug
always @ (posedge clk) begin
    if(rst)begin
        in_pkt_cnt <= 0;
    end else begin
        if (in_pkt_valid & in_pkt_eop & in_pkt_ready) begin
            in_pkt_cnt <= in_pkt_cnt + 1;
        end
    end
end

always @ (posedge clk) begin
    if(rst)begin
        out_rule_cnt <= 0;
        out_rule_last_cnt <= 0;
    end else begin
        if(out_usr_valid & out_usr_ready)begin
            out_rule_cnt <= out_rule_cnt + 1;
            if(out_usr_eop)begin
                out_rule_last_cnt <= out_rule_last_cnt + 1;
            end
        end
    end
end


always@(posedge clk)begin
    din_valid_0_0 <= out_new_pkt | hash_out_valid_filter_0_0;
    din_valid_0_0_r1 <= din_valid_0_0;
    din_valid_0_0_r2 <= din_valid_0_0_r1;

    din_0_0.data <= hash_out_valid_filter_0_0 ? hash_out_0_0 : 0;
    din_0_0.last <= out_new_pkt;
    din_0_0.bucket <= 0;


    din_0_0_r1 <= din_0_0;
    din_0_0_r2 <= din_0_0_r1;
    din_valid_0_1 <= out_new_pkt | hash_out_valid_filter_0_1;
    din_valid_0_1_r1 <= din_valid_0_1;
    din_valid_0_1_r2 <= din_valid_0_1_r1;

    din_0_1.data <= hash_out_valid_filter_0_1 ? hash_out_0_1 : 0;
    din_0_1.last <= out_new_pkt;
    din_0_1.bucket <= 0;


    din_0_1_r1 <= din_0_1;
    din_0_1_r2 <= din_0_1_r1;
    din_valid_0_2 <= out_new_pkt | hash_out_valid_filter_0_2;
    din_valid_0_2_r1 <= din_valid_0_2;
    din_valid_0_2_r2 <= din_valid_0_2_r1;

    din_0_2.data <= hash_out_valid_filter_0_2 ? hash_out_0_2 : 0;
    din_0_2.last <= out_new_pkt;
    din_0_2.bucket <= 0;


    din_0_2_r1 <= din_0_2;
    din_0_2_r2 <= din_0_2_r1;
    din_valid_0_3 <= out_new_pkt | hash_out_valid_filter_0_3;
    din_valid_0_3_r1 <= din_valid_0_3;
    din_valid_0_3_r2 <= din_valid_0_3_r1;

    din_0_3.data <= hash_out_valid_filter_0_3 ? hash_out_0_3 : 0;
    din_0_3.last <= out_new_pkt;
    din_0_3.bucket <= 0;


    din_0_3_r1 <= din_0_3;
    din_0_3_r2 <= din_0_3_r1;
    din_valid_0_4 <= out_new_pkt | hash_out_valid_filter_0_4;
    din_valid_0_4_r1 <= din_valid_0_4;
    din_valid_0_4_r2 <= din_valid_0_4_r1;

    din_0_4.data <= hash_out_valid_filter_0_4 ? hash_out_0_4 : 0;
    din_0_4.last <= out_new_pkt;
    din_0_4.bucket <= 0;


    din_0_4_r1 <= din_0_4;
    din_0_4_r2 <= din_0_4_r1;
    din_valid_0_5 <= out_new_pkt | hash_out_valid_filter_0_5;
    din_valid_0_5_r1 <= din_valid_0_5;
    din_valid_0_5_r2 <= din_valid_0_5_r1;

    din_0_5.data <= hash_out_valid_filter_0_5 ? hash_out_0_5 : 0;
    din_0_5.last <= out_new_pkt;
    din_0_5.bucket <= 0;


    din_0_5_r1 <= din_0_5;
    din_0_5_r2 <= din_0_5_r1;
    din_valid_0_6 <= out_new_pkt | hash_out_valid_filter_0_6;
    din_valid_0_6_r1 <= din_valid_0_6;
    din_valid_0_6_r2 <= din_valid_0_6_r1;

    din_0_6.data <= hash_out_valid_filter_0_6 ? hash_out_0_6 : 0;
    din_0_6.last <= out_new_pkt;
    din_0_6.bucket <= 0;


    din_0_6_r1 <= din_0_6;
    din_0_6_r2 <= din_0_6_r1;
    din_valid_0_7 <= out_new_pkt | hash_out_valid_filter_0_7;
    din_valid_0_7_r1 <= din_valid_0_7;
    din_valid_0_7_r2 <= din_valid_0_7_r1;

    din_0_7.data <= hash_out_valid_filter_0_7 ? hash_out_0_7 : 0;
    din_0_7.last <= out_new_pkt;
    din_0_7.bucket <= 0;


    din_0_7_r1 <= din_0_7;
    din_0_7_r2 <= din_0_7_r1;
    din_valid_0_8 <= out_new_pkt | hash_out_valid_filter_0_8;
    din_valid_0_8_r1 <= din_valid_0_8;
    din_valid_0_8_r2 <= din_valid_0_8_r1;

    din_0_8.data <= hash_out_valid_filter_0_8 ? hash_out_0_8 : 0;
    din_0_8.last <= out_new_pkt;
    din_0_8.bucket <= 0;


    din_0_8_r1 <= din_0_8;
    din_0_8_r2 <= din_0_8_r1;
    din_valid_0_9 <= out_new_pkt | hash_out_valid_filter_0_9;
    din_valid_0_9_r1 <= din_valid_0_9;
    din_valid_0_9_r2 <= din_valid_0_9_r1;

    din_0_9.data <= hash_out_valid_filter_0_9 ? hash_out_0_9 : 0;
    din_0_9.last <= out_new_pkt;
    din_0_9.bucket <= 0;


    din_0_9_r1 <= din_0_9;
    din_0_9_r2 <= din_0_9_r1;
    din_valid_0_10 <= out_new_pkt | hash_out_valid_filter_0_10;
    din_valid_0_10_r1 <= din_valid_0_10;
    din_valid_0_10_r2 <= din_valid_0_10_r1;

    din_0_10.data <= hash_out_valid_filter_0_10 ? hash_out_0_10 : 0;
    din_0_10.last <= out_new_pkt;
    din_0_10.bucket <= 0;


    din_0_10_r1 <= din_0_10;
    din_0_10_r2 <= din_0_10_r1;
    din_valid_0_11 <= out_new_pkt | hash_out_valid_filter_0_11;
    din_valid_0_11_r1 <= din_valid_0_11;
    din_valid_0_11_r2 <= din_valid_0_11_r1;

    din_0_11.data <= hash_out_valid_filter_0_11 ? hash_out_0_11 : 0;
    din_0_11.last <= out_new_pkt;
    din_0_11.bucket <= 0;


    din_0_11_r1 <= din_0_11;
    din_0_11_r2 <= din_0_11_r1;
    din_valid_0_12 <= out_new_pkt | hash_out_valid_filter_0_12;
    din_valid_0_12_r1 <= din_valid_0_12;
    din_valid_0_12_r2 <= din_valid_0_12_r1;

    din_0_12.data <= hash_out_valid_filter_0_12 ? hash_out_0_12 : 0;
    din_0_12.last <= out_new_pkt;
    din_0_12.bucket <= 0;


    din_0_12_r1 <= din_0_12;
    din_0_12_r2 <= din_0_12_r1;
    din_valid_0_13 <= out_new_pkt | hash_out_valid_filter_0_13;
    din_valid_0_13_r1 <= din_valid_0_13;
    din_valid_0_13_r2 <= din_valid_0_13_r1;

    din_0_13.data <= hash_out_valid_filter_0_13 ? hash_out_0_13 : 0;
    din_0_13.last <= out_new_pkt;
    din_0_13.bucket <= 0;


    din_0_13_r1 <= din_0_13;
    din_0_13_r2 <= din_0_13_r1;
    din_valid_0_14 <= out_new_pkt | hash_out_valid_filter_0_14;
    din_valid_0_14_r1 <= din_valid_0_14;
    din_valid_0_14_r2 <= din_valid_0_14_r1;

    din_0_14.data <= hash_out_valid_filter_0_14 ? hash_out_0_14 : 0;
    din_0_14.last <= out_new_pkt;
    din_0_14.bucket <= 0;


    din_0_14_r1 <= din_0_14;
    din_0_14_r2 <= din_0_14_r1;
    din_valid_0_15 <= out_new_pkt | hash_out_valid_filter_0_15;
    din_valid_0_15_r1 <= din_valid_0_15;
    din_valid_0_15_r2 <= din_valid_0_15_r1;

    din_0_15.data <= hash_out_valid_filter_0_15 ? hash_out_0_15 : 0;
    din_0_15.last <= out_new_pkt;
    din_0_15.bucket <= 0;


    din_0_15_r1 <= din_0_15;
    din_0_15_r2 <= din_0_15_r1;
    din_valid_1_0 <= out_new_pkt | hash_out_valid_filter_1_0;
    din_valid_1_0_r1 <= din_valid_1_0;
    din_valid_1_0_r2 <= din_valid_1_0_r1;

    din_1_0.data <= hash_out_valid_filter_1_0 ? hash_out_1_0 : 0;
    din_1_0.last <= out_new_pkt;
    din_1_0.bucket <= 1;


    din_1_0_r1 <= din_1_0;
    din_1_0_r2 <= din_1_0_r1;
    din_valid_1_1 <= out_new_pkt | hash_out_valid_filter_1_1;
    din_valid_1_1_r1 <= din_valid_1_1;
    din_valid_1_1_r2 <= din_valid_1_1_r1;

    din_1_1.data <= hash_out_valid_filter_1_1 ? hash_out_1_1 : 0;
    din_1_1.last <= out_new_pkt;
    din_1_1.bucket <= 1;


    din_1_1_r1 <= din_1_1;
    din_1_1_r2 <= din_1_1_r1;
    din_valid_1_2 <= out_new_pkt | hash_out_valid_filter_1_2;
    din_valid_1_2_r1 <= din_valid_1_2;
    din_valid_1_2_r2 <= din_valid_1_2_r1;

    din_1_2.data <= hash_out_valid_filter_1_2 ? hash_out_1_2 : 0;
    din_1_2.last <= out_new_pkt;
    din_1_2.bucket <= 1;


    din_1_2_r1 <= din_1_2;
    din_1_2_r2 <= din_1_2_r1;
    din_valid_1_3 <= out_new_pkt | hash_out_valid_filter_1_3;
    din_valid_1_3_r1 <= din_valid_1_3;
    din_valid_1_3_r2 <= din_valid_1_3_r1;

    din_1_3.data <= hash_out_valid_filter_1_3 ? hash_out_1_3 : 0;
    din_1_3.last <= out_new_pkt;
    din_1_3.bucket <= 1;


    din_1_3_r1 <= din_1_3;
    din_1_3_r2 <= din_1_3_r1;
    din_valid_1_4 <= out_new_pkt | hash_out_valid_filter_1_4;
    din_valid_1_4_r1 <= din_valid_1_4;
    din_valid_1_4_r2 <= din_valid_1_4_r1;

    din_1_4.data <= hash_out_valid_filter_1_4 ? hash_out_1_4 : 0;
    din_1_4.last <= out_new_pkt;
    din_1_4.bucket <= 1;


    din_1_4_r1 <= din_1_4;
    din_1_4_r2 <= din_1_4_r1;
    din_valid_1_5 <= out_new_pkt | hash_out_valid_filter_1_5;
    din_valid_1_5_r1 <= din_valid_1_5;
    din_valid_1_5_r2 <= din_valid_1_5_r1;

    din_1_5.data <= hash_out_valid_filter_1_5 ? hash_out_1_5 : 0;
    din_1_5.last <= out_new_pkt;
    din_1_5.bucket <= 1;


    din_1_5_r1 <= din_1_5;
    din_1_5_r2 <= din_1_5_r1;
    din_valid_1_6 <= out_new_pkt | hash_out_valid_filter_1_6;
    din_valid_1_6_r1 <= din_valid_1_6;
    din_valid_1_6_r2 <= din_valid_1_6_r1;

    din_1_6.data <= hash_out_valid_filter_1_6 ? hash_out_1_6 : 0;
    din_1_6.last <= out_new_pkt;
    din_1_6.bucket <= 1;


    din_1_6_r1 <= din_1_6;
    din_1_6_r2 <= din_1_6_r1;
    din_valid_1_7 <= out_new_pkt | hash_out_valid_filter_1_7;
    din_valid_1_7_r1 <= din_valid_1_7;
    din_valid_1_7_r2 <= din_valid_1_7_r1;

    din_1_7.data <= hash_out_valid_filter_1_7 ? hash_out_1_7 : 0;
    din_1_7.last <= out_new_pkt;
    din_1_7.bucket <= 1;


    din_1_7_r1 <= din_1_7;
    din_1_7_r2 <= din_1_7_r1;
    din_valid_1_8 <= out_new_pkt | hash_out_valid_filter_1_8;
    din_valid_1_8_r1 <= din_valid_1_8;
    din_valid_1_8_r2 <= din_valid_1_8_r1;

    din_1_8.data <= hash_out_valid_filter_1_8 ? hash_out_1_8 : 0;
    din_1_8.last <= out_new_pkt;
    din_1_8.bucket <= 1;


    din_1_8_r1 <= din_1_8;
    din_1_8_r2 <= din_1_8_r1;
    din_valid_1_9 <= out_new_pkt | hash_out_valid_filter_1_9;
    din_valid_1_9_r1 <= din_valid_1_9;
    din_valid_1_9_r2 <= din_valid_1_9_r1;

    din_1_9.data <= hash_out_valid_filter_1_9 ? hash_out_1_9 : 0;
    din_1_9.last <= out_new_pkt;
    din_1_9.bucket <= 1;


    din_1_9_r1 <= din_1_9;
    din_1_9_r2 <= din_1_9_r1;
    din_valid_1_10 <= out_new_pkt | hash_out_valid_filter_1_10;
    din_valid_1_10_r1 <= din_valid_1_10;
    din_valid_1_10_r2 <= din_valid_1_10_r1;

    din_1_10.data <= hash_out_valid_filter_1_10 ? hash_out_1_10 : 0;
    din_1_10.last <= out_new_pkt;
    din_1_10.bucket <= 1;


    din_1_10_r1 <= din_1_10;
    din_1_10_r2 <= din_1_10_r1;
    din_valid_1_11 <= out_new_pkt | hash_out_valid_filter_1_11;
    din_valid_1_11_r1 <= din_valid_1_11;
    din_valid_1_11_r2 <= din_valid_1_11_r1;

    din_1_11.data <= hash_out_valid_filter_1_11 ? hash_out_1_11 : 0;
    din_1_11.last <= out_new_pkt;
    din_1_11.bucket <= 1;


    din_1_11_r1 <= din_1_11;
    din_1_11_r2 <= din_1_11_r1;
    din_valid_1_12 <= out_new_pkt | hash_out_valid_filter_1_12;
    din_valid_1_12_r1 <= din_valid_1_12;
    din_valid_1_12_r2 <= din_valid_1_12_r1;

    din_1_12.data <= hash_out_valid_filter_1_12 ? hash_out_1_12 : 0;
    din_1_12.last <= out_new_pkt;
    din_1_12.bucket <= 1;


    din_1_12_r1 <= din_1_12;
    din_1_12_r2 <= din_1_12_r1;
    din_valid_1_13 <= out_new_pkt | hash_out_valid_filter_1_13;
    din_valid_1_13_r1 <= din_valid_1_13;
    din_valid_1_13_r2 <= din_valid_1_13_r1;

    din_1_13.data <= hash_out_valid_filter_1_13 ? hash_out_1_13 : 0;
    din_1_13.last <= out_new_pkt;
    din_1_13.bucket <= 1;


    din_1_13_r1 <= din_1_13;
    din_1_13_r2 <= din_1_13_r1;
    din_valid_1_14 <= out_new_pkt | hash_out_valid_filter_1_14;
    din_valid_1_14_r1 <= din_valid_1_14;
    din_valid_1_14_r2 <= din_valid_1_14_r1;

    din_1_14.data <= hash_out_valid_filter_1_14 ? hash_out_1_14 : 0;
    din_1_14.last <= out_new_pkt;
    din_1_14.bucket <= 1;


    din_1_14_r1 <= din_1_14;
    din_1_14_r2 <= din_1_14_r1;
    din_valid_1_15 <= out_new_pkt | hash_out_valid_filter_1_15;
    din_valid_1_15_r1 <= din_valid_1_15;
    din_valid_1_15_r2 <= din_valid_1_15_r1;

    din_1_15.data <= hash_out_valid_filter_1_15 ? hash_out_1_15 : 0;
    din_1_15.last <= out_new_pkt;
    din_1_15.bucket <= 1;


    din_1_15_r1 <= din_1_15;
    din_1_15_r2 <= din_1_15_r1;
    din_valid_2_0 <= out_new_pkt | hash_out_valid_filter_2_0;
    din_valid_2_0_r1 <= din_valid_2_0;
    din_valid_2_0_r2 <= din_valid_2_0_r1;

    din_2_0.data <= hash_out_valid_filter_2_0 ? hash_out_2_0 : 0;
    din_2_0.last <= out_new_pkt;
    din_2_0.bucket <= 2;


    din_2_0_r1 <= din_2_0;
    din_2_0_r2 <= din_2_0_r1;
    din_valid_2_1 <= out_new_pkt | hash_out_valid_filter_2_1;
    din_valid_2_1_r1 <= din_valid_2_1;
    din_valid_2_1_r2 <= din_valid_2_1_r1;

    din_2_1.data <= hash_out_valid_filter_2_1 ? hash_out_2_1 : 0;
    din_2_1.last <= out_new_pkt;
    din_2_1.bucket <= 2;


    din_2_1_r1 <= din_2_1;
    din_2_1_r2 <= din_2_1_r1;
    din_valid_2_2 <= out_new_pkt | hash_out_valid_filter_2_2;
    din_valid_2_2_r1 <= din_valid_2_2;
    din_valid_2_2_r2 <= din_valid_2_2_r1;

    din_2_2.data <= hash_out_valid_filter_2_2 ? hash_out_2_2 : 0;
    din_2_2.last <= out_new_pkt;
    din_2_2.bucket <= 2;


    din_2_2_r1 <= din_2_2;
    din_2_2_r2 <= din_2_2_r1;
    din_valid_2_3 <= out_new_pkt | hash_out_valid_filter_2_3;
    din_valid_2_3_r1 <= din_valid_2_3;
    din_valid_2_3_r2 <= din_valid_2_3_r1;

    din_2_3.data <= hash_out_valid_filter_2_3 ? hash_out_2_3 : 0;
    din_2_3.last <= out_new_pkt;
    din_2_3.bucket <= 2;


    din_2_3_r1 <= din_2_3;
    din_2_3_r2 <= din_2_3_r1;
    din_valid_2_4 <= out_new_pkt | hash_out_valid_filter_2_4;
    din_valid_2_4_r1 <= din_valid_2_4;
    din_valid_2_4_r2 <= din_valid_2_4_r1;

    din_2_4.data <= hash_out_valid_filter_2_4 ? hash_out_2_4 : 0;
    din_2_4.last <= out_new_pkt;
    din_2_4.bucket <= 2;


    din_2_4_r1 <= din_2_4;
    din_2_4_r2 <= din_2_4_r1;
    din_valid_2_5 <= out_new_pkt | hash_out_valid_filter_2_5;
    din_valid_2_5_r1 <= din_valid_2_5;
    din_valid_2_5_r2 <= din_valid_2_5_r1;

    din_2_5.data <= hash_out_valid_filter_2_5 ? hash_out_2_5 : 0;
    din_2_5.last <= out_new_pkt;
    din_2_5.bucket <= 2;


    din_2_5_r1 <= din_2_5;
    din_2_5_r2 <= din_2_5_r1;
    din_valid_2_6 <= out_new_pkt | hash_out_valid_filter_2_6;
    din_valid_2_6_r1 <= din_valid_2_6;
    din_valid_2_6_r2 <= din_valid_2_6_r1;

    din_2_6.data <= hash_out_valid_filter_2_6 ? hash_out_2_6 : 0;
    din_2_6.last <= out_new_pkt;
    din_2_6.bucket <= 2;


    din_2_6_r1 <= din_2_6;
    din_2_6_r2 <= din_2_6_r1;
    din_valid_2_7 <= out_new_pkt | hash_out_valid_filter_2_7;
    din_valid_2_7_r1 <= din_valid_2_7;
    din_valid_2_7_r2 <= din_valid_2_7_r1;

    din_2_7.data <= hash_out_valid_filter_2_7 ? hash_out_2_7 : 0;
    din_2_7.last <= out_new_pkt;
    din_2_7.bucket <= 2;


    din_2_7_r1 <= din_2_7;
    din_2_7_r2 <= din_2_7_r1;
    din_valid_2_8 <= out_new_pkt | hash_out_valid_filter_2_8;
    din_valid_2_8_r1 <= din_valid_2_8;
    din_valid_2_8_r2 <= din_valid_2_8_r1;

    din_2_8.data <= hash_out_valid_filter_2_8 ? hash_out_2_8 : 0;
    din_2_8.last <= out_new_pkt;
    din_2_8.bucket <= 2;


    din_2_8_r1 <= din_2_8;
    din_2_8_r2 <= din_2_8_r1;
    din_valid_2_9 <= out_new_pkt | hash_out_valid_filter_2_9;
    din_valid_2_9_r1 <= din_valid_2_9;
    din_valid_2_9_r2 <= din_valid_2_9_r1;

    din_2_9.data <= hash_out_valid_filter_2_9 ? hash_out_2_9 : 0;
    din_2_9.last <= out_new_pkt;
    din_2_9.bucket <= 2;


    din_2_9_r1 <= din_2_9;
    din_2_9_r2 <= din_2_9_r1;
    din_valid_2_10 <= out_new_pkt | hash_out_valid_filter_2_10;
    din_valid_2_10_r1 <= din_valid_2_10;
    din_valid_2_10_r2 <= din_valid_2_10_r1;

    din_2_10.data <= hash_out_valid_filter_2_10 ? hash_out_2_10 : 0;
    din_2_10.last <= out_new_pkt;
    din_2_10.bucket <= 2;


    din_2_10_r1 <= din_2_10;
    din_2_10_r2 <= din_2_10_r1;
    din_valid_2_11 <= out_new_pkt | hash_out_valid_filter_2_11;
    din_valid_2_11_r1 <= din_valid_2_11;
    din_valid_2_11_r2 <= din_valid_2_11_r1;

    din_2_11.data <= hash_out_valid_filter_2_11 ? hash_out_2_11 : 0;
    din_2_11.last <= out_new_pkt;
    din_2_11.bucket <= 2;


    din_2_11_r1 <= din_2_11;
    din_2_11_r2 <= din_2_11_r1;
    din_valid_2_12 <= out_new_pkt | hash_out_valid_filter_2_12;
    din_valid_2_12_r1 <= din_valid_2_12;
    din_valid_2_12_r2 <= din_valid_2_12_r1;

    din_2_12.data <= hash_out_valid_filter_2_12 ? hash_out_2_12 : 0;
    din_2_12.last <= out_new_pkt;
    din_2_12.bucket <= 2;


    din_2_12_r1 <= din_2_12;
    din_2_12_r2 <= din_2_12_r1;
    din_valid_2_13 <= out_new_pkt | hash_out_valid_filter_2_13;
    din_valid_2_13_r1 <= din_valid_2_13;
    din_valid_2_13_r2 <= din_valid_2_13_r1;

    din_2_13.data <= hash_out_valid_filter_2_13 ? hash_out_2_13 : 0;
    din_2_13.last <= out_new_pkt;
    din_2_13.bucket <= 2;


    din_2_13_r1 <= din_2_13;
    din_2_13_r2 <= din_2_13_r1;
    din_valid_2_14 <= out_new_pkt | hash_out_valid_filter_2_14;
    din_valid_2_14_r1 <= din_valid_2_14;
    din_valid_2_14_r2 <= din_valid_2_14_r1;

    din_2_14.data <= hash_out_valid_filter_2_14 ? hash_out_2_14 : 0;
    din_2_14.last <= out_new_pkt;
    din_2_14.bucket <= 2;


    din_2_14_r1 <= din_2_14;
    din_2_14_r2 <= din_2_14_r1;
    din_valid_2_15 <= out_new_pkt | hash_out_valid_filter_2_15;
    din_valid_2_15_r1 <= din_valid_2_15;
    din_valid_2_15_r2 <= din_valid_2_15_r1;

    din_2_15.data <= hash_out_valid_filter_2_15 ? hash_out_2_15 : 0;
    din_2_15.last <= out_new_pkt;
    din_2_15.bucket <= 2;


    din_2_15_r1 <= din_2_15;
    din_2_15_r2 <= din_2_15_r1;
    din_valid_3_0 <= out_new_pkt | hash_out_valid_filter_3_0;
    din_valid_3_0_r1 <= din_valid_3_0;
    din_valid_3_0_r2 <= din_valid_3_0_r1;

    din_3_0.data <= hash_out_valid_filter_3_0 ? hash_out_3_0 : 0;
    din_3_0.last <= out_new_pkt;
    din_3_0.bucket <= 3;


    din_3_0_r1 <= din_3_0;
    din_3_0_r2 <= din_3_0_r1;
    din_valid_3_1 <= out_new_pkt | hash_out_valid_filter_3_1;
    din_valid_3_1_r1 <= din_valid_3_1;
    din_valid_3_1_r2 <= din_valid_3_1_r1;

    din_3_1.data <= hash_out_valid_filter_3_1 ? hash_out_3_1 : 0;
    din_3_1.last <= out_new_pkt;
    din_3_1.bucket <= 3;


    din_3_1_r1 <= din_3_1;
    din_3_1_r2 <= din_3_1_r1;
    din_valid_3_2 <= out_new_pkt | hash_out_valid_filter_3_2;
    din_valid_3_2_r1 <= din_valid_3_2;
    din_valid_3_2_r2 <= din_valid_3_2_r1;

    din_3_2.data <= hash_out_valid_filter_3_2 ? hash_out_3_2 : 0;
    din_3_2.last <= out_new_pkt;
    din_3_2.bucket <= 3;


    din_3_2_r1 <= din_3_2;
    din_3_2_r2 <= din_3_2_r1;
    din_valid_3_3 <= out_new_pkt | hash_out_valid_filter_3_3;
    din_valid_3_3_r1 <= din_valid_3_3;
    din_valid_3_3_r2 <= din_valid_3_3_r1;

    din_3_3.data <= hash_out_valid_filter_3_3 ? hash_out_3_3 : 0;
    din_3_3.last <= out_new_pkt;
    din_3_3.bucket <= 3;


    din_3_3_r1 <= din_3_3;
    din_3_3_r2 <= din_3_3_r1;
    din_valid_3_4 <= out_new_pkt | hash_out_valid_filter_3_4;
    din_valid_3_4_r1 <= din_valid_3_4;
    din_valid_3_4_r2 <= din_valid_3_4_r1;

    din_3_4.data <= hash_out_valid_filter_3_4 ? hash_out_3_4 : 0;
    din_3_4.last <= out_new_pkt;
    din_3_4.bucket <= 3;


    din_3_4_r1 <= din_3_4;
    din_3_4_r2 <= din_3_4_r1;
    din_valid_3_5 <= out_new_pkt | hash_out_valid_filter_3_5;
    din_valid_3_5_r1 <= din_valid_3_5;
    din_valid_3_5_r2 <= din_valid_3_5_r1;

    din_3_5.data <= hash_out_valid_filter_3_5 ? hash_out_3_5 : 0;
    din_3_5.last <= out_new_pkt;
    din_3_5.bucket <= 3;


    din_3_5_r1 <= din_3_5;
    din_3_5_r2 <= din_3_5_r1;
    din_valid_3_6 <= out_new_pkt | hash_out_valid_filter_3_6;
    din_valid_3_6_r1 <= din_valid_3_6;
    din_valid_3_6_r2 <= din_valid_3_6_r1;

    din_3_6.data <= hash_out_valid_filter_3_6 ? hash_out_3_6 : 0;
    din_3_6.last <= out_new_pkt;
    din_3_6.bucket <= 3;


    din_3_6_r1 <= din_3_6;
    din_3_6_r2 <= din_3_6_r1;
    din_valid_3_7 <= out_new_pkt | hash_out_valid_filter_3_7;
    din_valid_3_7_r1 <= din_valid_3_7;
    din_valid_3_7_r2 <= din_valid_3_7_r1;

    din_3_7.data <= hash_out_valid_filter_3_7 ? hash_out_3_7 : 0;
    din_3_7.last <= out_new_pkt;
    din_3_7.bucket <= 3;


    din_3_7_r1 <= din_3_7;
    din_3_7_r2 <= din_3_7_r1;
    din_valid_3_8 <= out_new_pkt | hash_out_valid_filter_3_8;
    din_valid_3_8_r1 <= din_valid_3_8;
    din_valid_3_8_r2 <= din_valid_3_8_r1;

    din_3_8.data <= hash_out_valid_filter_3_8 ? hash_out_3_8 : 0;
    din_3_8.last <= out_new_pkt;
    din_3_8.bucket <= 3;


    din_3_8_r1 <= din_3_8;
    din_3_8_r2 <= din_3_8_r1;
    din_valid_3_9 <= out_new_pkt | hash_out_valid_filter_3_9;
    din_valid_3_9_r1 <= din_valid_3_9;
    din_valid_3_9_r2 <= din_valid_3_9_r1;

    din_3_9.data <= hash_out_valid_filter_3_9 ? hash_out_3_9 : 0;
    din_3_9.last <= out_new_pkt;
    din_3_9.bucket <= 3;


    din_3_9_r1 <= din_3_9;
    din_3_9_r2 <= din_3_9_r1;
    din_valid_3_10 <= out_new_pkt | hash_out_valid_filter_3_10;
    din_valid_3_10_r1 <= din_valid_3_10;
    din_valid_3_10_r2 <= din_valid_3_10_r1;

    din_3_10.data <= hash_out_valid_filter_3_10 ? hash_out_3_10 : 0;
    din_3_10.last <= out_new_pkt;
    din_3_10.bucket <= 3;


    din_3_10_r1 <= din_3_10;
    din_3_10_r2 <= din_3_10_r1;
    din_valid_3_11 <= out_new_pkt | hash_out_valid_filter_3_11;
    din_valid_3_11_r1 <= din_valid_3_11;
    din_valid_3_11_r2 <= din_valid_3_11_r1;

    din_3_11.data <= hash_out_valid_filter_3_11 ? hash_out_3_11 : 0;
    din_3_11.last <= out_new_pkt;
    din_3_11.bucket <= 3;


    din_3_11_r1 <= din_3_11;
    din_3_11_r2 <= din_3_11_r1;
    din_valid_3_12 <= out_new_pkt | hash_out_valid_filter_3_12;
    din_valid_3_12_r1 <= din_valid_3_12;
    din_valid_3_12_r2 <= din_valid_3_12_r1;

    din_3_12.data <= hash_out_valid_filter_3_12 ? hash_out_3_12 : 0;
    din_3_12.last <= out_new_pkt;
    din_3_12.bucket <= 3;


    din_3_12_r1 <= din_3_12;
    din_3_12_r2 <= din_3_12_r1;
    din_valid_3_13 <= out_new_pkt | hash_out_valid_filter_3_13;
    din_valid_3_13_r1 <= din_valid_3_13;
    din_valid_3_13_r2 <= din_valid_3_13_r1;

    din_3_13.data <= hash_out_valid_filter_3_13 ? hash_out_3_13 : 0;
    din_3_13.last <= out_new_pkt;
    din_3_13.bucket <= 3;


    din_3_13_r1 <= din_3_13;
    din_3_13_r2 <= din_3_13_r1;
    din_valid_3_14 <= out_new_pkt | hash_out_valid_filter_3_14;
    din_valid_3_14_r1 <= din_valid_3_14;
    din_valid_3_14_r2 <= din_valid_3_14_r1;

    din_3_14.data <= hash_out_valid_filter_3_14 ? hash_out_3_14 : 0;
    din_3_14.last <= out_new_pkt;
    din_3_14.bucket <= 3;


    din_3_14_r1 <= din_3_14;
    din_3_14_r2 <= din_3_14_r1;
    din_valid_3_15 <= out_new_pkt | hash_out_valid_filter_3_15;
    din_valid_3_15_r1 <= din_valid_3_15;
    din_valid_3_15_r2 <= din_valid_3_15_r1;

    din_3_15.data <= hash_out_valid_filter_3_15 ? hash_out_3_15 : 0;
    din_3_15.last <= out_new_pkt;
    din_3_15.bucket <= 3;


    din_3_15_r1 <= din_3_15;
    din_3_15_r2 <= din_3_15_r1;
    din_valid_4_0 <= out_new_pkt | hash_out_valid_filter_4_0;
    din_valid_4_0_r1 <= din_valid_4_0;
    din_valid_4_0_r2 <= din_valid_4_0_r1;

    din_4_0.data <= hash_out_valid_filter_4_0 ? hash_out_4_0 : 0;
    din_4_0.last <= out_new_pkt;
    din_4_0.bucket <= 4;


    din_4_0_r1 <= din_4_0;
    din_4_0_r2 <= din_4_0_r1;
    din_valid_4_1 <= out_new_pkt | hash_out_valid_filter_4_1;
    din_valid_4_1_r1 <= din_valid_4_1;
    din_valid_4_1_r2 <= din_valid_4_1_r1;

    din_4_1.data <= hash_out_valid_filter_4_1 ? hash_out_4_1 : 0;
    din_4_1.last <= out_new_pkt;
    din_4_1.bucket <= 4;


    din_4_1_r1 <= din_4_1;
    din_4_1_r2 <= din_4_1_r1;
    din_valid_4_2 <= out_new_pkt | hash_out_valid_filter_4_2;
    din_valid_4_2_r1 <= din_valid_4_2;
    din_valid_4_2_r2 <= din_valid_4_2_r1;

    din_4_2.data <= hash_out_valid_filter_4_2 ? hash_out_4_2 : 0;
    din_4_2.last <= out_new_pkt;
    din_4_2.bucket <= 4;


    din_4_2_r1 <= din_4_2;
    din_4_2_r2 <= din_4_2_r1;
    din_valid_4_3 <= out_new_pkt | hash_out_valid_filter_4_3;
    din_valid_4_3_r1 <= din_valid_4_3;
    din_valid_4_3_r2 <= din_valid_4_3_r1;

    din_4_3.data <= hash_out_valid_filter_4_3 ? hash_out_4_3 : 0;
    din_4_3.last <= out_new_pkt;
    din_4_3.bucket <= 4;


    din_4_3_r1 <= din_4_3;
    din_4_3_r2 <= din_4_3_r1;
    din_valid_4_4 <= out_new_pkt | hash_out_valid_filter_4_4;
    din_valid_4_4_r1 <= din_valid_4_4;
    din_valid_4_4_r2 <= din_valid_4_4_r1;

    din_4_4.data <= hash_out_valid_filter_4_4 ? hash_out_4_4 : 0;
    din_4_4.last <= out_new_pkt;
    din_4_4.bucket <= 4;


    din_4_4_r1 <= din_4_4;
    din_4_4_r2 <= din_4_4_r1;
    din_valid_4_5 <= out_new_pkt | hash_out_valid_filter_4_5;
    din_valid_4_5_r1 <= din_valid_4_5;
    din_valid_4_5_r2 <= din_valid_4_5_r1;

    din_4_5.data <= hash_out_valid_filter_4_5 ? hash_out_4_5 : 0;
    din_4_5.last <= out_new_pkt;
    din_4_5.bucket <= 4;


    din_4_5_r1 <= din_4_5;
    din_4_5_r2 <= din_4_5_r1;
    din_valid_4_6 <= out_new_pkt | hash_out_valid_filter_4_6;
    din_valid_4_6_r1 <= din_valid_4_6;
    din_valid_4_6_r2 <= din_valid_4_6_r1;

    din_4_6.data <= hash_out_valid_filter_4_6 ? hash_out_4_6 : 0;
    din_4_6.last <= out_new_pkt;
    din_4_6.bucket <= 4;


    din_4_6_r1 <= din_4_6;
    din_4_6_r2 <= din_4_6_r1;
    din_valid_4_7 <= out_new_pkt | hash_out_valid_filter_4_7;
    din_valid_4_7_r1 <= din_valid_4_7;
    din_valid_4_7_r2 <= din_valid_4_7_r1;

    din_4_7.data <= hash_out_valid_filter_4_7 ? hash_out_4_7 : 0;
    din_4_7.last <= out_new_pkt;
    din_4_7.bucket <= 4;


    din_4_7_r1 <= din_4_7;
    din_4_7_r2 <= din_4_7_r1;
    din_valid_4_8 <= out_new_pkt | hash_out_valid_filter_4_8;
    din_valid_4_8_r1 <= din_valid_4_8;
    din_valid_4_8_r2 <= din_valid_4_8_r1;

    din_4_8.data <= hash_out_valid_filter_4_8 ? hash_out_4_8 : 0;
    din_4_8.last <= out_new_pkt;
    din_4_8.bucket <= 4;


    din_4_8_r1 <= din_4_8;
    din_4_8_r2 <= din_4_8_r1;
    din_valid_4_9 <= out_new_pkt | hash_out_valid_filter_4_9;
    din_valid_4_9_r1 <= din_valid_4_9;
    din_valid_4_9_r2 <= din_valid_4_9_r1;

    din_4_9.data <= hash_out_valid_filter_4_9 ? hash_out_4_9 : 0;
    din_4_9.last <= out_new_pkt;
    din_4_9.bucket <= 4;


    din_4_9_r1 <= din_4_9;
    din_4_9_r2 <= din_4_9_r1;
    din_valid_4_10 <= out_new_pkt | hash_out_valid_filter_4_10;
    din_valid_4_10_r1 <= din_valid_4_10;
    din_valid_4_10_r2 <= din_valid_4_10_r1;

    din_4_10.data <= hash_out_valid_filter_4_10 ? hash_out_4_10 : 0;
    din_4_10.last <= out_new_pkt;
    din_4_10.bucket <= 4;


    din_4_10_r1 <= din_4_10;
    din_4_10_r2 <= din_4_10_r1;
    din_valid_4_11 <= out_new_pkt | hash_out_valid_filter_4_11;
    din_valid_4_11_r1 <= din_valid_4_11;
    din_valid_4_11_r2 <= din_valid_4_11_r1;

    din_4_11.data <= hash_out_valid_filter_4_11 ? hash_out_4_11 : 0;
    din_4_11.last <= out_new_pkt;
    din_4_11.bucket <= 4;


    din_4_11_r1 <= din_4_11;
    din_4_11_r2 <= din_4_11_r1;
    din_valid_4_12 <= out_new_pkt | hash_out_valid_filter_4_12;
    din_valid_4_12_r1 <= din_valid_4_12;
    din_valid_4_12_r2 <= din_valid_4_12_r1;

    din_4_12.data <= hash_out_valid_filter_4_12 ? hash_out_4_12 : 0;
    din_4_12.last <= out_new_pkt;
    din_4_12.bucket <= 4;


    din_4_12_r1 <= din_4_12;
    din_4_12_r2 <= din_4_12_r1;
    din_valid_4_13 <= out_new_pkt | hash_out_valid_filter_4_13;
    din_valid_4_13_r1 <= din_valid_4_13;
    din_valid_4_13_r2 <= din_valid_4_13_r1;

    din_4_13.data <= hash_out_valid_filter_4_13 ? hash_out_4_13 : 0;
    din_4_13.last <= out_new_pkt;
    din_4_13.bucket <= 4;


    din_4_13_r1 <= din_4_13;
    din_4_13_r2 <= din_4_13_r1;
    din_valid_4_14 <= out_new_pkt | hash_out_valid_filter_4_14;
    din_valid_4_14_r1 <= din_valid_4_14;
    din_valid_4_14_r2 <= din_valid_4_14_r1;

    din_4_14.data <= hash_out_valid_filter_4_14 ? hash_out_4_14 : 0;
    din_4_14.last <= out_new_pkt;
    din_4_14.bucket <= 4;


    din_4_14_r1 <= din_4_14;
    din_4_14_r2 <= din_4_14_r1;
    din_valid_4_15 <= out_new_pkt | hash_out_valid_filter_4_15;
    din_valid_4_15_r1 <= din_valid_4_15;
    din_valid_4_15_r2 <= din_valid_4_15_r1;

    din_4_15.data <= hash_out_valid_filter_4_15 ? hash_out_4_15 : 0;
    din_4_15.last <= out_new_pkt;
    din_4_15.bucket <= 4;


    din_4_15_r1 <= din_4_15;
    din_4_15_r2 <= din_4_15_r1;
    din_valid_5_0 <= out_new_pkt | hash_out_valid_filter_5_0;
    din_valid_5_0_r1 <= din_valid_5_0;
    din_valid_5_0_r2 <= din_valid_5_0_r1;

    din_5_0.data <= hash_out_valid_filter_5_0 ? hash_out_5_0 : 0;
    din_5_0.last <= out_new_pkt;
    din_5_0.bucket <= 5;


    din_5_0_r1 <= din_5_0;
    din_5_0_r2 <= din_5_0_r1;
    din_valid_5_1 <= out_new_pkt | hash_out_valid_filter_5_1;
    din_valid_5_1_r1 <= din_valid_5_1;
    din_valid_5_1_r2 <= din_valid_5_1_r1;

    din_5_1.data <= hash_out_valid_filter_5_1 ? hash_out_5_1 : 0;
    din_5_1.last <= out_new_pkt;
    din_5_1.bucket <= 5;


    din_5_1_r1 <= din_5_1;
    din_5_1_r2 <= din_5_1_r1;
    din_valid_5_2 <= out_new_pkt | hash_out_valid_filter_5_2;
    din_valid_5_2_r1 <= din_valid_5_2;
    din_valid_5_2_r2 <= din_valid_5_2_r1;

    din_5_2.data <= hash_out_valid_filter_5_2 ? hash_out_5_2 : 0;
    din_5_2.last <= out_new_pkt;
    din_5_2.bucket <= 5;


    din_5_2_r1 <= din_5_2;
    din_5_2_r2 <= din_5_2_r1;
    din_valid_5_3 <= out_new_pkt | hash_out_valid_filter_5_3;
    din_valid_5_3_r1 <= din_valid_5_3;
    din_valid_5_3_r2 <= din_valid_5_3_r1;

    din_5_3.data <= hash_out_valid_filter_5_3 ? hash_out_5_3 : 0;
    din_5_3.last <= out_new_pkt;
    din_5_3.bucket <= 5;


    din_5_3_r1 <= din_5_3;
    din_5_3_r2 <= din_5_3_r1;
    din_valid_5_4 <= out_new_pkt | hash_out_valid_filter_5_4;
    din_valid_5_4_r1 <= din_valid_5_4;
    din_valid_5_4_r2 <= din_valid_5_4_r1;

    din_5_4.data <= hash_out_valid_filter_5_4 ? hash_out_5_4 : 0;
    din_5_4.last <= out_new_pkt;
    din_5_4.bucket <= 5;


    din_5_4_r1 <= din_5_4;
    din_5_4_r2 <= din_5_4_r1;
    din_valid_5_5 <= out_new_pkt | hash_out_valid_filter_5_5;
    din_valid_5_5_r1 <= din_valid_5_5;
    din_valid_5_5_r2 <= din_valid_5_5_r1;

    din_5_5.data <= hash_out_valid_filter_5_5 ? hash_out_5_5 : 0;
    din_5_5.last <= out_new_pkt;
    din_5_5.bucket <= 5;


    din_5_5_r1 <= din_5_5;
    din_5_5_r2 <= din_5_5_r1;
    din_valid_5_6 <= out_new_pkt | hash_out_valid_filter_5_6;
    din_valid_5_6_r1 <= din_valid_5_6;
    din_valid_5_6_r2 <= din_valid_5_6_r1;

    din_5_6.data <= hash_out_valid_filter_5_6 ? hash_out_5_6 : 0;
    din_5_6.last <= out_new_pkt;
    din_5_6.bucket <= 5;


    din_5_6_r1 <= din_5_6;
    din_5_6_r2 <= din_5_6_r1;
    din_valid_5_7 <= out_new_pkt | hash_out_valid_filter_5_7;
    din_valid_5_7_r1 <= din_valid_5_7;
    din_valid_5_7_r2 <= din_valid_5_7_r1;

    din_5_7.data <= hash_out_valid_filter_5_7 ? hash_out_5_7 : 0;
    din_5_7.last <= out_new_pkt;
    din_5_7.bucket <= 5;


    din_5_7_r1 <= din_5_7;
    din_5_7_r2 <= din_5_7_r1;
    din_valid_5_8 <= out_new_pkt | hash_out_valid_filter_5_8;
    din_valid_5_8_r1 <= din_valid_5_8;
    din_valid_5_8_r2 <= din_valid_5_8_r1;

    din_5_8.data <= hash_out_valid_filter_5_8 ? hash_out_5_8 : 0;
    din_5_8.last <= out_new_pkt;
    din_5_8.bucket <= 5;


    din_5_8_r1 <= din_5_8;
    din_5_8_r2 <= din_5_8_r1;
    din_valid_5_9 <= out_new_pkt | hash_out_valid_filter_5_9;
    din_valid_5_9_r1 <= din_valid_5_9;
    din_valid_5_9_r2 <= din_valid_5_9_r1;

    din_5_9.data <= hash_out_valid_filter_5_9 ? hash_out_5_9 : 0;
    din_5_9.last <= out_new_pkt;
    din_5_9.bucket <= 5;


    din_5_9_r1 <= din_5_9;
    din_5_9_r2 <= din_5_9_r1;
    din_valid_5_10 <= out_new_pkt | hash_out_valid_filter_5_10;
    din_valid_5_10_r1 <= din_valid_5_10;
    din_valid_5_10_r2 <= din_valid_5_10_r1;

    din_5_10.data <= hash_out_valid_filter_5_10 ? hash_out_5_10 : 0;
    din_5_10.last <= out_new_pkt;
    din_5_10.bucket <= 5;


    din_5_10_r1 <= din_5_10;
    din_5_10_r2 <= din_5_10_r1;
    din_valid_5_11 <= out_new_pkt | hash_out_valid_filter_5_11;
    din_valid_5_11_r1 <= din_valid_5_11;
    din_valid_5_11_r2 <= din_valid_5_11_r1;

    din_5_11.data <= hash_out_valid_filter_5_11 ? hash_out_5_11 : 0;
    din_5_11.last <= out_new_pkt;
    din_5_11.bucket <= 5;


    din_5_11_r1 <= din_5_11;
    din_5_11_r2 <= din_5_11_r1;
    din_valid_5_12 <= out_new_pkt | hash_out_valid_filter_5_12;
    din_valid_5_12_r1 <= din_valid_5_12;
    din_valid_5_12_r2 <= din_valid_5_12_r1;

    din_5_12.data <= hash_out_valid_filter_5_12 ? hash_out_5_12 : 0;
    din_5_12.last <= out_new_pkt;
    din_5_12.bucket <= 5;


    din_5_12_r1 <= din_5_12;
    din_5_12_r2 <= din_5_12_r1;
    din_valid_5_13 <= out_new_pkt | hash_out_valid_filter_5_13;
    din_valid_5_13_r1 <= din_valid_5_13;
    din_valid_5_13_r2 <= din_valid_5_13_r1;

    din_5_13.data <= hash_out_valid_filter_5_13 ? hash_out_5_13 : 0;
    din_5_13.last <= out_new_pkt;
    din_5_13.bucket <= 5;


    din_5_13_r1 <= din_5_13;
    din_5_13_r2 <= din_5_13_r1;
    din_valid_5_14 <= out_new_pkt | hash_out_valid_filter_5_14;
    din_valid_5_14_r1 <= din_valid_5_14;
    din_valid_5_14_r2 <= din_valid_5_14_r1;

    din_5_14.data <= hash_out_valid_filter_5_14 ? hash_out_5_14 : 0;
    din_5_14.last <= out_new_pkt;
    din_5_14.bucket <= 5;


    din_5_14_r1 <= din_5_14;
    din_5_14_r2 <= din_5_14_r1;
    din_valid_5_15 <= out_new_pkt | hash_out_valid_filter_5_15;
    din_valid_5_15_r1 <= din_valid_5_15;
    din_valid_5_15_r2 <= din_valid_5_15_r1;

    din_5_15.data <= hash_out_valid_filter_5_15 ? hash_out_5_15 : 0;
    din_5_15.last <= out_new_pkt;
    din_5_15.bucket <= 5;


    din_5_15_r1 <= din_5_15;
    din_5_15_r2 <= din_5_15_r1;
    din_valid_6_0 <= out_new_pkt | hash_out_valid_filter_6_0;
    din_valid_6_0_r1 <= din_valid_6_0;
    din_valid_6_0_r2 <= din_valid_6_0_r1;

    din_6_0.data <= hash_out_valid_filter_6_0 ? hash_out_6_0 : 0;
    din_6_0.last <= out_new_pkt;
    din_6_0.bucket <= 6;


    din_6_0_r1 <= din_6_0;
    din_6_0_r2 <= din_6_0_r1;
    din_valid_6_1 <= out_new_pkt | hash_out_valid_filter_6_1;
    din_valid_6_1_r1 <= din_valid_6_1;
    din_valid_6_1_r2 <= din_valid_6_1_r1;

    din_6_1.data <= hash_out_valid_filter_6_1 ? hash_out_6_1 : 0;
    din_6_1.last <= out_new_pkt;
    din_6_1.bucket <= 6;


    din_6_1_r1 <= din_6_1;
    din_6_1_r2 <= din_6_1_r1;
    din_valid_6_2 <= out_new_pkt | hash_out_valid_filter_6_2;
    din_valid_6_2_r1 <= din_valid_6_2;
    din_valid_6_2_r2 <= din_valid_6_2_r1;

    din_6_2.data <= hash_out_valid_filter_6_2 ? hash_out_6_2 : 0;
    din_6_2.last <= out_new_pkt;
    din_6_2.bucket <= 6;


    din_6_2_r1 <= din_6_2;
    din_6_2_r2 <= din_6_2_r1;
    din_valid_6_3 <= out_new_pkt | hash_out_valid_filter_6_3;
    din_valid_6_3_r1 <= din_valid_6_3;
    din_valid_6_3_r2 <= din_valid_6_3_r1;

    din_6_3.data <= hash_out_valid_filter_6_3 ? hash_out_6_3 : 0;
    din_6_3.last <= out_new_pkt;
    din_6_3.bucket <= 6;


    din_6_3_r1 <= din_6_3;
    din_6_3_r2 <= din_6_3_r1;
    din_valid_6_4 <= out_new_pkt | hash_out_valid_filter_6_4;
    din_valid_6_4_r1 <= din_valid_6_4;
    din_valid_6_4_r2 <= din_valid_6_4_r1;

    din_6_4.data <= hash_out_valid_filter_6_4 ? hash_out_6_4 : 0;
    din_6_4.last <= out_new_pkt;
    din_6_4.bucket <= 6;


    din_6_4_r1 <= din_6_4;
    din_6_4_r2 <= din_6_4_r1;
    din_valid_6_5 <= out_new_pkt | hash_out_valid_filter_6_5;
    din_valid_6_5_r1 <= din_valid_6_5;
    din_valid_6_5_r2 <= din_valid_6_5_r1;

    din_6_5.data <= hash_out_valid_filter_6_5 ? hash_out_6_5 : 0;
    din_6_5.last <= out_new_pkt;
    din_6_5.bucket <= 6;


    din_6_5_r1 <= din_6_5;
    din_6_5_r2 <= din_6_5_r1;
    din_valid_6_6 <= out_new_pkt | hash_out_valid_filter_6_6;
    din_valid_6_6_r1 <= din_valid_6_6;
    din_valid_6_6_r2 <= din_valid_6_6_r1;

    din_6_6.data <= hash_out_valid_filter_6_6 ? hash_out_6_6 : 0;
    din_6_6.last <= out_new_pkt;
    din_6_6.bucket <= 6;


    din_6_6_r1 <= din_6_6;
    din_6_6_r2 <= din_6_6_r1;
    din_valid_6_7 <= out_new_pkt | hash_out_valid_filter_6_7;
    din_valid_6_7_r1 <= din_valid_6_7;
    din_valid_6_7_r2 <= din_valid_6_7_r1;

    din_6_7.data <= hash_out_valid_filter_6_7 ? hash_out_6_7 : 0;
    din_6_7.last <= out_new_pkt;
    din_6_7.bucket <= 6;


    din_6_7_r1 <= din_6_7;
    din_6_7_r2 <= din_6_7_r1;
    din_valid_6_8 <= out_new_pkt | hash_out_valid_filter_6_8;
    din_valid_6_8_r1 <= din_valid_6_8;
    din_valid_6_8_r2 <= din_valid_6_8_r1;

    din_6_8.data <= hash_out_valid_filter_6_8 ? hash_out_6_8 : 0;
    din_6_8.last <= out_new_pkt;
    din_6_8.bucket <= 6;


    din_6_8_r1 <= din_6_8;
    din_6_8_r2 <= din_6_8_r1;
    din_valid_6_9 <= out_new_pkt | hash_out_valid_filter_6_9;
    din_valid_6_9_r1 <= din_valid_6_9;
    din_valid_6_9_r2 <= din_valid_6_9_r1;

    din_6_9.data <= hash_out_valid_filter_6_9 ? hash_out_6_9 : 0;
    din_6_9.last <= out_new_pkt;
    din_6_9.bucket <= 6;


    din_6_9_r1 <= din_6_9;
    din_6_9_r2 <= din_6_9_r1;
    din_valid_6_10 <= out_new_pkt | hash_out_valid_filter_6_10;
    din_valid_6_10_r1 <= din_valid_6_10;
    din_valid_6_10_r2 <= din_valid_6_10_r1;

    din_6_10.data <= hash_out_valid_filter_6_10 ? hash_out_6_10 : 0;
    din_6_10.last <= out_new_pkt;
    din_6_10.bucket <= 6;


    din_6_10_r1 <= din_6_10;
    din_6_10_r2 <= din_6_10_r1;
    din_valid_6_11 <= out_new_pkt | hash_out_valid_filter_6_11;
    din_valid_6_11_r1 <= din_valid_6_11;
    din_valid_6_11_r2 <= din_valid_6_11_r1;

    din_6_11.data <= hash_out_valid_filter_6_11 ? hash_out_6_11 : 0;
    din_6_11.last <= out_new_pkt;
    din_6_11.bucket <= 6;


    din_6_11_r1 <= din_6_11;
    din_6_11_r2 <= din_6_11_r1;
    din_valid_6_12 <= out_new_pkt | hash_out_valid_filter_6_12;
    din_valid_6_12_r1 <= din_valid_6_12;
    din_valid_6_12_r2 <= din_valid_6_12_r1;

    din_6_12.data <= hash_out_valid_filter_6_12 ? hash_out_6_12 : 0;
    din_6_12.last <= out_new_pkt;
    din_6_12.bucket <= 6;


    din_6_12_r1 <= din_6_12;
    din_6_12_r2 <= din_6_12_r1;
    din_valid_6_13 <= out_new_pkt | hash_out_valid_filter_6_13;
    din_valid_6_13_r1 <= din_valid_6_13;
    din_valid_6_13_r2 <= din_valid_6_13_r1;

    din_6_13.data <= hash_out_valid_filter_6_13 ? hash_out_6_13 : 0;
    din_6_13.last <= out_new_pkt;
    din_6_13.bucket <= 6;


    din_6_13_r1 <= din_6_13;
    din_6_13_r2 <= din_6_13_r1;
    din_valid_6_14 <= out_new_pkt | hash_out_valid_filter_6_14;
    din_valid_6_14_r1 <= din_valid_6_14;
    din_valid_6_14_r2 <= din_valid_6_14_r1;

    din_6_14.data <= hash_out_valid_filter_6_14 ? hash_out_6_14 : 0;
    din_6_14.last <= out_new_pkt;
    din_6_14.bucket <= 6;


    din_6_14_r1 <= din_6_14;
    din_6_14_r2 <= din_6_14_r1;
    din_valid_6_15 <= out_new_pkt | hash_out_valid_filter_6_15;
    din_valid_6_15_r1 <= din_valid_6_15;
    din_valid_6_15_r2 <= din_valid_6_15_r1;

    din_6_15.data <= hash_out_valid_filter_6_15 ? hash_out_6_15 : 0;
    din_6_15.last <= out_new_pkt;
    din_6_15.bucket <= 6;


    din_6_15_r1 <= din_6_15;
    din_6_15_r2 <= din_6_15_r1;
    din_valid_7_0 <= out_new_pkt | hash_out_valid_filter_7_0;
    din_valid_7_0_r1 <= din_valid_7_0;
    din_valid_7_0_r2 <= din_valid_7_0_r1;

    din_7_0.data <= hash_out_valid_filter_7_0 ? hash_out_7_0 : 0;
    din_7_0.last <= out_new_pkt;
    din_7_0.bucket <= 7;


    din_7_0_r1 <= din_7_0;
    din_7_0_r2 <= din_7_0_r1;
    din_valid_7_1 <= out_new_pkt | hash_out_valid_filter_7_1;
    din_valid_7_1_r1 <= din_valid_7_1;
    din_valid_7_1_r2 <= din_valid_7_1_r1;

    din_7_1.data <= hash_out_valid_filter_7_1 ? hash_out_7_1 : 0;
    din_7_1.last <= out_new_pkt;
    din_7_1.bucket <= 7;


    din_7_1_r1 <= din_7_1;
    din_7_1_r2 <= din_7_1_r1;
    din_valid_7_2 <= out_new_pkt | hash_out_valid_filter_7_2;
    din_valid_7_2_r1 <= din_valid_7_2;
    din_valid_7_2_r2 <= din_valid_7_2_r1;

    din_7_2.data <= hash_out_valid_filter_7_2 ? hash_out_7_2 : 0;
    din_7_2.last <= out_new_pkt;
    din_7_2.bucket <= 7;


    din_7_2_r1 <= din_7_2;
    din_7_2_r2 <= din_7_2_r1;
    din_valid_7_3 <= out_new_pkt | hash_out_valid_filter_7_3;
    din_valid_7_3_r1 <= din_valid_7_3;
    din_valid_7_3_r2 <= din_valid_7_3_r1;

    din_7_3.data <= hash_out_valid_filter_7_3 ? hash_out_7_3 : 0;
    din_7_3.last <= out_new_pkt;
    din_7_3.bucket <= 7;


    din_7_3_r1 <= din_7_3;
    din_7_3_r2 <= din_7_3_r1;
    din_valid_7_4 <= out_new_pkt | hash_out_valid_filter_7_4;
    din_valid_7_4_r1 <= din_valid_7_4;
    din_valid_7_4_r2 <= din_valid_7_4_r1;

    din_7_4.data <= hash_out_valid_filter_7_4 ? hash_out_7_4 : 0;
    din_7_4.last <= out_new_pkt;
    din_7_4.bucket <= 7;


    din_7_4_r1 <= din_7_4;
    din_7_4_r2 <= din_7_4_r1;
    din_valid_7_5 <= out_new_pkt | hash_out_valid_filter_7_5;
    din_valid_7_5_r1 <= din_valid_7_5;
    din_valid_7_5_r2 <= din_valid_7_5_r1;

    din_7_5.data <= hash_out_valid_filter_7_5 ? hash_out_7_5 : 0;
    din_7_5.last <= out_new_pkt;
    din_7_5.bucket <= 7;


    din_7_5_r1 <= din_7_5;
    din_7_5_r2 <= din_7_5_r1;
    din_valid_7_6 <= out_new_pkt | hash_out_valid_filter_7_6;
    din_valid_7_6_r1 <= din_valid_7_6;
    din_valid_7_6_r2 <= din_valid_7_6_r1;

    din_7_6.data <= hash_out_valid_filter_7_6 ? hash_out_7_6 : 0;
    din_7_6.last <= out_new_pkt;
    din_7_6.bucket <= 7;


    din_7_6_r1 <= din_7_6;
    din_7_6_r2 <= din_7_6_r1;
    din_valid_7_7 <= out_new_pkt | hash_out_valid_filter_7_7;
    din_valid_7_7_r1 <= din_valid_7_7;
    din_valid_7_7_r2 <= din_valid_7_7_r1;

    din_7_7.data <= hash_out_valid_filter_7_7 ? hash_out_7_7 : 0;
    din_7_7.last <= out_new_pkt;
    din_7_7.bucket <= 7;


    din_7_7_r1 <= din_7_7;
    din_7_7_r2 <= din_7_7_r1;
    din_valid_7_8 <= out_new_pkt | hash_out_valid_filter_7_8;
    din_valid_7_8_r1 <= din_valid_7_8;
    din_valid_7_8_r2 <= din_valid_7_8_r1;

    din_7_8.data <= hash_out_valid_filter_7_8 ? hash_out_7_8 : 0;
    din_7_8.last <= out_new_pkt;
    din_7_8.bucket <= 7;


    din_7_8_r1 <= din_7_8;
    din_7_8_r2 <= din_7_8_r1;
    din_valid_7_9 <= out_new_pkt | hash_out_valid_filter_7_9;
    din_valid_7_9_r1 <= din_valid_7_9;
    din_valid_7_9_r2 <= din_valid_7_9_r1;

    din_7_9.data <= hash_out_valid_filter_7_9 ? hash_out_7_9 : 0;
    din_7_9.last <= out_new_pkt;
    din_7_9.bucket <= 7;


    din_7_9_r1 <= din_7_9;
    din_7_9_r2 <= din_7_9_r1;
    din_valid_7_10 <= out_new_pkt | hash_out_valid_filter_7_10;
    din_valid_7_10_r1 <= din_valid_7_10;
    din_valid_7_10_r2 <= din_valid_7_10_r1;

    din_7_10.data <= hash_out_valid_filter_7_10 ? hash_out_7_10 : 0;
    din_7_10.last <= out_new_pkt;
    din_7_10.bucket <= 7;


    din_7_10_r1 <= din_7_10;
    din_7_10_r2 <= din_7_10_r1;
    din_valid_7_11 <= out_new_pkt | hash_out_valid_filter_7_11;
    din_valid_7_11_r1 <= din_valid_7_11;
    din_valid_7_11_r2 <= din_valid_7_11_r1;

    din_7_11.data <= hash_out_valid_filter_7_11 ? hash_out_7_11 : 0;
    din_7_11.last <= out_new_pkt;
    din_7_11.bucket <= 7;


    din_7_11_r1 <= din_7_11;
    din_7_11_r2 <= din_7_11_r1;
    din_valid_7_12 <= out_new_pkt | hash_out_valid_filter_7_12;
    din_valid_7_12_r1 <= din_valid_7_12;
    din_valid_7_12_r2 <= din_valid_7_12_r1;

    din_7_12.data <= hash_out_valid_filter_7_12 ? hash_out_7_12 : 0;
    din_7_12.last <= out_new_pkt;
    din_7_12.bucket <= 7;


    din_7_12_r1 <= din_7_12;
    din_7_12_r2 <= din_7_12_r1;
    din_valid_7_13 <= out_new_pkt | hash_out_valid_filter_7_13;
    din_valid_7_13_r1 <= din_valid_7_13;
    din_valid_7_13_r2 <= din_valid_7_13_r1;

    din_7_13.data <= hash_out_valid_filter_7_13 ? hash_out_7_13 : 0;
    din_7_13.last <= out_new_pkt;
    din_7_13.bucket <= 7;


    din_7_13_r1 <= din_7_13;
    din_7_13_r2 <= din_7_13_r1;
    din_valid_7_14 <= out_new_pkt | hash_out_valid_filter_7_14;
    din_valid_7_14_r1 <= din_valid_7_14;
    din_valid_7_14_r2 <= din_valid_7_14_r1;

    din_7_14.data <= hash_out_valid_filter_7_14 ? hash_out_7_14 : 0;
    din_7_14.last <= out_new_pkt;
    din_7_14.bucket <= 7;


    din_7_14_r1 <= din_7_14;
    din_7_14_r2 <= din_7_14_r1;
    din_valid_7_15 <= out_new_pkt | hash_out_valid_filter_7_15;
    din_valid_7_15_r1 <= din_valid_7_15;
    din_valid_7_15_r2 <= din_valid_7_15_r1;

    din_7_15.data <= hash_out_valid_filter_7_15 ? hash_out_7_15 : 0;
    din_7_15.last <= out_new_pkt;
    din_7_15.bucket <= 7;


    din_7_15_r1 <= din_7_15;
    din_7_15_r2 <= din_7_15_r1;
end

//Instantiation
pkt_almost_full #(
    .DWIDTH(FP_DWIDTH),
    .EWIDTH(FP_EWIDTH),
    .NUM_PIPES(2)
) pkt_almost_full_inst (
    .clk                    (clk),
    .rst                    (rst),
    .in_data                (in_pkt_data),
    .in_valid               (in_pkt_valid),
    .in_ready               (in_pkt_ready),
    .in_sop                 (in_pkt_sop),
    .in_eop                 (in_pkt_eop),
    .in_empty               (in_pkt_empty),
    .out_data               (piped_pkt_data),
    .out_valid              (piped_pkt_valid),
    //.out_ready              (piped_pkt_ready),
    .out_almost_full        (piped_pkt_almost_full),
    .out_sop                (piped_pkt_sop),
    .out_eop                (piped_pkt_eop),
    .out_empty              (piped_pkt_empty)
);


frontend front(
    .clk(clk),
    .rst(rst),
    .hash_out_0_0 (hash_out_0_0),
    .hash_out_valid_filter_0_0(hash_out_valid_filter_0_0),
    .hash_out_0_1 (hash_out_0_1),
    .hash_out_valid_filter_0_1(hash_out_valid_filter_0_1),
    .hash_out_0_2 (hash_out_0_2),
    .hash_out_valid_filter_0_2(hash_out_valid_filter_0_2),
    .hash_out_0_3 (hash_out_0_3),
    .hash_out_valid_filter_0_3(hash_out_valid_filter_0_3),
    .hash_out_0_4 (hash_out_0_4),
    .hash_out_valid_filter_0_4(hash_out_valid_filter_0_4),
    .hash_out_0_5 (hash_out_0_5),
    .hash_out_valid_filter_0_5(hash_out_valid_filter_0_5),
    .hash_out_0_6 (hash_out_0_6),
    .hash_out_valid_filter_0_6(hash_out_valid_filter_0_6),
    .hash_out_0_7 (hash_out_0_7),
    .hash_out_valid_filter_0_7(hash_out_valid_filter_0_7),
    .hash_out_0_8 (hash_out_0_8),
    .hash_out_valid_filter_0_8(hash_out_valid_filter_0_8),
    .hash_out_0_9 (hash_out_0_9),
    .hash_out_valid_filter_0_9(hash_out_valid_filter_0_9),
    .hash_out_0_10 (hash_out_0_10),
    .hash_out_valid_filter_0_10(hash_out_valid_filter_0_10),
    .hash_out_0_11 (hash_out_0_11),
    .hash_out_valid_filter_0_11(hash_out_valid_filter_0_11),
    .hash_out_0_12 (hash_out_0_12),
    .hash_out_valid_filter_0_12(hash_out_valid_filter_0_12),
    .hash_out_0_13 (hash_out_0_13),
    .hash_out_valid_filter_0_13(hash_out_valid_filter_0_13),
    .hash_out_0_14 (hash_out_0_14),
    .hash_out_valid_filter_0_14(hash_out_valid_filter_0_14),
    .hash_out_0_15 (hash_out_0_15),
    .hash_out_valid_filter_0_15(hash_out_valid_filter_0_15),
    .hash_out_1_0 (hash_out_1_0),
    .hash_out_valid_filter_1_0(hash_out_valid_filter_1_0),
    .hash_out_1_1 (hash_out_1_1),
    .hash_out_valid_filter_1_1(hash_out_valid_filter_1_1),
    .hash_out_1_2 (hash_out_1_2),
    .hash_out_valid_filter_1_2(hash_out_valid_filter_1_2),
    .hash_out_1_3 (hash_out_1_3),
    .hash_out_valid_filter_1_3(hash_out_valid_filter_1_3),
    .hash_out_1_4 (hash_out_1_4),
    .hash_out_valid_filter_1_4(hash_out_valid_filter_1_4),
    .hash_out_1_5 (hash_out_1_5),
    .hash_out_valid_filter_1_5(hash_out_valid_filter_1_5),
    .hash_out_1_6 (hash_out_1_6),
    .hash_out_valid_filter_1_6(hash_out_valid_filter_1_6),
    .hash_out_1_7 (hash_out_1_7),
    .hash_out_valid_filter_1_7(hash_out_valid_filter_1_7),
    .hash_out_1_8 (hash_out_1_8),
    .hash_out_valid_filter_1_8(hash_out_valid_filter_1_8),
    .hash_out_1_9 (hash_out_1_9),
    .hash_out_valid_filter_1_9(hash_out_valid_filter_1_9),
    .hash_out_1_10 (hash_out_1_10),
    .hash_out_valid_filter_1_10(hash_out_valid_filter_1_10),
    .hash_out_1_11 (hash_out_1_11),
    .hash_out_valid_filter_1_11(hash_out_valid_filter_1_11),
    .hash_out_1_12 (hash_out_1_12),
    .hash_out_valid_filter_1_12(hash_out_valid_filter_1_12),
    .hash_out_1_13 (hash_out_1_13),
    .hash_out_valid_filter_1_13(hash_out_valid_filter_1_13),
    .hash_out_1_14 (hash_out_1_14),
    .hash_out_valid_filter_1_14(hash_out_valid_filter_1_14),
    .hash_out_1_15 (hash_out_1_15),
    .hash_out_valid_filter_1_15(hash_out_valid_filter_1_15),
    .hash_out_2_0 (hash_out_2_0),
    .hash_out_valid_filter_2_0(hash_out_valid_filter_2_0),
    .hash_out_2_1 (hash_out_2_1),
    .hash_out_valid_filter_2_1(hash_out_valid_filter_2_1),
    .hash_out_2_2 (hash_out_2_2),
    .hash_out_valid_filter_2_2(hash_out_valid_filter_2_2),
    .hash_out_2_3 (hash_out_2_3),
    .hash_out_valid_filter_2_3(hash_out_valid_filter_2_3),
    .hash_out_2_4 (hash_out_2_4),
    .hash_out_valid_filter_2_4(hash_out_valid_filter_2_4),
    .hash_out_2_5 (hash_out_2_5),
    .hash_out_valid_filter_2_5(hash_out_valid_filter_2_5),
    .hash_out_2_6 (hash_out_2_6),
    .hash_out_valid_filter_2_6(hash_out_valid_filter_2_6),
    .hash_out_2_7 (hash_out_2_7),
    .hash_out_valid_filter_2_7(hash_out_valid_filter_2_7),
    .hash_out_2_8 (hash_out_2_8),
    .hash_out_valid_filter_2_8(hash_out_valid_filter_2_8),
    .hash_out_2_9 (hash_out_2_9),
    .hash_out_valid_filter_2_9(hash_out_valid_filter_2_9),
    .hash_out_2_10 (hash_out_2_10),
    .hash_out_valid_filter_2_10(hash_out_valid_filter_2_10),
    .hash_out_2_11 (hash_out_2_11),
    .hash_out_valid_filter_2_11(hash_out_valid_filter_2_11),
    .hash_out_2_12 (hash_out_2_12),
    .hash_out_valid_filter_2_12(hash_out_valid_filter_2_12),
    .hash_out_2_13 (hash_out_2_13),
    .hash_out_valid_filter_2_13(hash_out_valid_filter_2_13),
    .hash_out_2_14 (hash_out_2_14),
    .hash_out_valid_filter_2_14(hash_out_valid_filter_2_14),
    .hash_out_2_15 (hash_out_2_15),
    .hash_out_valid_filter_2_15(hash_out_valid_filter_2_15),
    .hash_out_3_0 (hash_out_3_0),
    .hash_out_valid_filter_3_0(hash_out_valid_filter_3_0),
    .hash_out_3_1 (hash_out_3_1),
    .hash_out_valid_filter_3_1(hash_out_valid_filter_3_1),
    .hash_out_3_2 (hash_out_3_2),
    .hash_out_valid_filter_3_2(hash_out_valid_filter_3_2),
    .hash_out_3_3 (hash_out_3_3),
    .hash_out_valid_filter_3_3(hash_out_valid_filter_3_3),
    .hash_out_3_4 (hash_out_3_4),
    .hash_out_valid_filter_3_4(hash_out_valid_filter_3_4),
    .hash_out_3_5 (hash_out_3_5),
    .hash_out_valid_filter_3_5(hash_out_valid_filter_3_5),
    .hash_out_3_6 (hash_out_3_6),
    .hash_out_valid_filter_3_6(hash_out_valid_filter_3_6),
    .hash_out_3_7 (hash_out_3_7),
    .hash_out_valid_filter_3_7(hash_out_valid_filter_3_7),
    .hash_out_3_8 (hash_out_3_8),
    .hash_out_valid_filter_3_8(hash_out_valid_filter_3_8),
    .hash_out_3_9 (hash_out_3_9),
    .hash_out_valid_filter_3_9(hash_out_valid_filter_3_9),
    .hash_out_3_10 (hash_out_3_10),
    .hash_out_valid_filter_3_10(hash_out_valid_filter_3_10),
    .hash_out_3_11 (hash_out_3_11),
    .hash_out_valid_filter_3_11(hash_out_valid_filter_3_11),
    .hash_out_3_12 (hash_out_3_12),
    .hash_out_valid_filter_3_12(hash_out_valid_filter_3_12),
    .hash_out_3_13 (hash_out_3_13),
    .hash_out_valid_filter_3_13(hash_out_valid_filter_3_13),
    .hash_out_3_14 (hash_out_3_14),
    .hash_out_valid_filter_3_14(hash_out_valid_filter_3_14),
    .hash_out_3_15 (hash_out_3_15),
    .hash_out_valid_filter_3_15(hash_out_valid_filter_3_15),
    .hash_out_4_0 (hash_out_4_0),
    .hash_out_valid_filter_4_0(hash_out_valid_filter_4_0),
    .hash_out_4_1 (hash_out_4_1),
    .hash_out_valid_filter_4_1(hash_out_valid_filter_4_1),
    .hash_out_4_2 (hash_out_4_2),
    .hash_out_valid_filter_4_2(hash_out_valid_filter_4_2),
    .hash_out_4_3 (hash_out_4_3),
    .hash_out_valid_filter_4_3(hash_out_valid_filter_4_3),
    .hash_out_4_4 (hash_out_4_4),
    .hash_out_valid_filter_4_4(hash_out_valid_filter_4_4),
    .hash_out_4_5 (hash_out_4_5),
    .hash_out_valid_filter_4_5(hash_out_valid_filter_4_5),
    .hash_out_4_6 (hash_out_4_6),
    .hash_out_valid_filter_4_6(hash_out_valid_filter_4_6),
    .hash_out_4_7 (hash_out_4_7),
    .hash_out_valid_filter_4_7(hash_out_valid_filter_4_7),
    .hash_out_4_8 (hash_out_4_8),
    .hash_out_valid_filter_4_8(hash_out_valid_filter_4_8),
    .hash_out_4_9 (hash_out_4_9),
    .hash_out_valid_filter_4_9(hash_out_valid_filter_4_9),
    .hash_out_4_10 (hash_out_4_10),
    .hash_out_valid_filter_4_10(hash_out_valid_filter_4_10),
    .hash_out_4_11 (hash_out_4_11),
    .hash_out_valid_filter_4_11(hash_out_valid_filter_4_11),
    .hash_out_4_12 (hash_out_4_12),
    .hash_out_valid_filter_4_12(hash_out_valid_filter_4_12),
    .hash_out_4_13 (hash_out_4_13),
    .hash_out_valid_filter_4_13(hash_out_valid_filter_4_13),
    .hash_out_4_14 (hash_out_4_14),
    .hash_out_valid_filter_4_14(hash_out_valid_filter_4_14),
    .hash_out_4_15 (hash_out_4_15),
    .hash_out_valid_filter_4_15(hash_out_valid_filter_4_15),
    .hash_out_5_0 (hash_out_5_0),
    .hash_out_valid_filter_5_0(hash_out_valid_filter_5_0),
    .hash_out_5_1 (hash_out_5_1),
    .hash_out_valid_filter_5_1(hash_out_valid_filter_5_1),
    .hash_out_5_2 (hash_out_5_2),
    .hash_out_valid_filter_5_2(hash_out_valid_filter_5_2),
    .hash_out_5_3 (hash_out_5_3),
    .hash_out_valid_filter_5_3(hash_out_valid_filter_5_3),
    .hash_out_5_4 (hash_out_5_4),
    .hash_out_valid_filter_5_4(hash_out_valid_filter_5_4),
    .hash_out_5_5 (hash_out_5_5),
    .hash_out_valid_filter_5_5(hash_out_valid_filter_5_5),
    .hash_out_5_6 (hash_out_5_6),
    .hash_out_valid_filter_5_6(hash_out_valid_filter_5_6),
    .hash_out_5_7 (hash_out_5_7),
    .hash_out_valid_filter_5_7(hash_out_valid_filter_5_7),
    .hash_out_5_8 (hash_out_5_8),
    .hash_out_valid_filter_5_8(hash_out_valid_filter_5_8),
    .hash_out_5_9 (hash_out_5_9),
    .hash_out_valid_filter_5_9(hash_out_valid_filter_5_9),
    .hash_out_5_10 (hash_out_5_10),
    .hash_out_valid_filter_5_10(hash_out_valid_filter_5_10),
    .hash_out_5_11 (hash_out_5_11),
    .hash_out_valid_filter_5_11(hash_out_valid_filter_5_11),
    .hash_out_5_12 (hash_out_5_12),
    .hash_out_valid_filter_5_12(hash_out_valid_filter_5_12),
    .hash_out_5_13 (hash_out_5_13),
    .hash_out_valid_filter_5_13(hash_out_valid_filter_5_13),
    .hash_out_5_14 (hash_out_5_14),
    .hash_out_valid_filter_5_14(hash_out_valid_filter_5_14),
    .hash_out_5_15 (hash_out_5_15),
    .hash_out_valid_filter_5_15(hash_out_valid_filter_5_15),
    .hash_out_6_0 (hash_out_6_0),
    .hash_out_valid_filter_6_0(hash_out_valid_filter_6_0),
    .hash_out_6_1 (hash_out_6_1),
    .hash_out_valid_filter_6_1(hash_out_valid_filter_6_1),
    .hash_out_6_2 (hash_out_6_2),
    .hash_out_valid_filter_6_2(hash_out_valid_filter_6_2),
    .hash_out_6_3 (hash_out_6_3),
    .hash_out_valid_filter_6_3(hash_out_valid_filter_6_3),
    .hash_out_6_4 (hash_out_6_4),
    .hash_out_valid_filter_6_4(hash_out_valid_filter_6_4),
    .hash_out_6_5 (hash_out_6_5),
    .hash_out_valid_filter_6_5(hash_out_valid_filter_6_5),
    .hash_out_6_6 (hash_out_6_6),
    .hash_out_valid_filter_6_6(hash_out_valid_filter_6_6),
    .hash_out_6_7 (hash_out_6_7),
    .hash_out_valid_filter_6_7(hash_out_valid_filter_6_7),
    .hash_out_6_8 (hash_out_6_8),
    .hash_out_valid_filter_6_8(hash_out_valid_filter_6_8),
    .hash_out_6_9 (hash_out_6_9),
    .hash_out_valid_filter_6_9(hash_out_valid_filter_6_9),
    .hash_out_6_10 (hash_out_6_10),
    .hash_out_valid_filter_6_10(hash_out_valid_filter_6_10),
    .hash_out_6_11 (hash_out_6_11),
    .hash_out_valid_filter_6_11(hash_out_valid_filter_6_11),
    .hash_out_6_12 (hash_out_6_12),
    .hash_out_valid_filter_6_12(hash_out_valid_filter_6_12),
    .hash_out_6_13 (hash_out_6_13),
    .hash_out_valid_filter_6_13(hash_out_valid_filter_6_13),
    .hash_out_6_14 (hash_out_6_14),
    .hash_out_valid_filter_6_14(hash_out_valid_filter_6_14),
    .hash_out_6_15 (hash_out_6_15),
    .hash_out_valid_filter_6_15(hash_out_valid_filter_6_15),
    .hash_out_7_0 (hash_out_7_0),
    .hash_out_valid_filter_7_0(hash_out_valid_filter_7_0),
    .hash_out_7_1 (hash_out_7_1),
    .hash_out_valid_filter_7_1(hash_out_valid_filter_7_1),
    .hash_out_7_2 (hash_out_7_2),
    .hash_out_valid_filter_7_2(hash_out_valid_filter_7_2),
    .hash_out_7_3 (hash_out_7_3),
    .hash_out_valid_filter_7_3(hash_out_valid_filter_7_3),
    .hash_out_7_4 (hash_out_7_4),
    .hash_out_valid_filter_7_4(hash_out_valid_filter_7_4),
    .hash_out_7_5 (hash_out_7_5),
    .hash_out_valid_filter_7_5(hash_out_valid_filter_7_5),
    .hash_out_7_6 (hash_out_7_6),
    .hash_out_valid_filter_7_6(hash_out_valid_filter_7_6),
    .hash_out_7_7 (hash_out_7_7),
    .hash_out_valid_filter_7_7(hash_out_valid_filter_7_7),
    .hash_out_7_8 (hash_out_7_8),
    .hash_out_valid_filter_7_8(hash_out_valid_filter_7_8),
    .hash_out_7_9 (hash_out_7_9),
    .hash_out_valid_filter_7_9(hash_out_valid_filter_7_9),
    .hash_out_7_10 (hash_out_7_10),
    .hash_out_valid_filter_7_10(hash_out_valid_filter_7_10),
    .hash_out_7_11 (hash_out_7_11),
    .hash_out_valid_filter_7_11(hash_out_valid_filter_7_11),
    .hash_out_7_12 (hash_out_7_12),
    .hash_out_valid_filter_7_12(hash_out_valid_filter_7_12),
    .hash_out_7_13 (hash_out_7_13),
    .hash_out_valid_filter_7_13(hash_out_valid_filter_7_13),
    .hash_out_7_14 (hash_out_7_14),
    .hash_out_valid_filter_7_14(hash_out_valid_filter_7_14),
    .hash_out_7_15 (hash_out_7_15),
    .hash_out_valid_filter_7_15(hash_out_valid_filter_7_15),
    .in_data         (piped_pkt_data_swap),
    .in_valid        (piped_pkt_valid),
    .in_sop          (piped_pkt_sop),
    .in_eop          (piped_pkt_eop),
    .in_empty        (piped_pkt_empty),
    .out_new_pkt     (out_new_pkt)
);
//RuleID reduction logic
backend back(
    .clk                     (clk),
    .rst                     (rst),
    .in_data_0_0     (back_data_0_0),
    .in_valid_0_0    (back_valid_0_0),
    .in_ready_0_0    (back_ready_0_0),
    .in_data_0_1     (back_data_0_1),
    .in_valid_0_1    (back_valid_0_1),
    .in_ready_0_1    (back_ready_0_1),
    .in_data_0_2     (back_data_0_2),
    .in_valid_0_2    (back_valid_0_2),
    .in_ready_0_2    (back_ready_0_2),
    .in_data_0_3     (back_data_0_3),
    .in_valid_0_3    (back_valid_0_3),
    .in_ready_0_3    (back_ready_0_3),
    .in_data_0_4     (back_data_0_4),
    .in_valid_0_4    (back_valid_0_4),
    .in_ready_0_4    (back_ready_0_4),
    .in_data_0_5     (back_data_0_5),
    .in_valid_0_5    (back_valid_0_5),
    .in_ready_0_5    (back_ready_0_5),
    .in_data_0_6     (back_data_0_6),
    .in_valid_0_6    (back_valid_0_6),
    .in_ready_0_6    (back_ready_0_6),
    .in_data_0_7     (back_data_0_7),
    .in_valid_0_7    (back_valid_0_7),
    .in_ready_0_7    (back_ready_0_7),
    .in_data_0_8     (back_data_0_8),
    .in_valid_0_8    (back_valid_0_8),
    .in_ready_0_8    (back_ready_0_8),
    .in_data_0_9     (back_data_0_9),
    .in_valid_0_9    (back_valid_0_9),
    .in_ready_0_9    (back_ready_0_9),
    .in_data_0_10     (back_data_0_10),
    .in_valid_0_10    (back_valid_0_10),
    .in_ready_0_10    (back_ready_0_10),
    .in_data_0_11     (back_data_0_11),
    .in_valid_0_11    (back_valid_0_11),
    .in_ready_0_11    (back_ready_0_11),
    .in_data_0_12     (back_data_0_12),
    .in_valid_0_12    (back_valid_0_12),
    .in_ready_0_12    (back_ready_0_12),
    .in_data_0_13     (back_data_0_13),
    .in_valid_0_13    (back_valid_0_13),
    .in_ready_0_13    (back_ready_0_13),
    .in_data_0_14     (back_data_0_14),
    .in_valid_0_14    (back_valid_0_14),
    .in_ready_0_14    (back_ready_0_14),
    .in_data_0_15     (back_data_0_15),
    .in_valid_0_15    (back_valid_0_15),
    .in_ready_0_15    (back_ready_0_15),
    .in_data_1_0     (back_data_1_0),
    .in_valid_1_0    (back_valid_1_0),
    .in_ready_1_0    (back_ready_1_0),
    .in_data_1_1     (back_data_1_1),
    .in_valid_1_1    (back_valid_1_1),
    .in_ready_1_1    (back_ready_1_1),
    .in_data_1_2     (back_data_1_2),
    .in_valid_1_2    (back_valid_1_2),
    .in_ready_1_2    (back_ready_1_2),
    .in_data_1_3     (back_data_1_3),
    .in_valid_1_3    (back_valid_1_3),
    .in_ready_1_3    (back_ready_1_3),
    .in_data_1_4     (back_data_1_4),
    .in_valid_1_4    (back_valid_1_4),
    .in_ready_1_4    (back_ready_1_4),
    .in_data_1_5     (back_data_1_5),
    .in_valid_1_5    (back_valid_1_5),
    .in_ready_1_5    (back_ready_1_5),
    .in_data_1_6     (back_data_1_6),
    .in_valid_1_6    (back_valid_1_6),
    .in_ready_1_6    (back_ready_1_6),
    .in_data_1_7     (back_data_1_7),
    .in_valid_1_7    (back_valid_1_7),
    .in_ready_1_7    (back_ready_1_7),
    .in_data_1_8     (back_data_1_8),
    .in_valid_1_8    (back_valid_1_8),
    .in_ready_1_8    (back_ready_1_8),
    .in_data_1_9     (back_data_1_9),
    .in_valid_1_9    (back_valid_1_9),
    .in_ready_1_9    (back_ready_1_9),
    .in_data_1_10     (back_data_1_10),
    .in_valid_1_10    (back_valid_1_10),
    .in_ready_1_10    (back_ready_1_10),
    .in_data_1_11     (back_data_1_11),
    .in_valid_1_11    (back_valid_1_11),
    .in_ready_1_11    (back_ready_1_11),
    .in_data_1_12     (back_data_1_12),
    .in_valid_1_12    (back_valid_1_12),
    .in_ready_1_12    (back_ready_1_12),
    .in_data_1_13     (back_data_1_13),
    .in_valid_1_13    (back_valid_1_13),
    .in_ready_1_13    (back_ready_1_13),
    .in_data_1_14     (back_data_1_14),
    .in_valid_1_14    (back_valid_1_14),
    .in_ready_1_14    (back_ready_1_14),
    .in_data_1_15     (back_data_1_15),
    .in_valid_1_15    (back_valid_1_15),
    .in_ready_1_15    (back_ready_1_15),
    .in_data_2_0     (back_data_2_0),
    .in_valid_2_0    (back_valid_2_0),
    .in_ready_2_0    (back_ready_2_0),
    .in_data_2_1     (back_data_2_1),
    .in_valid_2_1    (back_valid_2_1),
    .in_ready_2_1    (back_ready_2_1),
    .in_data_2_2     (back_data_2_2),
    .in_valid_2_2    (back_valid_2_2),
    .in_ready_2_2    (back_ready_2_2),
    .in_data_2_3     (back_data_2_3),
    .in_valid_2_3    (back_valid_2_3),
    .in_ready_2_3    (back_ready_2_3),
    .in_data_2_4     (back_data_2_4),
    .in_valid_2_4    (back_valid_2_4),
    .in_ready_2_4    (back_ready_2_4),
    .in_data_2_5     (back_data_2_5),
    .in_valid_2_5    (back_valid_2_5),
    .in_ready_2_5    (back_ready_2_5),
    .in_data_2_6     (back_data_2_6),
    .in_valid_2_6    (back_valid_2_6),
    .in_ready_2_6    (back_ready_2_6),
    .in_data_2_7     (back_data_2_7),
    .in_valid_2_7    (back_valid_2_7),
    .in_ready_2_7    (back_ready_2_7),
    .in_data_2_8     (back_data_2_8),
    .in_valid_2_8    (back_valid_2_8),
    .in_ready_2_8    (back_ready_2_8),
    .in_data_2_9     (back_data_2_9),
    .in_valid_2_9    (back_valid_2_9),
    .in_ready_2_9    (back_ready_2_9),
    .in_data_2_10     (back_data_2_10),
    .in_valid_2_10    (back_valid_2_10),
    .in_ready_2_10    (back_ready_2_10),
    .in_data_2_11     (back_data_2_11),
    .in_valid_2_11    (back_valid_2_11),
    .in_ready_2_11    (back_ready_2_11),
    .in_data_2_12     (back_data_2_12),
    .in_valid_2_12    (back_valid_2_12),
    .in_ready_2_12    (back_ready_2_12),
    .in_data_2_13     (back_data_2_13),
    .in_valid_2_13    (back_valid_2_13),
    .in_ready_2_13    (back_ready_2_13),
    .in_data_2_14     (back_data_2_14),
    .in_valid_2_14    (back_valid_2_14),
    .in_ready_2_14    (back_ready_2_14),
    .in_data_2_15     (back_data_2_15),
    .in_valid_2_15    (back_valid_2_15),
    .in_ready_2_15    (back_ready_2_15),
    .in_data_3_0     (back_data_3_0),
    .in_valid_3_0    (back_valid_3_0),
    .in_ready_3_0    (back_ready_3_0),
    .in_data_3_1     (back_data_3_1),
    .in_valid_3_1    (back_valid_3_1),
    .in_ready_3_1    (back_ready_3_1),
    .in_data_3_2     (back_data_3_2),
    .in_valid_3_2    (back_valid_3_2),
    .in_ready_3_2    (back_ready_3_2),
    .in_data_3_3     (back_data_3_3),
    .in_valid_3_3    (back_valid_3_3),
    .in_ready_3_3    (back_ready_3_3),
    .in_data_3_4     (back_data_3_4),
    .in_valid_3_4    (back_valid_3_4),
    .in_ready_3_4    (back_ready_3_4),
    .in_data_3_5     (back_data_3_5),
    .in_valid_3_5    (back_valid_3_5),
    .in_ready_3_5    (back_ready_3_5),
    .in_data_3_6     (back_data_3_6),
    .in_valid_3_6    (back_valid_3_6),
    .in_ready_3_6    (back_ready_3_6),
    .in_data_3_7     (back_data_3_7),
    .in_valid_3_7    (back_valid_3_7),
    .in_ready_3_7    (back_ready_3_7),
    .in_data_3_8     (back_data_3_8),
    .in_valid_3_8    (back_valid_3_8),
    .in_ready_3_8    (back_ready_3_8),
    .in_data_3_9     (back_data_3_9),
    .in_valid_3_9    (back_valid_3_9),
    .in_ready_3_9    (back_ready_3_9),
    .in_data_3_10     (back_data_3_10),
    .in_valid_3_10    (back_valid_3_10),
    .in_ready_3_10    (back_ready_3_10),
    .in_data_3_11     (back_data_3_11),
    .in_valid_3_11    (back_valid_3_11),
    .in_ready_3_11    (back_ready_3_11),
    .in_data_3_12     (back_data_3_12),
    .in_valid_3_12    (back_valid_3_12),
    .in_ready_3_12    (back_ready_3_12),
    .in_data_3_13     (back_data_3_13),
    .in_valid_3_13    (back_valid_3_13),
    .in_ready_3_13    (back_ready_3_13),
    .in_data_3_14     (back_data_3_14),
    .in_valid_3_14    (back_valid_3_14),
    .in_ready_3_14    (back_ready_3_14),
    .in_data_3_15     (back_data_3_15),
    .in_valid_3_15    (back_valid_3_15),
    .in_ready_3_15    (back_ready_3_15),
    .in_data_4_0     (back_data_4_0),
    .in_valid_4_0    (back_valid_4_0),
    .in_ready_4_0    (back_ready_4_0),
    .in_data_4_1     (back_data_4_1),
    .in_valid_4_1    (back_valid_4_1),
    .in_ready_4_1    (back_ready_4_1),
    .in_data_4_2     (back_data_4_2),
    .in_valid_4_2    (back_valid_4_2),
    .in_ready_4_2    (back_ready_4_2),
    .in_data_4_3     (back_data_4_3),
    .in_valid_4_3    (back_valid_4_3),
    .in_ready_4_3    (back_ready_4_3),
    .in_data_4_4     (back_data_4_4),
    .in_valid_4_4    (back_valid_4_4),
    .in_ready_4_4    (back_ready_4_4),
    .in_data_4_5     (back_data_4_5),
    .in_valid_4_5    (back_valid_4_5),
    .in_ready_4_5    (back_ready_4_5),
    .in_data_4_6     (back_data_4_6),
    .in_valid_4_6    (back_valid_4_6),
    .in_ready_4_6    (back_ready_4_6),
    .in_data_4_7     (back_data_4_7),
    .in_valid_4_7    (back_valid_4_7),
    .in_ready_4_7    (back_ready_4_7),
    .in_data_4_8     (back_data_4_8),
    .in_valid_4_8    (back_valid_4_8),
    .in_ready_4_8    (back_ready_4_8),
    .in_data_4_9     (back_data_4_9),
    .in_valid_4_9    (back_valid_4_9),
    .in_ready_4_9    (back_ready_4_9),
    .in_data_4_10     (back_data_4_10),
    .in_valid_4_10    (back_valid_4_10),
    .in_ready_4_10    (back_ready_4_10),
    .in_data_4_11     (back_data_4_11),
    .in_valid_4_11    (back_valid_4_11),
    .in_ready_4_11    (back_ready_4_11),
    .in_data_4_12     (back_data_4_12),
    .in_valid_4_12    (back_valid_4_12),
    .in_ready_4_12    (back_ready_4_12),
    .in_data_4_13     (back_data_4_13),
    .in_valid_4_13    (back_valid_4_13),
    .in_ready_4_13    (back_ready_4_13),
    .in_data_4_14     (back_data_4_14),
    .in_valid_4_14    (back_valid_4_14),
    .in_ready_4_14    (back_ready_4_14),
    .in_data_4_15     (back_data_4_15),
    .in_valid_4_15    (back_valid_4_15),
    .in_ready_4_15    (back_ready_4_15),
    .in_data_5_0     (back_data_5_0),
    .in_valid_5_0    (back_valid_5_0),
    .in_ready_5_0    (back_ready_5_0),
    .in_data_5_1     (back_data_5_1),
    .in_valid_5_1    (back_valid_5_1),
    .in_ready_5_1    (back_ready_5_1),
    .in_data_5_2     (back_data_5_2),
    .in_valid_5_2    (back_valid_5_2),
    .in_ready_5_2    (back_ready_5_2),
    .in_data_5_3     (back_data_5_3),
    .in_valid_5_3    (back_valid_5_3),
    .in_ready_5_3    (back_ready_5_3),
    .in_data_5_4     (back_data_5_4),
    .in_valid_5_4    (back_valid_5_4),
    .in_ready_5_4    (back_ready_5_4),
    .in_data_5_5     (back_data_5_5),
    .in_valid_5_5    (back_valid_5_5),
    .in_ready_5_5    (back_ready_5_5),
    .in_data_5_6     (back_data_5_6),
    .in_valid_5_6    (back_valid_5_6),
    .in_ready_5_6    (back_ready_5_6),
    .in_data_5_7     (back_data_5_7),
    .in_valid_5_7    (back_valid_5_7),
    .in_ready_5_7    (back_ready_5_7),
    .in_data_5_8     (back_data_5_8),
    .in_valid_5_8    (back_valid_5_8),
    .in_ready_5_8    (back_ready_5_8),
    .in_data_5_9     (back_data_5_9),
    .in_valid_5_9    (back_valid_5_9),
    .in_ready_5_9    (back_ready_5_9),
    .in_data_5_10     (back_data_5_10),
    .in_valid_5_10    (back_valid_5_10),
    .in_ready_5_10    (back_ready_5_10),
    .in_data_5_11     (back_data_5_11),
    .in_valid_5_11    (back_valid_5_11),
    .in_ready_5_11    (back_ready_5_11),
    .in_data_5_12     (back_data_5_12),
    .in_valid_5_12    (back_valid_5_12),
    .in_ready_5_12    (back_ready_5_12),
    .in_data_5_13     (back_data_5_13),
    .in_valid_5_13    (back_valid_5_13),
    .in_ready_5_13    (back_ready_5_13),
    .in_data_5_14     (back_data_5_14),
    .in_valid_5_14    (back_valid_5_14),
    .in_ready_5_14    (back_ready_5_14),
    .in_data_5_15     (back_data_5_15),
    .in_valid_5_15    (back_valid_5_15),
    .in_ready_5_15    (back_ready_5_15),
    .in_data_6_0     (back_data_6_0),
    .in_valid_6_0    (back_valid_6_0),
    .in_ready_6_0    (back_ready_6_0),
    .in_data_6_1     (back_data_6_1),
    .in_valid_6_1    (back_valid_6_1),
    .in_ready_6_1    (back_ready_6_1),
    .in_data_6_2     (back_data_6_2),
    .in_valid_6_2    (back_valid_6_2),
    .in_ready_6_2    (back_ready_6_2),
    .in_data_6_3     (back_data_6_3),
    .in_valid_6_3    (back_valid_6_3),
    .in_ready_6_3    (back_ready_6_3),
    .in_data_6_4     (back_data_6_4),
    .in_valid_6_4    (back_valid_6_4),
    .in_ready_6_4    (back_ready_6_4),
    .in_data_6_5     (back_data_6_5),
    .in_valid_6_5    (back_valid_6_5),
    .in_ready_6_5    (back_ready_6_5),
    .in_data_6_6     (back_data_6_6),
    .in_valid_6_6    (back_valid_6_6),
    .in_ready_6_6    (back_ready_6_6),
    .in_data_6_7     (back_data_6_7),
    .in_valid_6_7    (back_valid_6_7),
    .in_ready_6_7    (back_ready_6_7),
    .in_data_6_8     (back_data_6_8),
    .in_valid_6_8    (back_valid_6_8),
    .in_ready_6_8    (back_ready_6_8),
    .in_data_6_9     (back_data_6_9),
    .in_valid_6_9    (back_valid_6_9),
    .in_ready_6_9    (back_ready_6_9),
    .in_data_6_10     (back_data_6_10),
    .in_valid_6_10    (back_valid_6_10),
    .in_ready_6_10    (back_ready_6_10),
    .in_data_6_11     (back_data_6_11),
    .in_valid_6_11    (back_valid_6_11),
    .in_ready_6_11    (back_ready_6_11),
    .in_data_6_12     (back_data_6_12),
    .in_valid_6_12    (back_valid_6_12),
    .in_ready_6_12    (back_ready_6_12),
    .in_data_6_13     (back_data_6_13),
    .in_valid_6_13    (back_valid_6_13),
    .in_ready_6_13    (back_ready_6_13),
    .in_data_6_14     (back_data_6_14),
    .in_valid_6_14    (back_valid_6_14),
    .in_ready_6_14    (back_ready_6_14),
    .in_data_6_15     (back_data_6_15),
    .in_valid_6_15    (back_valid_6_15),
    .in_ready_6_15    (back_ready_6_15),
    .in_data_7_0     (back_data_7_0),
    .in_valid_7_0    (back_valid_7_0),
    .in_ready_7_0    (back_ready_7_0),
    .in_data_7_1     (back_data_7_1),
    .in_valid_7_1    (back_valid_7_1),
    .in_ready_7_1    (back_ready_7_1),
    .in_data_7_2     (back_data_7_2),
    .in_valid_7_2    (back_valid_7_2),
    .in_ready_7_2    (back_ready_7_2),
    .in_data_7_3     (back_data_7_3),
    .in_valid_7_3    (back_valid_7_3),
    .in_ready_7_3    (back_ready_7_3),
    .in_data_7_4     (back_data_7_4),
    .in_valid_7_4    (back_valid_7_4),
    .in_ready_7_4    (back_ready_7_4),
    .in_data_7_5     (back_data_7_5),
    .in_valid_7_5    (back_valid_7_5),
    .in_ready_7_5    (back_ready_7_5),
    .in_data_7_6     (back_data_7_6),
    .in_valid_7_6    (back_valid_7_6),
    .in_ready_7_6    (back_ready_7_6),
    .in_data_7_7     (back_data_7_7),
    .in_valid_7_7    (back_valid_7_7),
    .in_ready_7_7    (back_ready_7_7),
    .in_data_7_8     (back_data_7_8),
    .in_valid_7_8    (back_valid_7_8),
    .in_ready_7_8    (back_ready_7_8),
    .in_data_7_9     (back_data_7_9),
    .in_valid_7_9    (back_valid_7_9),
    .in_ready_7_9    (back_ready_7_9),
    .in_data_7_10     (back_data_7_10),
    .in_valid_7_10    (back_valid_7_10),
    .in_ready_7_10    (back_ready_7_10),
    .in_data_7_11     (back_data_7_11),
    .in_valid_7_11    (back_valid_7_11),
    .in_ready_7_11    (back_ready_7_11),
    .in_data_7_12     (back_data_7_12),
    .in_valid_7_12    (back_valid_7_12),
    .in_ready_7_12    (back_ready_7_12),
    .in_data_7_13     (back_data_7_13),
    .in_valid_7_13    (back_valid_7_13),
    .in_ready_7_13    (back_ready_7_13),
    .in_data_7_14     (back_data_7_14),
    .in_valid_7_14    (back_valid_7_14),
    .in_ready_7_14    (back_ready_7_14),
    .in_data_7_15     (back_data_7_15),
    .in_valid_7_15    (back_valid_7_15),
    .in_ready_7_15    (back_ready_7_15),
    .out_usr_data            (out_usr_data),
    .out_usr_valid           (out_usr_valid),
    .out_usr_sop             (out_usr_sop),
    .out_usr_eop             (out_usr_eop),
    .out_usr_empty           (out_usr_empty),
    .out_usr_ready           (out_usr_ready)
);


//Cross clock domain
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_0"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_0 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_0_r2),              
    .in_valid          (din_valid_0_0_r2),             
    .in_ready          (din_ready_0_0),             
    .out_data          (back_data_0_0),              
    .out_valid         (back_valid_0_0),             
    .out_ready         (back_ready_0_0),             
    .fill_level        (din_csr_readdata_0_0),
    .almost_full       (din_almost_full_0_0),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_1"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_1 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_1_r2),              
    .in_valid          (din_valid_0_1_r2),             
    .in_ready          (din_ready_0_1),             
    .out_data          (back_data_0_1),              
    .out_valid         (back_valid_0_1),             
    .out_ready         (back_ready_0_1),             
    .fill_level        (din_csr_readdata_0_1),
    .almost_full       (din_almost_full_0_1),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_2"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_2 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_2_r2),              
    .in_valid          (din_valid_0_2_r2),             
    .in_ready          (din_ready_0_2),             
    .out_data          (back_data_0_2),              
    .out_valid         (back_valid_0_2),             
    .out_ready         (back_ready_0_2),             
    .fill_level        (din_csr_readdata_0_2),
    .almost_full       (din_almost_full_0_2),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_3"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_3 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_3_r2),              
    .in_valid          (din_valid_0_3_r2),             
    .in_ready          (din_ready_0_3),             
    .out_data          (back_data_0_3),              
    .out_valid         (back_valid_0_3),             
    .out_ready         (back_ready_0_3),             
    .fill_level        (din_csr_readdata_0_3),
    .almost_full       (din_almost_full_0_3),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_4"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_4 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_4_r2),              
    .in_valid          (din_valid_0_4_r2),             
    .in_ready          (din_ready_0_4),             
    .out_data          (back_data_0_4),              
    .out_valid         (back_valid_0_4),             
    .out_ready         (back_ready_0_4),             
    .fill_level        (din_csr_readdata_0_4),
    .almost_full       (din_almost_full_0_4),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_5"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_5 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_5_r2),              
    .in_valid          (din_valid_0_5_r2),             
    .in_ready          (din_ready_0_5),             
    .out_data          (back_data_0_5),              
    .out_valid         (back_valid_0_5),             
    .out_ready         (back_ready_0_5),             
    .fill_level        (din_csr_readdata_0_5),
    .almost_full       (din_almost_full_0_5),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_6"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_6 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_6_r2),              
    .in_valid          (din_valid_0_6_r2),             
    .in_ready          (din_ready_0_6),             
    .out_data          (back_data_0_6),              
    .out_valid         (back_valid_0_6),             
    .out_ready         (back_ready_0_6),             
    .fill_level        (din_csr_readdata_0_6),
    .almost_full       (din_almost_full_0_6),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_7"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_7 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_7_r2),              
    .in_valid          (din_valid_0_7_r2),             
    .in_ready          (din_ready_0_7),             
    .out_data          (back_data_0_7),              
    .out_valid         (back_valid_0_7),             
    .out_ready         (back_ready_0_7),             
    .fill_level        (din_csr_readdata_0_7),
    .almost_full       (din_almost_full_0_7),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_8"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_8 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_8_r2),              
    .in_valid          (din_valid_0_8_r2),             
    .in_ready          (din_ready_0_8),             
    .out_data          (back_data_0_8),              
    .out_valid         (back_valid_0_8),             
    .out_ready         (back_ready_0_8),             
    .fill_level        (din_csr_readdata_0_8),
    .almost_full       (din_almost_full_0_8),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_9"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_9 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_9_r2),              
    .in_valid          (din_valid_0_9_r2),             
    .in_ready          (din_ready_0_9),             
    .out_data          (back_data_0_9),              
    .out_valid         (back_valid_0_9),             
    .out_ready         (back_ready_0_9),             
    .fill_level        (din_csr_readdata_0_9),
    .almost_full       (din_almost_full_0_9),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_10"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_10 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_10_r2),              
    .in_valid          (din_valid_0_10_r2),             
    .in_ready          (din_ready_0_10),             
    .out_data          (back_data_0_10),              
    .out_valid         (back_valid_0_10),             
    .out_ready         (back_ready_0_10),             
    .fill_level        (din_csr_readdata_0_10),
    .almost_full       (din_almost_full_0_10),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_11"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_11 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_11_r2),              
    .in_valid          (din_valid_0_11_r2),             
    .in_ready          (din_ready_0_11),             
    .out_data          (back_data_0_11),              
    .out_valid         (back_valid_0_11),             
    .out_ready         (back_ready_0_11),             
    .fill_level        (din_csr_readdata_0_11),
    .almost_full       (din_almost_full_0_11),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_12"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_12 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_12_r2),              
    .in_valid          (din_valid_0_12_r2),             
    .in_ready          (din_ready_0_12),             
    .out_data          (back_data_0_12),              
    .out_valid         (back_valid_0_12),             
    .out_ready         (back_ready_0_12),             
    .fill_level        (din_csr_readdata_0_12),
    .almost_full       (din_almost_full_0_12),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_13"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_13 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_13_r2),              
    .in_valid          (din_valid_0_13_r2),             
    .in_ready          (din_ready_0_13),             
    .out_data          (back_data_0_13),              
    .out_valid         (back_valid_0_13),             
    .out_ready         (back_ready_0_13),             
    .fill_level        (din_csr_readdata_0_13),
    .almost_full       (din_almost_full_0_13),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_14"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_14 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_14_r2),              
    .in_valid          (din_valid_0_14_r2),             
    .in_ready          (din_ready_0_14),             
    .out_data          (back_data_0_14),              
    .out_valid         (back_valid_0_14),             
    .out_ready         (back_ready_0_14),             
    .fill_level        (din_csr_readdata_0_14),
    .almost_full       (din_almost_full_0_14),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_0_15"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_0_15 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_0_15_r2),              
    .in_valid          (din_valid_0_15_r2),             
    .in_ready          (din_ready_0_15),             
    .out_data          (back_data_0_15),              
    .out_valid         (back_valid_0_15),             
    .out_ready         (back_ready_0_15),             
    .fill_level        (din_csr_readdata_0_15),
    .almost_full       (din_almost_full_0_15),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_0"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_0 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_0_r2),              
    .in_valid          (din_valid_1_0_r2),             
    .in_ready          (din_ready_1_0),             
    .out_data          (back_data_1_0),              
    .out_valid         (back_valid_1_0),             
    .out_ready         (back_ready_1_0),             
    .fill_level        (din_csr_readdata_1_0),
    .almost_full       (din_almost_full_1_0),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_1"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_1 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_1_r2),              
    .in_valid          (din_valid_1_1_r2),             
    .in_ready          (din_ready_1_1),             
    .out_data          (back_data_1_1),              
    .out_valid         (back_valid_1_1),             
    .out_ready         (back_ready_1_1),             
    .fill_level        (din_csr_readdata_1_1),
    .almost_full       (din_almost_full_1_1),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_2"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_2 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_2_r2),              
    .in_valid          (din_valid_1_2_r2),             
    .in_ready          (din_ready_1_2),             
    .out_data          (back_data_1_2),              
    .out_valid         (back_valid_1_2),             
    .out_ready         (back_ready_1_2),             
    .fill_level        (din_csr_readdata_1_2),
    .almost_full       (din_almost_full_1_2),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_3"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_3 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_3_r2),              
    .in_valid          (din_valid_1_3_r2),             
    .in_ready          (din_ready_1_3),             
    .out_data          (back_data_1_3),              
    .out_valid         (back_valid_1_3),             
    .out_ready         (back_ready_1_3),             
    .fill_level        (din_csr_readdata_1_3),
    .almost_full       (din_almost_full_1_3),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_4"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_4 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_4_r2),              
    .in_valid          (din_valid_1_4_r2),             
    .in_ready          (din_ready_1_4),             
    .out_data          (back_data_1_4),              
    .out_valid         (back_valid_1_4),             
    .out_ready         (back_ready_1_4),             
    .fill_level        (din_csr_readdata_1_4),
    .almost_full       (din_almost_full_1_4),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_5"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_5 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_5_r2),              
    .in_valid          (din_valid_1_5_r2),             
    .in_ready          (din_ready_1_5),             
    .out_data          (back_data_1_5),              
    .out_valid         (back_valid_1_5),             
    .out_ready         (back_ready_1_5),             
    .fill_level        (din_csr_readdata_1_5),
    .almost_full       (din_almost_full_1_5),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_6"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_6 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_6_r2),              
    .in_valid          (din_valid_1_6_r2),             
    .in_ready          (din_ready_1_6),             
    .out_data          (back_data_1_6),              
    .out_valid         (back_valid_1_6),             
    .out_ready         (back_ready_1_6),             
    .fill_level        (din_csr_readdata_1_6),
    .almost_full       (din_almost_full_1_6),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_7"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_7 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_7_r2),              
    .in_valid          (din_valid_1_7_r2),             
    .in_ready          (din_ready_1_7),             
    .out_data          (back_data_1_7),              
    .out_valid         (back_valid_1_7),             
    .out_ready         (back_ready_1_7),             
    .fill_level        (din_csr_readdata_1_7),
    .almost_full       (din_almost_full_1_7),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_8"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_8 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_8_r2),              
    .in_valid          (din_valid_1_8_r2),             
    .in_ready          (din_ready_1_8),             
    .out_data          (back_data_1_8),              
    .out_valid         (back_valid_1_8),             
    .out_ready         (back_ready_1_8),             
    .fill_level        (din_csr_readdata_1_8),
    .almost_full       (din_almost_full_1_8),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_9"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_9 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_9_r2),              
    .in_valid          (din_valid_1_9_r2),             
    .in_ready          (din_ready_1_9),             
    .out_data          (back_data_1_9),              
    .out_valid         (back_valid_1_9),             
    .out_ready         (back_ready_1_9),             
    .fill_level        (din_csr_readdata_1_9),
    .almost_full       (din_almost_full_1_9),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_10"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_10 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_10_r2),              
    .in_valid          (din_valid_1_10_r2),             
    .in_ready          (din_ready_1_10),             
    .out_data          (back_data_1_10),              
    .out_valid         (back_valid_1_10),             
    .out_ready         (back_ready_1_10),             
    .fill_level        (din_csr_readdata_1_10),
    .almost_full       (din_almost_full_1_10),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_11"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_11 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_11_r2),              
    .in_valid          (din_valid_1_11_r2),             
    .in_ready          (din_ready_1_11),             
    .out_data          (back_data_1_11),              
    .out_valid         (back_valid_1_11),             
    .out_ready         (back_ready_1_11),             
    .fill_level        (din_csr_readdata_1_11),
    .almost_full       (din_almost_full_1_11),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_12"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_12 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_12_r2),              
    .in_valid          (din_valid_1_12_r2),             
    .in_ready          (din_ready_1_12),             
    .out_data          (back_data_1_12),              
    .out_valid         (back_valid_1_12),             
    .out_ready         (back_ready_1_12),             
    .fill_level        (din_csr_readdata_1_12),
    .almost_full       (din_almost_full_1_12),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_13"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_13 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_13_r2),              
    .in_valid          (din_valid_1_13_r2),             
    .in_ready          (din_ready_1_13),             
    .out_data          (back_data_1_13),              
    .out_valid         (back_valid_1_13),             
    .out_ready         (back_ready_1_13),             
    .fill_level        (din_csr_readdata_1_13),
    .almost_full       (din_almost_full_1_13),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_14"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_14 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_14_r2),              
    .in_valid          (din_valid_1_14_r2),             
    .in_ready          (din_ready_1_14),             
    .out_data          (back_data_1_14),              
    .out_valid         (back_valid_1_14),             
    .out_ready         (back_ready_1_14),             
    .fill_level        (din_csr_readdata_1_14),
    .almost_full       (din_almost_full_1_14),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_1_15"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_1_15 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_1_15_r2),              
    .in_valid          (din_valid_1_15_r2),             
    .in_ready          (din_ready_1_15),             
    .out_data          (back_data_1_15),              
    .out_valid         (back_valid_1_15),             
    .out_ready         (back_ready_1_15),             
    .fill_level        (din_csr_readdata_1_15),
    .almost_full       (din_almost_full_1_15),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_0"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_0 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_0_r2),              
    .in_valid          (din_valid_2_0_r2),             
    .in_ready          (din_ready_2_0),             
    .out_data          (back_data_2_0),              
    .out_valid         (back_valid_2_0),             
    .out_ready         (back_ready_2_0),             
    .fill_level        (din_csr_readdata_2_0),
    .almost_full       (din_almost_full_2_0),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_1"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_1 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_1_r2),              
    .in_valid          (din_valid_2_1_r2),             
    .in_ready          (din_ready_2_1),             
    .out_data          (back_data_2_1),              
    .out_valid         (back_valid_2_1),             
    .out_ready         (back_ready_2_1),             
    .fill_level        (din_csr_readdata_2_1),
    .almost_full       (din_almost_full_2_1),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_2"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_2 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_2_r2),              
    .in_valid          (din_valid_2_2_r2),             
    .in_ready          (din_ready_2_2),             
    .out_data          (back_data_2_2),              
    .out_valid         (back_valid_2_2),             
    .out_ready         (back_ready_2_2),             
    .fill_level        (din_csr_readdata_2_2),
    .almost_full       (din_almost_full_2_2),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_3"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_3 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_3_r2),              
    .in_valid          (din_valid_2_3_r2),             
    .in_ready          (din_ready_2_3),             
    .out_data          (back_data_2_3),              
    .out_valid         (back_valid_2_3),             
    .out_ready         (back_ready_2_3),             
    .fill_level        (din_csr_readdata_2_3),
    .almost_full       (din_almost_full_2_3),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_4"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_4 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_4_r2),              
    .in_valid          (din_valid_2_4_r2),             
    .in_ready          (din_ready_2_4),             
    .out_data          (back_data_2_4),              
    .out_valid         (back_valid_2_4),             
    .out_ready         (back_ready_2_4),             
    .fill_level        (din_csr_readdata_2_4),
    .almost_full       (din_almost_full_2_4),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_5"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_5 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_5_r2),              
    .in_valid          (din_valid_2_5_r2),             
    .in_ready          (din_ready_2_5),             
    .out_data          (back_data_2_5),              
    .out_valid         (back_valid_2_5),             
    .out_ready         (back_ready_2_5),             
    .fill_level        (din_csr_readdata_2_5),
    .almost_full       (din_almost_full_2_5),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_6"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_6 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_6_r2),              
    .in_valid          (din_valid_2_6_r2),             
    .in_ready          (din_ready_2_6),             
    .out_data          (back_data_2_6),              
    .out_valid         (back_valid_2_6),             
    .out_ready         (back_ready_2_6),             
    .fill_level        (din_csr_readdata_2_6),
    .almost_full       (din_almost_full_2_6),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_7"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_7 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_7_r2),              
    .in_valid          (din_valid_2_7_r2),             
    .in_ready          (din_ready_2_7),             
    .out_data          (back_data_2_7),              
    .out_valid         (back_valid_2_7),             
    .out_ready         (back_ready_2_7),             
    .fill_level        (din_csr_readdata_2_7),
    .almost_full       (din_almost_full_2_7),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_8"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_8 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_8_r2),              
    .in_valid          (din_valid_2_8_r2),             
    .in_ready          (din_ready_2_8),             
    .out_data          (back_data_2_8),              
    .out_valid         (back_valid_2_8),             
    .out_ready         (back_ready_2_8),             
    .fill_level        (din_csr_readdata_2_8),
    .almost_full       (din_almost_full_2_8),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_9"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_9 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_9_r2),              
    .in_valid          (din_valid_2_9_r2),             
    .in_ready          (din_ready_2_9),             
    .out_data          (back_data_2_9),              
    .out_valid         (back_valid_2_9),             
    .out_ready         (back_ready_2_9),             
    .fill_level        (din_csr_readdata_2_9),
    .almost_full       (din_almost_full_2_9),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_10"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_10 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_10_r2),              
    .in_valid          (din_valid_2_10_r2),             
    .in_ready          (din_ready_2_10),             
    .out_data          (back_data_2_10),              
    .out_valid         (back_valid_2_10),             
    .out_ready         (back_ready_2_10),             
    .fill_level        (din_csr_readdata_2_10),
    .almost_full       (din_almost_full_2_10),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_11"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_11 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_11_r2),              
    .in_valid          (din_valid_2_11_r2),             
    .in_ready          (din_ready_2_11),             
    .out_data          (back_data_2_11),              
    .out_valid         (back_valid_2_11),             
    .out_ready         (back_ready_2_11),             
    .fill_level        (din_csr_readdata_2_11),
    .almost_full       (din_almost_full_2_11),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_12"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_12 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_12_r2),              
    .in_valid          (din_valid_2_12_r2),             
    .in_ready          (din_ready_2_12),             
    .out_data          (back_data_2_12),              
    .out_valid         (back_valid_2_12),             
    .out_ready         (back_ready_2_12),             
    .fill_level        (din_csr_readdata_2_12),
    .almost_full       (din_almost_full_2_12),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_13"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_13 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_13_r2),              
    .in_valid          (din_valid_2_13_r2),             
    .in_ready          (din_ready_2_13),             
    .out_data          (back_data_2_13),              
    .out_valid         (back_valid_2_13),             
    .out_ready         (back_ready_2_13),             
    .fill_level        (din_csr_readdata_2_13),
    .almost_full       (din_almost_full_2_13),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_14"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_14 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_14_r2),              
    .in_valid          (din_valid_2_14_r2),             
    .in_ready          (din_ready_2_14),             
    .out_data          (back_data_2_14),              
    .out_valid         (back_valid_2_14),             
    .out_ready         (back_ready_2_14),             
    .fill_level        (din_csr_readdata_2_14),
    .almost_full       (din_almost_full_2_14),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_2_15"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_2_15 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_2_15_r2),              
    .in_valid          (din_valid_2_15_r2),             
    .in_ready          (din_ready_2_15),             
    .out_data          (back_data_2_15),              
    .out_valid         (back_valid_2_15),             
    .out_ready         (back_ready_2_15),             
    .fill_level        (din_csr_readdata_2_15),
    .almost_full       (din_almost_full_2_15),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_0"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_0 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_0_r2),              
    .in_valid          (din_valid_3_0_r2),             
    .in_ready          (din_ready_3_0),             
    .out_data          (back_data_3_0),              
    .out_valid         (back_valid_3_0),             
    .out_ready         (back_ready_3_0),             
    .fill_level        (din_csr_readdata_3_0),
    .almost_full       (din_almost_full_3_0),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_1"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_1 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_1_r2),              
    .in_valid          (din_valid_3_1_r2),             
    .in_ready          (din_ready_3_1),             
    .out_data          (back_data_3_1),              
    .out_valid         (back_valid_3_1),             
    .out_ready         (back_ready_3_1),             
    .fill_level        (din_csr_readdata_3_1),
    .almost_full       (din_almost_full_3_1),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_2"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_2 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_2_r2),              
    .in_valid          (din_valid_3_2_r2),             
    .in_ready          (din_ready_3_2),             
    .out_data          (back_data_3_2),              
    .out_valid         (back_valid_3_2),             
    .out_ready         (back_ready_3_2),             
    .fill_level        (din_csr_readdata_3_2),
    .almost_full       (din_almost_full_3_2),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_3"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_3 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_3_r2),              
    .in_valid          (din_valid_3_3_r2),             
    .in_ready          (din_ready_3_3),             
    .out_data          (back_data_3_3),              
    .out_valid         (back_valid_3_3),             
    .out_ready         (back_ready_3_3),             
    .fill_level        (din_csr_readdata_3_3),
    .almost_full       (din_almost_full_3_3),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_4"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_4 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_4_r2),              
    .in_valid          (din_valid_3_4_r2),             
    .in_ready          (din_ready_3_4),             
    .out_data          (back_data_3_4),              
    .out_valid         (back_valid_3_4),             
    .out_ready         (back_ready_3_4),             
    .fill_level        (din_csr_readdata_3_4),
    .almost_full       (din_almost_full_3_4),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_5"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_5 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_5_r2),              
    .in_valid          (din_valid_3_5_r2),             
    .in_ready          (din_ready_3_5),             
    .out_data          (back_data_3_5),              
    .out_valid         (back_valid_3_5),             
    .out_ready         (back_ready_3_5),             
    .fill_level        (din_csr_readdata_3_5),
    .almost_full       (din_almost_full_3_5),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_6"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_6 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_6_r2),              
    .in_valid          (din_valid_3_6_r2),             
    .in_ready          (din_ready_3_6),             
    .out_data          (back_data_3_6),              
    .out_valid         (back_valid_3_6),             
    .out_ready         (back_ready_3_6),             
    .fill_level        (din_csr_readdata_3_6),
    .almost_full       (din_almost_full_3_6),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_7"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_7 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_7_r2),              
    .in_valid          (din_valid_3_7_r2),             
    .in_ready          (din_ready_3_7),             
    .out_data          (back_data_3_7),              
    .out_valid         (back_valid_3_7),             
    .out_ready         (back_ready_3_7),             
    .fill_level        (din_csr_readdata_3_7),
    .almost_full       (din_almost_full_3_7),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_8"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_8 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_8_r2),              
    .in_valid          (din_valid_3_8_r2),             
    .in_ready          (din_ready_3_8),             
    .out_data          (back_data_3_8),              
    .out_valid         (back_valid_3_8),             
    .out_ready         (back_ready_3_8),             
    .fill_level        (din_csr_readdata_3_8),
    .almost_full       (din_almost_full_3_8),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_9"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_9 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_9_r2),              
    .in_valid          (din_valid_3_9_r2),             
    .in_ready          (din_ready_3_9),             
    .out_data          (back_data_3_9),              
    .out_valid         (back_valid_3_9),             
    .out_ready         (back_ready_3_9),             
    .fill_level        (din_csr_readdata_3_9),
    .almost_full       (din_almost_full_3_9),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_10"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_10 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_10_r2),              
    .in_valid          (din_valid_3_10_r2),             
    .in_ready          (din_ready_3_10),             
    .out_data          (back_data_3_10),              
    .out_valid         (back_valid_3_10),             
    .out_ready         (back_ready_3_10),             
    .fill_level        (din_csr_readdata_3_10),
    .almost_full       (din_almost_full_3_10),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_11"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_11 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_11_r2),              
    .in_valid          (din_valid_3_11_r2),             
    .in_ready          (din_ready_3_11),             
    .out_data          (back_data_3_11),              
    .out_valid         (back_valid_3_11),             
    .out_ready         (back_ready_3_11),             
    .fill_level        (din_csr_readdata_3_11),
    .almost_full       (din_almost_full_3_11),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_12"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_12 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_12_r2),              
    .in_valid          (din_valid_3_12_r2),             
    .in_ready          (din_ready_3_12),             
    .out_data          (back_data_3_12),              
    .out_valid         (back_valid_3_12),             
    .out_ready         (back_ready_3_12),             
    .fill_level        (din_csr_readdata_3_12),
    .almost_full       (din_almost_full_3_12),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_13"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_13 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_13_r2),              
    .in_valid          (din_valid_3_13_r2),             
    .in_ready          (din_ready_3_13),             
    .out_data          (back_data_3_13),              
    .out_valid         (back_valid_3_13),             
    .out_ready         (back_ready_3_13),             
    .fill_level        (din_csr_readdata_3_13),
    .almost_full       (din_almost_full_3_13),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_14"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_14 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_14_r2),              
    .in_valid          (din_valid_3_14_r2),             
    .in_ready          (din_ready_3_14),             
    .out_data          (back_data_3_14),              
    .out_valid         (back_valid_3_14),             
    .out_ready         (back_ready_3_14),             
    .fill_level        (din_csr_readdata_3_14),
    .almost_full       (din_almost_full_3_14),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_3_15"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_3_15 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_3_15_r2),              
    .in_valid          (din_valid_3_15_r2),             
    .in_ready          (din_ready_3_15),             
    .out_data          (back_data_3_15),              
    .out_valid         (back_valid_3_15),             
    .out_ready         (back_ready_3_15),             
    .fill_level        (din_csr_readdata_3_15),
    .almost_full       (din_almost_full_3_15),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_0"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_0 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_0_r2),              
    .in_valid          (din_valid_4_0_r2),             
    .in_ready          (din_ready_4_0),             
    .out_data          (back_data_4_0),              
    .out_valid         (back_valid_4_0),             
    .out_ready         (back_ready_4_0),             
    .fill_level        (din_csr_readdata_4_0),
    .almost_full       (din_almost_full_4_0),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_1"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_1 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_1_r2),              
    .in_valid          (din_valid_4_1_r2),             
    .in_ready          (din_ready_4_1),             
    .out_data          (back_data_4_1),              
    .out_valid         (back_valid_4_1),             
    .out_ready         (back_ready_4_1),             
    .fill_level        (din_csr_readdata_4_1),
    .almost_full       (din_almost_full_4_1),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_2"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_2 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_2_r2),              
    .in_valid          (din_valid_4_2_r2),             
    .in_ready          (din_ready_4_2),             
    .out_data          (back_data_4_2),              
    .out_valid         (back_valid_4_2),             
    .out_ready         (back_ready_4_2),             
    .fill_level        (din_csr_readdata_4_2),
    .almost_full       (din_almost_full_4_2),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_3"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_3 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_3_r2),              
    .in_valid          (din_valid_4_3_r2),             
    .in_ready          (din_ready_4_3),             
    .out_data          (back_data_4_3),              
    .out_valid         (back_valid_4_3),             
    .out_ready         (back_ready_4_3),             
    .fill_level        (din_csr_readdata_4_3),
    .almost_full       (din_almost_full_4_3),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_4"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_4 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_4_r2),              
    .in_valid          (din_valid_4_4_r2),             
    .in_ready          (din_ready_4_4),             
    .out_data          (back_data_4_4),              
    .out_valid         (back_valid_4_4),             
    .out_ready         (back_ready_4_4),             
    .fill_level        (din_csr_readdata_4_4),
    .almost_full       (din_almost_full_4_4),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_5"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_5 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_5_r2),              
    .in_valid          (din_valid_4_5_r2),             
    .in_ready          (din_ready_4_5),             
    .out_data          (back_data_4_5),              
    .out_valid         (back_valid_4_5),             
    .out_ready         (back_ready_4_5),             
    .fill_level        (din_csr_readdata_4_5),
    .almost_full       (din_almost_full_4_5),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_6"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_6 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_6_r2),              
    .in_valid          (din_valid_4_6_r2),             
    .in_ready          (din_ready_4_6),             
    .out_data          (back_data_4_6),              
    .out_valid         (back_valid_4_6),             
    .out_ready         (back_ready_4_6),             
    .fill_level        (din_csr_readdata_4_6),
    .almost_full       (din_almost_full_4_6),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_7"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_7 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_7_r2),              
    .in_valid          (din_valid_4_7_r2),             
    .in_ready          (din_ready_4_7),             
    .out_data          (back_data_4_7),              
    .out_valid         (back_valid_4_7),             
    .out_ready         (back_ready_4_7),             
    .fill_level        (din_csr_readdata_4_7),
    .almost_full       (din_almost_full_4_7),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_8"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_8 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_8_r2),              
    .in_valid          (din_valid_4_8_r2),             
    .in_ready          (din_ready_4_8),             
    .out_data          (back_data_4_8),              
    .out_valid         (back_valid_4_8),             
    .out_ready         (back_ready_4_8),             
    .fill_level        (din_csr_readdata_4_8),
    .almost_full       (din_almost_full_4_8),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_9"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_9 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_9_r2),              
    .in_valid          (din_valid_4_9_r2),             
    .in_ready          (din_ready_4_9),             
    .out_data          (back_data_4_9),              
    .out_valid         (back_valid_4_9),             
    .out_ready         (back_ready_4_9),             
    .fill_level        (din_csr_readdata_4_9),
    .almost_full       (din_almost_full_4_9),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_10"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_10 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_10_r2),              
    .in_valid          (din_valid_4_10_r2),             
    .in_ready          (din_ready_4_10),             
    .out_data          (back_data_4_10),              
    .out_valid         (back_valid_4_10),             
    .out_ready         (back_ready_4_10),             
    .fill_level        (din_csr_readdata_4_10),
    .almost_full       (din_almost_full_4_10),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_11"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_11 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_11_r2),              
    .in_valid          (din_valid_4_11_r2),             
    .in_ready          (din_ready_4_11),             
    .out_data          (back_data_4_11),              
    .out_valid         (back_valid_4_11),             
    .out_ready         (back_ready_4_11),             
    .fill_level        (din_csr_readdata_4_11),
    .almost_full       (din_almost_full_4_11),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_12"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_12 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_12_r2),              
    .in_valid          (din_valid_4_12_r2),             
    .in_ready          (din_ready_4_12),             
    .out_data          (back_data_4_12),              
    .out_valid         (back_valid_4_12),             
    .out_ready         (back_ready_4_12),             
    .fill_level        (din_csr_readdata_4_12),
    .almost_full       (din_almost_full_4_12),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_13"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_13 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_13_r2),              
    .in_valid          (din_valid_4_13_r2),             
    .in_ready          (din_ready_4_13),             
    .out_data          (back_data_4_13),              
    .out_valid         (back_valid_4_13),             
    .out_ready         (back_ready_4_13),             
    .fill_level        (din_csr_readdata_4_13),
    .almost_full       (din_almost_full_4_13),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_14"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_14 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_14_r2),              
    .in_valid          (din_valid_4_14_r2),             
    .in_ready          (din_ready_4_14),             
    .out_data          (back_data_4_14),              
    .out_valid         (back_valid_4_14),             
    .out_ready         (back_ready_4_14),             
    .fill_level        (din_csr_readdata_4_14),
    .almost_full       (din_almost_full_4_14),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_4_15"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_4_15 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_4_15_r2),              
    .in_valid          (din_valid_4_15_r2),             
    .in_ready          (din_ready_4_15),             
    .out_data          (back_data_4_15),              
    .out_valid         (back_valid_4_15),             
    .out_ready         (back_ready_4_15),             
    .fill_level        (din_csr_readdata_4_15),
    .almost_full       (din_almost_full_4_15),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_0"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_0 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_0_r2),              
    .in_valid          (din_valid_5_0_r2),             
    .in_ready          (din_ready_5_0),             
    .out_data          (back_data_5_0),              
    .out_valid         (back_valid_5_0),             
    .out_ready         (back_ready_5_0),             
    .fill_level        (din_csr_readdata_5_0),
    .almost_full       (din_almost_full_5_0),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_1"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_1 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_1_r2),              
    .in_valid          (din_valid_5_1_r2),             
    .in_ready          (din_ready_5_1),             
    .out_data          (back_data_5_1),              
    .out_valid         (back_valid_5_1),             
    .out_ready         (back_ready_5_1),             
    .fill_level        (din_csr_readdata_5_1),
    .almost_full       (din_almost_full_5_1),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_2"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_2 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_2_r2),              
    .in_valid          (din_valid_5_2_r2),             
    .in_ready          (din_ready_5_2),             
    .out_data          (back_data_5_2),              
    .out_valid         (back_valid_5_2),             
    .out_ready         (back_ready_5_2),             
    .fill_level        (din_csr_readdata_5_2),
    .almost_full       (din_almost_full_5_2),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_3"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_3 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_3_r2),              
    .in_valid          (din_valid_5_3_r2),             
    .in_ready          (din_ready_5_3),             
    .out_data          (back_data_5_3),              
    .out_valid         (back_valid_5_3),             
    .out_ready         (back_ready_5_3),             
    .fill_level        (din_csr_readdata_5_3),
    .almost_full       (din_almost_full_5_3),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_4"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_4 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_4_r2),              
    .in_valid          (din_valid_5_4_r2),             
    .in_ready          (din_ready_5_4),             
    .out_data          (back_data_5_4),              
    .out_valid         (back_valid_5_4),             
    .out_ready         (back_ready_5_4),             
    .fill_level        (din_csr_readdata_5_4),
    .almost_full       (din_almost_full_5_4),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_5"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_5 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_5_r2),              
    .in_valid          (din_valid_5_5_r2),             
    .in_ready          (din_ready_5_5),             
    .out_data          (back_data_5_5),              
    .out_valid         (back_valid_5_5),             
    .out_ready         (back_ready_5_5),             
    .fill_level        (din_csr_readdata_5_5),
    .almost_full       (din_almost_full_5_5),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_6"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_6 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_6_r2),              
    .in_valid          (din_valid_5_6_r2),             
    .in_ready          (din_ready_5_6),             
    .out_data          (back_data_5_6),              
    .out_valid         (back_valid_5_6),             
    .out_ready         (back_ready_5_6),             
    .fill_level        (din_csr_readdata_5_6),
    .almost_full       (din_almost_full_5_6),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_7"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_7 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_7_r2),              
    .in_valid          (din_valid_5_7_r2),             
    .in_ready          (din_ready_5_7),             
    .out_data          (back_data_5_7),              
    .out_valid         (back_valid_5_7),             
    .out_ready         (back_ready_5_7),             
    .fill_level        (din_csr_readdata_5_7),
    .almost_full       (din_almost_full_5_7),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_8"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_8 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_8_r2),              
    .in_valid          (din_valid_5_8_r2),             
    .in_ready          (din_ready_5_8),             
    .out_data          (back_data_5_8),              
    .out_valid         (back_valid_5_8),             
    .out_ready         (back_ready_5_8),             
    .fill_level        (din_csr_readdata_5_8),
    .almost_full       (din_almost_full_5_8),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_9"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_9 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_9_r2),              
    .in_valid          (din_valid_5_9_r2),             
    .in_ready          (din_ready_5_9),             
    .out_data          (back_data_5_9),              
    .out_valid         (back_valid_5_9),             
    .out_ready         (back_ready_5_9),             
    .fill_level        (din_csr_readdata_5_9),
    .almost_full       (din_almost_full_5_9),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_10"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_10 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_10_r2),              
    .in_valid          (din_valid_5_10_r2),             
    .in_ready          (din_ready_5_10),             
    .out_data          (back_data_5_10),              
    .out_valid         (back_valid_5_10),             
    .out_ready         (back_ready_5_10),             
    .fill_level        (din_csr_readdata_5_10),
    .almost_full       (din_almost_full_5_10),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_11"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_11 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_11_r2),              
    .in_valid          (din_valid_5_11_r2),             
    .in_ready          (din_ready_5_11),             
    .out_data          (back_data_5_11),              
    .out_valid         (back_valid_5_11),             
    .out_ready         (back_ready_5_11),             
    .fill_level        (din_csr_readdata_5_11),
    .almost_full       (din_almost_full_5_11),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_12"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_12 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_12_r2),              
    .in_valid          (din_valid_5_12_r2),             
    .in_ready          (din_ready_5_12),             
    .out_data          (back_data_5_12),              
    .out_valid         (back_valid_5_12),             
    .out_ready         (back_ready_5_12),             
    .fill_level        (din_csr_readdata_5_12),
    .almost_full       (din_almost_full_5_12),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_13"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_13 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_13_r2),              
    .in_valid          (din_valid_5_13_r2),             
    .in_ready          (din_ready_5_13),             
    .out_data          (back_data_5_13),              
    .out_valid         (back_valid_5_13),             
    .out_ready         (back_ready_5_13),             
    .fill_level        (din_csr_readdata_5_13),
    .almost_full       (din_almost_full_5_13),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_14"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_14 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_14_r2),              
    .in_valid          (din_valid_5_14_r2),             
    .in_ready          (din_ready_5_14),             
    .out_data          (back_data_5_14),              
    .out_valid         (back_valid_5_14),             
    .out_ready         (back_ready_5_14),             
    .fill_level        (din_csr_readdata_5_14),
    .almost_full       (din_almost_full_5_14),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_5_15"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_5_15 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_5_15_r2),              
    .in_valid          (din_valid_5_15_r2),             
    .in_ready          (din_ready_5_15),             
    .out_data          (back_data_5_15),              
    .out_valid         (back_valid_5_15),             
    .out_ready         (back_ready_5_15),             
    .fill_level        (din_csr_readdata_5_15),
    .almost_full       (din_almost_full_5_15),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_0"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_0 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_0_r2),              
    .in_valid          (din_valid_6_0_r2),             
    .in_ready          (din_ready_6_0),             
    .out_data          (back_data_6_0),              
    .out_valid         (back_valid_6_0),             
    .out_ready         (back_ready_6_0),             
    .fill_level        (din_csr_readdata_6_0),
    .almost_full       (din_almost_full_6_0),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_1"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_1 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_1_r2),              
    .in_valid          (din_valid_6_1_r2),             
    .in_ready          (din_ready_6_1),             
    .out_data          (back_data_6_1),              
    .out_valid         (back_valid_6_1),             
    .out_ready         (back_ready_6_1),             
    .fill_level        (din_csr_readdata_6_1),
    .almost_full       (din_almost_full_6_1),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_2"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_2 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_2_r2),              
    .in_valid          (din_valid_6_2_r2),             
    .in_ready          (din_ready_6_2),             
    .out_data          (back_data_6_2),              
    .out_valid         (back_valid_6_2),             
    .out_ready         (back_ready_6_2),             
    .fill_level        (din_csr_readdata_6_2),
    .almost_full       (din_almost_full_6_2),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_3"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_3 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_3_r2),              
    .in_valid          (din_valid_6_3_r2),             
    .in_ready          (din_ready_6_3),             
    .out_data          (back_data_6_3),              
    .out_valid         (back_valid_6_3),             
    .out_ready         (back_ready_6_3),             
    .fill_level        (din_csr_readdata_6_3),
    .almost_full       (din_almost_full_6_3),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_4"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_4 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_4_r2),              
    .in_valid          (din_valid_6_4_r2),             
    .in_ready          (din_ready_6_4),             
    .out_data          (back_data_6_4),              
    .out_valid         (back_valid_6_4),             
    .out_ready         (back_ready_6_4),             
    .fill_level        (din_csr_readdata_6_4),
    .almost_full       (din_almost_full_6_4),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_5"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_5 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_5_r2),              
    .in_valid          (din_valid_6_5_r2),             
    .in_ready          (din_ready_6_5),             
    .out_data          (back_data_6_5),              
    .out_valid         (back_valid_6_5),             
    .out_ready         (back_ready_6_5),             
    .fill_level        (din_csr_readdata_6_5),
    .almost_full       (din_almost_full_6_5),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_6"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_6 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_6_r2),              
    .in_valid          (din_valid_6_6_r2),             
    .in_ready          (din_ready_6_6),             
    .out_data          (back_data_6_6),              
    .out_valid         (back_valid_6_6),             
    .out_ready         (back_ready_6_6),             
    .fill_level        (din_csr_readdata_6_6),
    .almost_full       (din_almost_full_6_6),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_7"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_7 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_7_r2),              
    .in_valid          (din_valid_6_7_r2),             
    .in_ready          (din_ready_6_7),             
    .out_data          (back_data_6_7),              
    .out_valid         (back_valid_6_7),             
    .out_ready         (back_ready_6_7),             
    .fill_level        (din_csr_readdata_6_7),
    .almost_full       (din_almost_full_6_7),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_8"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_8 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_8_r2),              
    .in_valid          (din_valid_6_8_r2),             
    .in_ready          (din_ready_6_8),             
    .out_data          (back_data_6_8),              
    .out_valid         (back_valid_6_8),             
    .out_ready         (back_ready_6_8),             
    .fill_level        (din_csr_readdata_6_8),
    .almost_full       (din_almost_full_6_8),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_9"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_9 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_9_r2),              
    .in_valid          (din_valid_6_9_r2),             
    .in_ready          (din_ready_6_9),             
    .out_data          (back_data_6_9),              
    .out_valid         (back_valid_6_9),             
    .out_ready         (back_ready_6_9),             
    .fill_level        (din_csr_readdata_6_9),
    .almost_full       (din_almost_full_6_9),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_10"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_10 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_10_r2),              
    .in_valid          (din_valid_6_10_r2),             
    .in_ready          (din_ready_6_10),             
    .out_data          (back_data_6_10),              
    .out_valid         (back_valid_6_10),             
    .out_ready         (back_ready_6_10),             
    .fill_level        (din_csr_readdata_6_10),
    .almost_full       (din_almost_full_6_10),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_11"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_11 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_11_r2),              
    .in_valid          (din_valid_6_11_r2),             
    .in_ready          (din_ready_6_11),             
    .out_data          (back_data_6_11),              
    .out_valid         (back_valid_6_11),             
    .out_ready         (back_ready_6_11),             
    .fill_level        (din_csr_readdata_6_11),
    .almost_full       (din_almost_full_6_11),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_12"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_12 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_12_r2),              
    .in_valid          (din_valid_6_12_r2),             
    .in_ready          (din_ready_6_12),             
    .out_data          (back_data_6_12),              
    .out_valid         (back_valid_6_12),             
    .out_ready         (back_ready_6_12),             
    .fill_level        (din_csr_readdata_6_12),
    .almost_full       (din_almost_full_6_12),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_13"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_13 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_13_r2),              
    .in_valid          (din_valid_6_13_r2),             
    .in_ready          (din_ready_6_13),             
    .out_data          (back_data_6_13),              
    .out_valid         (back_valid_6_13),             
    .out_ready         (back_ready_6_13),             
    .fill_level        (din_csr_readdata_6_13),
    .almost_full       (din_almost_full_6_13),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_14"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_14 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_14_r2),              
    .in_valid          (din_valid_6_14_r2),             
    .in_ready          (din_ready_6_14),             
    .out_data          (back_data_6_14),              
    .out_valid         (back_valid_6_14),             
    .out_ready         (back_ready_6_14),             
    .fill_level        (din_csr_readdata_6_14),
    .almost_full       (din_almost_full_6_14),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_6_15"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_6_15 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_6_15_r2),              
    .in_valid          (din_valid_6_15_r2),             
    .in_ready          (din_ready_6_15),             
    .out_data          (back_data_6_15),              
    .out_valid         (back_valid_6_15),             
    .out_ready         (back_ready_6_15),             
    .fill_level        (din_csr_readdata_6_15),
    .almost_full       (din_almost_full_6_15),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_0"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_0 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_0_r2),              
    .in_valid          (din_valid_7_0_r2),             
    .in_ready          (din_ready_7_0),             
    .out_data          (back_data_7_0),              
    .out_valid         (back_valid_7_0),             
    .out_ready         (back_ready_7_0),             
    .fill_level        (din_csr_readdata_7_0),
    .almost_full       (din_almost_full_7_0),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_1"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_1 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_1_r2),              
    .in_valid          (din_valid_7_1_r2),             
    .in_ready          (din_ready_7_1),             
    .out_data          (back_data_7_1),              
    .out_valid         (back_valid_7_1),             
    .out_ready         (back_ready_7_1),             
    .fill_level        (din_csr_readdata_7_1),
    .almost_full       (din_almost_full_7_1),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_2"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_2 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_2_r2),              
    .in_valid          (din_valid_7_2_r2),             
    .in_ready          (din_ready_7_2),             
    .out_data          (back_data_7_2),              
    .out_valid         (back_valid_7_2),             
    .out_ready         (back_ready_7_2),             
    .fill_level        (din_csr_readdata_7_2),
    .almost_full       (din_almost_full_7_2),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_3"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_3 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_3_r2),              
    .in_valid          (din_valid_7_3_r2),             
    .in_ready          (din_ready_7_3),             
    .out_data          (back_data_7_3),              
    .out_valid         (back_valid_7_3),             
    .out_ready         (back_ready_7_3),             
    .fill_level        (din_csr_readdata_7_3),
    .almost_full       (din_almost_full_7_3),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_4"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_4 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_4_r2),              
    .in_valid          (din_valid_7_4_r2),             
    .in_ready          (din_ready_7_4),             
    .out_data          (back_data_7_4),              
    .out_valid         (back_valid_7_4),             
    .out_ready         (back_ready_7_4),             
    .fill_level        (din_csr_readdata_7_4),
    .almost_full       (din_almost_full_7_4),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_5"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_5 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_5_r2),              
    .in_valid          (din_valid_7_5_r2),             
    .in_ready          (din_ready_7_5),             
    .out_data          (back_data_7_5),              
    .out_valid         (back_valid_7_5),             
    .out_ready         (back_ready_7_5),             
    .fill_level        (din_csr_readdata_7_5),
    .almost_full       (din_almost_full_7_5),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_6"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_6 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_6_r2),              
    .in_valid          (din_valid_7_6_r2),             
    .in_ready          (din_ready_7_6),             
    .out_data          (back_data_7_6),              
    .out_valid         (back_valid_7_6),             
    .out_ready         (back_ready_7_6),             
    .fill_level        (din_csr_readdata_7_6),
    .almost_full       (din_almost_full_7_6),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_7"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_7 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_7_r2),              
    .in_valid          (din_valid_7_7_r2),             
    .in_ready          (din_ready_7_7),             
    .out_data          (back_data_7_7),              
    .out_valid         (back_valid_7_7),             
    .out_ready         (back_ready_7_7),             
    .fill_level        (din_csr_readdata_7_7),
    .almost_full       (din_almost_full_7_7),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_8"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_8 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_8_r2),              
    .in_valid          (din_valid_7_8_r2),             
    .in_ready          (din_ready_7_8),             
    .out_data          (back_data_7_8),              
    .out_valid         (back_valid_7_8),             
    .out_ready         (back_ready_7_8),             
    .fill_level        (din_csr_readdata_7_8),
    .almost_full       (din_almost_full_7_8),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_9"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_9 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_9_r2),              
    .in_valid          (din_valid_7_9_r2),             
    .in_ready          (din_ready_7_9),             
    .out_data          (back_data_7_9),              
    .out_valid         (back_valid_7_9),             
    .out_ready         (back_ready_7_9),             
    .fill_level        (din_csr_readdata_7_9),
    .almost_full       (din_almost_full_7_9),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_10"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_10 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_10_r2),              
    .in_valid          (din_valid_7_10_r2),             
    .in_ready          (din_ready_7_10),             
    .out_data          (back_data_7_10),              
    .out_valid         (back_valid_7_10),             
    .out_ready         (back_ready_7_10),             
    .fill_level        (din_csr_readdata_7_10),
    .almost_full       (din_almost_full_7_10),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_11"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_11 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_11_r2),              
    .in_valid          (din_valid_7_11_r2),             
    .in_ready          (din_ready_7_11),             
    .out_data          (back_data_7_11),              
    .out_valid         (back_valid_7_11),             
    .out_ready         (back_ready_7_11),             
    .fill_level        (din_csr_readdata_7_11),
    .almost_full       (din_almost_full_7_11),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_12"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_12 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_12_r2),              
    .in_valid          (din_valid_7_12_r2),             
    .in_ready          (din_ready_7_12),             
    .out_data          (back_data_7_12),              
    .out_valid         (back_valid_7_12),             
    .out_ready         (back_ready_7_12),             
    .fill_level        (din_csr_readdata_7_12),
    .almost_full       (din_almost_full_7_12),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_13"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_13 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_13_r2),              
    .in_valid          (din_valid_7_13_r2),             
    .in_ready          (din_ready_7_13),             
    .out_data          (back_data_7_13),              
    .out_valid         (back_valid_7_13),             
    .out_ready         (back_ready_7_13),             
    .fill_level        (din_csr_readdata_7_13),
    .almost_full       (din_almost_full_7_13),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_14"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_14 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_14_r2),              
    .in_valid          (din_valid_7_14_r2),             
    .in_ready          (din_ready_7_14),             
    .out_data          (back_data_7_14),              
    .out_valid         (back_valid_7_14),             
    .out_ready         (back_ready_7_14),             
    .fill_level        (din_csr_readdata_7_14),
    .almost_full       (din_almost_full_7_14),
    .overflow          ()
);
unified_fifo  #(
    .FIFO_NAME        ("[fast_pattern] dc_FIFO_7_15"),
    .MEM_TYPE         ("MLAB"),
    .DUAL_CLOCK       (0),
    .USE_ALMOST_FULL  (1),
    .FULL_LEVEL       (40),
    .SYMBOLS_PER_BEAT (1),
    .BITS_PER_SYMBOL  (RULE_S_WIDTH),
    .FIFO_DEPTH       (128)
) l1_dc_fifo_mlab_7_15 (
    .in_clk            (clk),
    .in_reset          (rst),
    .out_clk           (clk),
    .out_reset         (rst),
    .in_data           (din_7_15_r2),              
    .in_valid          (din_valid_7_15_r2),             
    .in_ready          (din_ready_7_15),             
    .out_data          (back_data_7_15),              
    .out_valid         (back_valid_7_15),             
    .out_ready         (back_ready_7_15),             
    .fill_level        (din_csr_readdata_7_15),
    .almost_full       (din_almost_full_7_15),
    .overflow          ()
);

endmodule