// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module sort_input (
        ap_clk,
        ap_rst,
        ap_start,
        start_full_n,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        input_data_TVALID,
        A_V_i_din,
        A_V_i_full_n,
        A_V_i_write,
        A_V_q_din,
        A_V_q_full_n,
        A_V_q_write,
        B_V_i_din,
        B_V_i_full_n,
        B_V_i_write,
        B_V_q_din,
        B_V_q_full_n,
        B_V_q_write,
        C_V_i_din,
        C_V_i_full_n,
        C_V_i_write,
        C_V_q_din,
        C_V_q_full_n,
        C_V_q_write,
        start_out,
        start_write,
        input_data_TDATA,
        input_data_TREADY
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_pp0_stage0 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
input   start_full_n;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input   input_data_TVALID;
output  [15:0] A_V_i_din;
input   A_V_i_full_n;
output   A_V_i_write;
output  [15:0] A_V_q_din;
input   A_V_q_full_n;
output   A_V_q_write;
output  [15:0] B_V_i_din;
input   B_V_i_full_n;
output   B_V_i_write;
output  [15:0] B_V_q_din;
input   B_V_q_full_n;
output   B_V_q_write;
output  [15:0] C_V_i_din;
input   C_V_i_full_n;
output   C_V_i_write;
output  [15:0] C_V_q_din;
input   C_V_q_full_n;
output   C_V_q_write;
output   start_out;
output   start_write;
input  [31:0] input_data_TDATA;
output   input_data_TREADY;

reg ap_done;
reg ap_idle;
reg A_V_i_write;
reg A_V_q_write;
reg B_V_i_write;
reg B_V_q_write;
reg C_V_i_write;
reg C_V_q_write;
reg start_write;
reg input_data_TREADY;

reg    real_start;
reg    start_once_reg;
reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    internal_ap_ready;
wire   [0:0] icmp_ln12_fu_244_p2;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_block_state2_pp0_stage0_iter0;
wire    io_acc_block_signal_op32;
reg   [0:0] odd_cycle_reg_266;
wire    io_acc_block_signal_op34;
reg   [0:0] tmp_1_reg_275;
reg    ap_predicate_op34_write_state3;
wire    io_acc_block_signal_op36;
reg    ap_predicate_op36_write_state3;
reg    ap_block_state3_pp0_stage0_iter1;
reg    ap_enable_reg_pp0_iter1;
reg    ap_block_pp0_stage0_11001;
reg    input_data_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    A_V_i_blk_n;
reg    A_V_q_blk_n;
reg    B_V_i_blk_n;
reg    B_V_q_blk_n;
reg    C_V_i_blk_n;
reg    C_V_q_blk_n;
reg   [8:0] val_assign1_reg_198;
wire   [15:0] in_i_fu_212_p1;
reg   [15:0] in_i_reg_252;
reg   [15:0] in_q_reg_259;
wire   [0:0] odd_cycle_fu_226_p1;
wire   [8:0] cycle_fu_230_p2;
reg   [8:0] cycle_reg_270;
reg   [0:0] icmp_ln12_reg_279;
reg    ap_block_state1;
reg    ap_block_pp0_stage0_subdone;
reg   [8:0] ap_phi_mux_val_assign1_phi_fu_202_p6;
reg    ap_block_pp0_stage0_01001;
reg   [1:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    regslice_reverse_input_data_U_apdone_blk;
wire   [31:0] input_data_TDATA_int;
wire    input_data_TVALID_int;
reg    input_data_TREADY_int;
wire    regslice_reverse_input_data_U_ack_in;
reg    ap_condition_126;

// power-on initialization
initial begin
#0 start_once_reg = 1'b0;
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

regslice_reverse #(
    .DataWidth( 32 ))
