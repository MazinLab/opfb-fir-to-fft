// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="fir_to_fft_fir_to_fft,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu28dr-ffvg1517-2-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.237000,HLS_SYN_LAT=6,HLS_SYN_TPT=1,HLS_SYN_MEM=30,HLS_SYN_DSP=0,HLS_SYN_FF=2235,HLS_SYN_LUT=705,HLS_VERSION=2021_1}" *)

module fir_to_fft (
// synthesis translate_off
    kernel_block,
// synthesis translate_on
        ap_clk,
        ap_rst_n,
        input_r_TDATA,
        input_r_TVALID,
        input_r_TREADY,
        input_r_TKEEP,
        input_r_TSTRB,
        input_r_TLAST,
        output_r_TDATA,
        output_r_TVALID,
        output_r_TREADY,
        output_r_TKEEP,
        output_r_TSTRB,
        output_r_TLAST
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

// synthesis translate_off
output kernel_block;
// synthesis translate_on
input   ap_clk;
input   ap_rst_n;
input  [511:0] input_r_TDATA;
input   input_r_TVALID;
output   input_r_TREADY;
input  [63:0] input_r_TKEEP;
input  [63:0] input_r_TSTRB;
input  [0:0] input_r_TLAST;
output  [511:0] output_r_TDATA;
output   output_r_TVALID;
input   output_r_TREADY;
output  [63:0] output_r_TKEEP;
output  [63:0] output_r_TSTRB;
output  [0:0] output_r_TLAST;

 reg    ap_rst_n_inv;
reg   [8:0] cycle_V;
reg   [0:0] bwrite;
reg   [8:0] cycleout;
wire   [8:0] buffer_V_0_address0;
reg    buffer_V_0_ce0;
reg    buffer_V_0_we0;
wire   [8:0] buffer_V_0_address1;
reg    buffer_V_0_ce1;
wire   [511:0] buffer_V_0_q1;
wire   [8:0] buffer_V_1_address0;
reg    buffer_V_1_ce0;
reg    buffer_V_1_we0;
wire   [8:0] buffer_V_1_address1;
reg    buffer_V_1_ce1;
wire   [511:0] buffer_V_1_q1;
reg   [0:0] primed;
reg    input_r_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_pp0_stage0;
reg    output_r_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg   [511:0] in_reg_328;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
reg    ap_block_state6_pp0_stage0_iter5;
wire    regslice_both_output_V_data_V_U_apdone_blk;
reg    ap_block_state7_pp0_stage0_iter6;
reg    ap_block_pp0_stage0_11001;
reg   [511:0] in_reg_328_pp0_iter1_reg;
reg   [8:0] p_Val2_s_reg_334;
wire   [8:0] sub_ln37_fu_194_p2;
reg   [8:0] sub_ln37_reg_342;
wire   [8:0] ndx_fu_241_p2;
reg   [8:0] ndx_reg_347;
wire   [0:0] icmp_ln1049_1_fu_252_p2;
reg   [0:0] icmp_ln1049_1_reg_352;
wire   [0:0] out_last_V_fu_257_p2;
reg   [0:0] out_last_V_reg_356;
reg   [0:0] out_last_V_reg_356_pp0_iter2_reg;
reg   [0:0] out_last_V_reg_356_pp0_iter3_reg;
reg   [0:0] out_last_V_reg_356_pp0_iter4_reg;
reg   [0:0] primed_load_reg_361;
reg   [0:0] primed_load_reg_361_pp0_iter2_reg;
wire   [0:0] bwrite_load_load_fu_279_p1;
reg   [0:0] bwrite_load_reg_365;
reg   [0:0] bwrite_load_reg_365_pp0_iter3_reg;
reg   [0:0] bwrite_load_reg_365_pp0_iter4_reg;
reg   [511:0] buffer_V_0_load_reg_380;
reg    ap_enable_reg_pp0_iter4;
reg   [511:0] buffer_V_1_load_reg_385;
reg    ap_enable_reg_pp0_iter1;
reg    ap_block_pp0_stage0_subdone;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
wire   [63:0] zext_ln38_fu_283_p1;
wire   [63:0] zext_ln573_fu_304_p1;
wire   [8:0] add_ln870_1_fu_200_p2;
wire   [0:0] xor_ln39_fu_288_p2;
wire   [8:0] add_ln870_fu_310_p2;
wire   [0:0] or_ln47_fu_267_p2;
reg    ap_block_pp0_stage0_01001;
wire   [0:0] tmp_fu_168_p3;
wire   [7:0] shl_ln_fu_176_p3;
wire   [8:0] zext_ln37_fu_184_p1;
wire   [8:0] xor_ln37_fu_188_p2;
wire   [7:0] ret_fu_215_p4;
wire   [0:0] trunc_ln1543_fu_212_p1;
wire   [8:0] select_ln37_fu_228_p3;
wire   [8:0] and_ln37_fu_236_p2;
wire   [8:0] zext_ln1543_fu_224_p1;
wire   [0:0] icmp_ln1049_fu_247_p2;
reg   [0:0] ap_NS_fsm;
wire    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    regslice_both_input_V_data_V_U_apdone_blk;
wire   [511:0] input_r_TDATA_int_regslice;
wire    input_r_TVALID_int_regslice;
reg    input_r_TREADY_int_regslice;
wire    regslice_both_input_V_data_V_U_ack_in;
wire    regslice_both_input_V_keep_V_U_apdone_blk;
wire   [63:0] input_r_TKEEP_int_regslice;
wire    regslice_both_input_V_keep_V_U_vld_out;
wire    regslice_both_input_V_keep_V_U_ack_in;
wire    regslice_both_input_V_strb_V_U_apdone_blk;
wire   [63:0] input_r_TSTRB_int_regslice;
wire    regslice_both_input_V_strb_V_U_vld_out;
wire    regslice_both_input_V_strb_V_U_ack_in;
wire    regslice_both_input_V_last_V_U_apdone_blk;
wire   [0:0] input_r_TLAST_int_regslice;
wire    regslice_both_input_V_last_V_U_vld_out;
wire    regslice_both_input_V_last_V_U_ack_in;
wire   [511:0] output_r_TDATA_int_regslice;
reg    output_r_TVALID_int_regslice;
wire    output_r_TREADY_int_regslice;
wire    regslice_both_output_V_data_V_U_vld_out;
wire    regslice_both_output_V_keep_V_U_apdone_blk;
wire    regslice_both_output_V_keep_V_U_ack_in_dummy;
wire    regslice_both_output_V_keep_V_U_vld_out;
wire    regslice_both_output_V_strb_V_U_apdone_blk;
wire    regslice_both_output_V_strb_V_U_ack_in_dummy;
wire    regslice_both_output_V_strb_V_U_vld_out;
wire    regslice_both_output_V_last_V_U_apdone_blk;
wire    regslice_both_output_V_last_V_U_ack_in_dummy;
wire    regslice_both_output_V_last_V_U_vld_out;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 cycle_V = 9'd0;
#0 bwrite = 1'd0;
#0 cycleout = 9'd0;
#0 primed = 1'd0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter5 = 1'b0;
#0 ap_enable_reg_pp0_iter6 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
end

fir_to_fft_buffer_V_0 #(
    .DataWidth( 512 ),
    .AddressRange( 512 ),
    .AddressWidth( 9 ))