regslice_reverse_input_data_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(input_data_TDATA),
    .vld_in(input_data_TVALID),
    .ack_in(regslice_reverse_input_data_U_ack_in),
    .data_out(input_data_TDATA_int),
    .vld_out(input_data_TVALID_int),
    .ack_out(input_data_TREADY_int),
    .apdone_blk(regslice_reverse_input_data_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((icmp_ln12_reg_279 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= real_start;
        end else if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        start_once_reg <= 1'b0;
    end else begin
        if (((internal_ap_ready == 1'b0) & (real_start == 1'b1))) begin
            start_once_reg <= 1'b1;
        end else if ((internal_ap_ready == 1'b1)) begin
            start_once_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln12_reg_279 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        val_assign1_reg_198 <= cycle_reg_270;
    end else if ((((icmp_ln12_reg_279 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | (~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1)))) begin
        val_assign1_reg_198 <= 9'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        cycle_reg_270 <= cycle_fu_230_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln12_reg_279 <= icmp_ln12_fu_244_p2;
        in_i_reg_252 <= in_i_fu_212_p1;
        in_q_reg_259 <= {{input_data_TDATA_int[31:16]}};
        odd_cycle_reg_266 <= odd_cycle_fu_226_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((odd_cycle_fu_226_p1 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_1_reg_275 <= ap_phi_mux_val_assign1_phi_fu_202_p6[32'd8];
    end
end

always @ (*) begin
    if (((odd_cycle_reg_266 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        A_V_i_blk_n = A_V_i_full_n;
    end else begin
        A_V_i_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((odd_cycle_reg_266 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        A_V_i_write = 1'b1;
    end else begin
        A_V_i_write = 1'b0;
    end
end

always @ (*) begin
    if (((odd_cycle_reg_266 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        A_V_q_blk_n = A_V_q_full_n;
    end else begin
        A_V_q_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((odd_cycle_reg_266 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        A_V_q_write = 1'b1;
    end else begin
        A_V_q_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op34_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        B_V_i_blk_n = B_V_i_full_n;
    end else begin
        B_V_i_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op34_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        B_V_i_write = 1'b1;
    end else begin
        B_V_i_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op34_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        B_V_q_blk_n = B_V_q_full_n;
    end else begin
        B_V_q_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op34_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        B_V_q_write = 1'b1;
    end else begin
        B_V_q_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op36_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        C_V_i_blk_n = C_V_i_full_n;
    end else begin
        C_V_i_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op36_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        C_V_i_write = 1'b1;
    end else begin
        C_V_i_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op36_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        C_V_q_blk_n = C_V_q_full_n;
    end else begin
        C_V_q_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op36_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        C_V_q_write = 1'b1;
    end else begin
        C_V_q_write = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln12_reg_279 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((real_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter0 == 1'b0)) begin
        ap_idle_pp0_0to0 = 1'b1;
    end else begin
        ap_idle_pp0_0to0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_126)) begin
        if ((icmp_ln12_reg_279 == 1'd1)) begin
            ap_phi_mux_val_assign1_phi_fu_202_p6 = 9'd0;
        end else if ((icmp_ln12_reg_279 == 1'd0)) begin
            ap_phi_mux_val_assign1_phi_fu_202_p6 = cycle_reg_270;
        end else begin
            ap_phi_mux_val_assign1_phi_fu_202_p6 = val_assign1_reg_198;
        end
    end else begin
        ap_phi_mux_val_assign1_phi_fu_202_p6 = val_assign1_reg_198;
    end
end

always @ (*) begin
    if (((real_start == 1'b0) & (ap_idle_pp0_0to0 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        input_data_TDATA_blk_n = input_data_TVALID_int;
    end else begin
        input_data_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((input_data_TVALID == 1'b1) & (regslice_reverse_input_data_U_ack_in == 1'b1))) begin
        input_data_TREADY = 1'b1;
    end else begin
        input_data_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        input_data_TREADY_int = 1'b1;
    end else begin
        input_data_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln12_fu_244_p2 == 1'd1) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        internal_ap_ready = 1'b1;
    end else begin
        internal_ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((start_full_n == 1'b0) & (start_once_reg == 1'b0))) begin
        real_start = 1'b0;
    end else begin
        real_start = ap_start;
    end
end

always @ (*) begin
    if (((start_once_reg == 1'b0) & (real_start == 1'b1))) begin
        start_write = 1'b1;
    end else begin
        start_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((ap_reset_idle_pp0 == 1'b0)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((ap_reset_idle_pp0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign A_V_i_din = in_i_reg_252;

assign A_V_q_din = in_q_reg_259;

assign B_V_i_din = in_i_reg_252;

assign B_V_q_din = in_q_reg_259;

assign C_V_i_din = in_i_reg_252;

assign C_V_q_din = in_q_reg_259;

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((io_acc_block_signal_op36 == 1'b0) & (ap_predicate_op36_write_state3 == 1'b1)) | ((io_acc_block_signal_op34 == 1'b0) & (ap_predicate_op34_write_state3 == 1'b1)) | ((odd_cycle_reg_266 == 1'd0) & (io_acc_block_signal_op32 == 1'b0)))) | ((input_data_TVALID_int == 1'b0) & (real_start == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((io_acc_block_signal_op36 == 1'b0) & (ap_predicate_op36_write_state3 == 1'b1)) | ((io_acc_block_signal_op34 == 1'b0) & (ap_predicate_op34_write_state3 == 1'b1)) | ((odd_cycle_reg_266 == 1'd0) & (io_acc_block_signal_op32 == 1'b0)))) | ((input_data_TVALID_int == 1'b0) & (real_start == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((io_acc_block_signal_op36 == 1'b0) & (ap_predicate_op36_write_state3 == 1'b1)) | ((io_acc_block_signal_op34 == 1'b0) & (ap_predicate_op34_write_state3 == 1'b1)) | ((odd_cycle_reg_266 == 1'd0) & (io_acc_block_signal_op32 == 1'b0)))) | ((input_data_TVALID_int == 1'b0) & (real_start == 1'b1)));
end

always @ (*) begin
    ap_block_state1 = ((real_start == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = (input_data_TVALID_int == 1'b0);
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter1 = (((io_acc_block_signal_op36 == 1'b0) & (ap_predicate_op36_write_state3 == 1'b1)) | ((io_acc_block_signal_op34 == 1'b0) & (ap_predicate_op34_write_state3 == 1'b1)) | ((odd_cycle_reg_266 == 1'd0) & (io_acc_block_signal_op32 == 1'b0)));
end

always @ (*) begin
    ap_condition_126 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = real_start;

always @ (*) begin
    ap_predicate_op34_write_state3 = ((tmp_1_reg_275 == 1'd0) & (odd_cycle_reg_266 == 1'd1));
end

always @ (*) begin
    ap_predicate_op36_write_state3 = ((tmp_1_reg_275 == 1'd1) & (odd_cycle_reg_266 == 1'd1));
end

assign ap_ready = internal_ap_ready;

assign cycle_fu_230_p2 = (9'd1 + ap_phi_mux_val_assign1_phi_fu_202_p6);

assign icmp_ln12_fu_244_p2 = ((ap_phi_mux_val_assign1_phi_fu_202_p6 == 9'd511) ? 1'b1 : 1'b0);

assign in_i_fu_212_p1 = input_data_TDATA_int[15:0];

assign io_acc_block_signal_op32 = (A_V_q_full_n & A_V_i_full_n);

assign io_acc_block_signal_op34 = (B_V_q_full_n & B_V_i_full_n);

assign io_acc_block_signal_op36 = (C_V_q_full_n & C_V_i_full_n);

assign odd_cycle_fu_226_p1 = ap_phi_mux_val_assign1_phi_fu_202_p6[0:0];

assign start_out = real_start;

endmodule //sort_input