buffer_V_0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(buffer_V_0_address0),
    .ce0(buffer_V_0_ce0),
    .we0(buffer_V_0_we0),
    .d0(in_reg_328_pp0_iter1_reg),
    .address1(buffer_V_0_address1),
    .ce1(buffer_V_0_ce1),
    .q1(buffer_V_0_q1)
);

fir_to_fft_buffer_V_0 #(
    .DataWidth( 512 ),
    .AddressRange( 512 ),
    .AddressWidth( 9 ))
buffer_V_1_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(buffer_V_1_address0),
    .ce0(buffer_V_1_ce0),
    .we0(buffer_V_1_we0),
    .d0(in_reg_328_pp0_iter1_reg),
    .address1(buffer_V_1_address1),
    .ce1(buffer_V_1_ce1),
    .q1(buffer_V_1_q1)
);

fir_to_fft_regslice_both #(
    .DataWidth( 512 ))
regslice_both_input_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(input_r_TDATA),
    .vld_in(input_r_TVALID),
    .ack_in(regslice_both_input_V_data_V_U_ack_in),
    .data_out(input_r_TDATA_int_regslice),
    .vld_out(input_r_TVALID_int_regslice),
    .ack_out(input_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_input_V_data_V_U_apdone_blk)
);

fir_to_fft_regslice_both #(
    .DataWidth( 64 ))
regslice_both_input_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(input_r_TKEEP),
    .vld_in(input_r_TVALID),
    .ack_in(regslice_both_input_V_keep_V_U_ack_in),
    .data_out(input_r_TKEEP_int_regslice),
    .vld_out(regslice_both_input_V_keep_V_U_vld_out),
    .ack_out(input_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_input_V_keep_V_U_apdone_blk)
);

fir_to_fft_regslice_both #(
    .DataWidth( 64 ))
regslice_both_input_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(input_r_TSTRB),
    .vld_in(input_r_TVALID),
    .ack_in(regslice_both_input_V_strb_V_U_ack_in),
    .data_out(input_r_TSTRB_int_regslice),
    .vld_out(regslice_both_input_V_strb_V_U_vld_out),
    .ack_out(input_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_input_V_strb_V_U_apdone_blk)
);

fir_to_fft_regslice_both #(
    .DataWidth( 1 ))
regslice_both_input_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(input_r_TLAST),
    .vld_in(input_r_TVALID),
    .ack_in(regslice_both_input_V_last_V_U_ack_in),
    .data_out(input_r_TLAST_int_regslice),
    .vld_out(regslice_both_input_V_last_V_U_vld_out),
    .ack_out(input_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_input_V_last_V_U_apdone_blk)
);

fir_to_fft_regslice_both #(
    .DataWidth( 512 ))
regslice_both_output_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(output_r_TDATA_int_regslice),
    .vld_in(output_r_TVALID_int_regslice),
    .ack_in(output_r_TREADY_int_regslice),
    .data_out(output_r_TDATA),
    .vld_out(regslice_both_output_V_data_V_U_vld_out),
    .ack_out(output_r_TREADY),
    .apdone_blk(regslice_both_output_V_data_V_U_apdone_blk)
);

fir_to_fft_regslice_both #(
    .DataWidth( 64 ))
regslice_both_output_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(64'd0),
    .vld_in(output_r_TVALID_int_regslice),
    .ack_in(regslice_both_output_V_keep_V_U_ack_in_dummy),
    .data_out(output_r_TKEEP),
    .vld_out(regslice_both_output_V_keep_V_U_vld_out),
    .ack_out(output_r_TREADY),
    .apdone_blk(regslice_both_output_V_keep_V_U_apdone_blk)
);

fir_to_fft_regslice_both #(
    .DataWidth( 64 ))
regslice_both_output_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(64'd0),
    .vld_in(output_r_TVALID_int_regslice),
    .ack_in(regslice_both_output_V_strb_V_U_ack_in_dummy),
    .data_out(output_r_TSTRB),
    .vld_out(regslice_both_output_V_strb_V_U_vld_out),
    .ack_out(output_r_TREADY),
    .apdone_blk(regslice_both_output_V_strb_V_U_apdone_blk)
);

fir_to_fft_regslice_both #(
    .DataWidth( 1 ))
regslice_both_output_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(out_last_V_reg_356_pp0_iter4_reg),
    .vld_in(output_r_TVALID_int_regslice),
    .ack_in(regslice_both_output_V_last_V_U_ack_in_dummy),
    .data_out(output_r_TLAST),
    .vld_out(regslice_both_output_V_last_V_U_vld_out),
    .ack_out(output_r_TREADY),
    .apdone_blk(regslice_both_output_V_last_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter5 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter6 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1) & (bwrite_load_reg_365_pp0_iter3_reg == 1'd1))) begin
        buffer_V_0_load_reg_380 <= buffer_V_0_q1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1) & (bwrite_load_reg_365_pp0_iter3_reg == 1'd0))) begin
        buffer_V_1_load_reg_385 <= buffer_V_1_q1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (icmp_ln1049_1_reg_352 == 1'd1))) begin
        bwrite <= xor_ln39_fu_288_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        bwrite_load_reg_365 <= bwrite;
        bwrite_load_reg_365_pp0_iter3_reg <= bwrite_load_reg_365;
        bwrite_load_reg_365_pp0_iter4_reg <= bwrite_load_reg_365_pp0_iter3_reg;
        out_last_V_reg_356_pp0_iter2_reg <= out_last_V_reg_356;
        out_last_V_reg_356_pp0_iter3_reg <= out_last_V_reg_356_pp0_iter2_reg;
        out_last_V_reg_356_pp0_iter4_reg <= out_last_V_reg_356_pp0_iter3_reg;
        primed_load_reg_361_pp0_iter2_reg <= primed_load_reg_361;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        cycle_V <= add_ln870_1_fu_200_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1) & (primed_load_reg_361_pp0_iter2_reg == 1'd1))) begin
        cycleout <= add_ln870_fu_310_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln1049_1_reg_352 <= icmp_ln1049_1_fu_252_p2;
        in_reg_328 <= input_r_TDATA_int_regslice;
        in_reg_328_pp0_iter1_reg <= in_reg_328;
        ndx_reg_347 <= ndx_fu_241_p2;
        out_last_V_reg_356 <= out_last_V_fu_257_p2;
        p_Val2_s_reg_334 <= cycle_V;
        primed_load_reg_361 <= primed;
        sub_ln37_reg_342 <= sub_ln37_fu_194_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        primed <= or_ln47_fu_267_p2;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (1'b1 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

assign ap_reset_idle_pp0 = 1'b0;

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buffer_V_0_ce0 = 1'b1;
    end else begin
        buffer_V_0_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        buffer_V_0_ce1 = 1'b1;
    end else begin
        buffer_V_0_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (bwrite_load_load_fu_279_p1 == 1'd0))) begin
        buffer_V_0_we0 = 1'b1;
    end else begin
        buffer_V_0_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buffer_V_1_ce0 = 1'b1;
    end else begin
        buffer_V_1_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        buffer_V_1_ce1 = 1'b1;
    end else begin
        buffer_V_1_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (bwrite_load_load_fu_279_p1 == 1'd1))) begin
        buffer_V_1_we0 = 1'b1;
    end else begin
        buffer_V_1_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        input_r_TDATA_blk_n = input_r_TVALID_int_regslice;
    end else begin
        input_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        input_r_TREADY_int_regslice = 1'b1;
    end else begin
        input_r_TREADY_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter6 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter5 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        output_r_TDATA_blk_n = output_r_TREADY_int_regslice;
    end else begin
        output_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter5 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        output_r_TVALID_int_regslice = 1'b1;
    end else begin
        output_r_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln870_1_fu_200_p2 = (cycle_V + 9'd1);

assign add_ln870_fu_310_p2 = (cycleout + 9'd1);

assign and_ln37_fu_236_p2 = (sub_ln37_reg_342 & select_ln37_fu_228_p3);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((ap_enable_reg_pp0_iter6 == 1'b1) & ((regslice_both_output_V_data_V_U_apdone_blk == 1'b1) | (output_r_TREADY_int_regslice == 1'b0))) | ((ap_enable_reg_pp0_iter5 == 1'b1) & (output_r_TREADY_int_regslice == 1'b0)) | ((1'b1 == 1'b1) & (input_r_TVALID_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter6 == 1'b1) & ((regslice_both_output_V_data_V_U_apdone_blk == 1'b1) | (output_r_TREADY_int_regslice == 1'b0))) | ((ap_enable_reg_pp0_iter5 == 1'b1) & (output_r_TREADY_int_regslice == 1'b0)) | ((1'b1 == 1'b1) & (input_r_TVALID_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter6 == 1'b1) & ((regslice_both_output_V_data_V_U_apdone_blk == 1'b1) | (output_r_TREADY_int_regslice == 1'b0))) | ((ap_enable_reg_pp0_iter5 == 1'b1) & (output_r_TREADY_int_regslice == 1'b0)) | ((1'b1 == 1'b1) & (input_r_TVALID_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (input_r_TVALID_int_regslice == 1'b0);
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state6_pp0_stage0_iter5 = (output_r_TREADY_int_regslice == 1'b0);
end

always @ (*) begin
    ap_block_state7_pp0_stage0_iter6 = ((regslice_both_output_V_data_V_U_apdone_blk == 1'b1) | (output_r_TREADY_int_regslice == 1'b0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign buffer_V_0_address0 = zext_ln38_fu_283_p1;

assign buffer_V_0_address1 = zext_ln573_fu_304_p1;

assign buffer_V_1_address0 = zext_ln38_fu_283_p1;

assign buffer_V_1_address1 = zext_ln573_fu_304_p1;

assign bwrite_load_load_fu_279_p1 = bwrite;

assign icmp_ln1049_1_fu_252_p2 = ((p_Val2_s_reg_334 == 9'd511) ? 1'b1 : 1'b0);

assign icmp_ln1049_fu_247_p2 = ((p_Val2_s_reg_334 == 9'd255) ? 1'b1 : 1'b0);

assign input_r_TREADY = regslice_both_input_V_data_V_U_ack_in;

assign ndx_fu_241_p2 = (and_ln37_fu_236_p2 + zext_ln1543_fu_224_p1);

assign or_ln47_fu_267_p2 = (primed | icmp_ln1049_1_fu_252_p2);

assign out_last_V_fu_257_p2 = (icmp_ln1049_fu_247_p2 | icmp_ln1049_1_fu_252_p2);

assign output_r_TDATA_int_regslice = ((bwrite_load_reg_365_pp0_iter4_reg[0:0] == 1'b1) ? buffer_V_0_load_reg_380 : buffer_V_1_load_reg_385);

assign output_r_TVALID = regslice_both_output_V_data_V_U_vld_out;

assign ret_fu_215_p4 = {{p_Val2_s_reg_334[8:1]}};

assign select_ln37_fu_228_p3 = ((trunc_ln1543_fu_212_p1[0:0] == 1'b1) ? 9'd511 : 9'd0);

assign shl_ln_fu_176_p3 = {{tmp_fu_168_p3}, {7'd0}};

assign sub_ln37_fu_194_p2 = (xor_ln37_fu_188_p2 - zext_ln37_fu_184_p1);

assign tmp_fu_168_p3 = cycle_V[32'd8];

assign trunc_ln1543_fu_212_p1 = p_Val2_s_reg_334[0:0];

assign xor_ln37_fu_188_p2 = (zext_ln37_fu_184_p1 ^ 9'd384);

assign xor_ln39_fu_288_p2 = (bwrite ^ 1'd1);

assign zext_ln1543_fu_224_p1 = ret_fu_215_p4;

assign zext_ln37_fu_184_p1 = shl_ln_fu_176_p3;

assign zext_ln38_fu_283_p1 = ndx_reg_347;

assign zext_ln573_fu_304_p1 = cycleout;


// synthesis translate_off
`include "fir_to_fft_hls_deadlock_kernel_monitor_top.vh"
// synthesis translate_on

endmodule //fir_to_fft

