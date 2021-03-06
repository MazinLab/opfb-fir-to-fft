-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2019.2.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fir_to_fft is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    input_r_TDATA : IN STD_LOGIC_VECTOR (511 downto 0);
    input_r_TVALID : IN STD_LOGIC;
    input_r_TREADY : OUT STD_LOGIC;
    input_r_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    output_r_TDATA : OUT STD_LOGIC_VECTOR (511 downto 0);
    output_r_TVALID : OUT STD_LOGIC;
    output_r_TREADY : IN STD_LOGIC;
    output_r_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of fir_to_fft is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "fir_to_fft,hls_ip_2019_2_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu28dr-ffvg1517-2-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.563000,HLS_SYN_LAT=6,HLS_SYN_TPT=1,HLS_SYN_MEM=30,HLS_SYN_DSP=0,HLS_SYN_FF=2858,HLS_SYN_LUT=786,HLS_VERSION=2019_2_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv7_0 : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
    constant ap_const_lv9_180 : STD_LOGIC_VECTOR (8 downto 0) := "110000000";
    constant ap_const_lv10_3FF : STD_LOGIC_VECTOR (9 downto 0) := "1111111111";
    constant ap_const_lv10_0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv9_FF : STD_LOGIC_VECTOR (8 downto 0) := "011111111";
    constant ap_const_lv9_1FF : STD_LOGIC_VECTOR (8 downto 0) := "111111111";
    constant ap_const_lv9_1 : STD_LOGIC_VECTOR (8 downto 0) := "000000001";

    signal ap_rst_n_inv : STD_LOGIC;
    signal cycle_V : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
    signal bwrite : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal cycleout_V : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
    signal buffer_V_0_address0 : STD_LOGIC_VECTOR (8 downto 0);
    signal buffer_V_0_ce0 : STD_LOGIC;
    signal buffer_V_0_we0 : STD_LOGIC;
    signal buffer_V_0_address1 : STD_LOGIC_VECTOR (8 downto 0);
    signal buffer_V_0_ce1 : STD_LOGIC;
    signal buffer_V_0_q1 : STD_LOGIC_VECTOR (511 downto 0);
    signal buffer_V_1_address0 : STD_LOGIC_VECTOR (8 downto 0);
    signal buffer_V_1_ce0 : STD_LOGIC;
    signal buffer_V_1_we0 : STD_LOGIC;
    signal buffer_V_1_address1 : STD_LOGIC_VECTOR (8 downto 0);
    signal buffer_V_1_ce1 : STD_LOGIC;
    signal buffer_V_1_q1 : STD_LOGIC_VECTOR (511 downto 0);
    signal primed : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal input_r_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal output_r_TDATA_blk_n : STD_LOGIC;
    signal ap_enable_reg_pp0_iter5 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter6 : STD_LOGIC := '0';
    signal groupin_V_reg_324 : STD_LOGIC_VECTOR (511 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter3 : BOOLEAN;
    signal ap_block_state5_pp0_stage0_iter4 : BOOLEAN;
    signal ap_block_state6_pp0_stage0_iter5 : BOOLEAN;
    signal regslice_both_output_data_V_U_apdone_blk : STD_LOGIC;
    signal ap_block_state7_pp0_stage0_iter6 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal ndx_fu_224_p2 : STD_LOGIC_VECTOR (10 downto 0);
    signal ndx_reg_330 : STD_LOGIC_VECTOR (10 downto 0);
    signal icmp_ln879_1_fu_236_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln879_1_reg_335 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln879_1_reg_335_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln55_fu_242_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln55_reg_339 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln55_reg_339_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln55_reg_339_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln55_reg_339_pp0_iter3_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln55_reg_339_pp0_iter4_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal primed_load_reg_344 : STD_LOGIC_VECTOR (0 downto 0);
    signal primed_load_reg_344_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal bwrite_load_load_fu_281_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal bwrite_load_reg_348 : STD_LOGIC_VECTOR (0 downto 0);
    signal bwrite_load_reg_348_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal bwrite_load_reg_348_pp0_iter3_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal bwrite_load_reg_348_pp0_iter4_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal buffer_V_0_load_reg_364 : STD_LOGIC_VECTOR (511 downto 0);
    signal ap_enable_reg_pp0_iter4 : STD_LOGIC := '0';
    signal buffer_V_1_load_reg_369 : STD_LOGIC_VECTOR (511 downto 0);
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal sext_ln51_fu_276_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln544_fu_289_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal add_ln700_1_fu_264_p2 : STD_LOGIC_VECTOR (8 downto 0);
    signal xor_ln52_fu_295_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_sig_allocacmp_bwrite_load : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln700_fu_306_p2 : STD_LOGIC_VECTOR (8 downto 0);
    signal or_ln59_fu_252_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal tmp_fu_152_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln_fu_160_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal zext_ln50_fu_168_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal xor_ln50_fu_176_p2 : STD_LOGIC_VECTOR (8 downto 0);
    signal zext_ln50_2_fu_182_p1 : STD_LOGIC_VECTOR (9 downto 0);
    signal zext_ln50_1_fu_172_p1 : STD_LOGIC_VECTOR (9 downto 0);
    signal trunc_ln1371_fu_148_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal sub_ln50_fu_186_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal select_ln50_fu_192_p3 : STD_LOGIC_VECTOR (9 downto 0);
    signal and_ln50_fu_200_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal tmp_1_fu_210_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal sext_ln1467_fu_206_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal zext_ln50_3_fu_220_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal icmp_ln879_fu_230_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal regslice_both_input_data_V_U_apdone_blk : STD_LOGIC;
    signal input_r_TDATA_int : STD_LOGIC_VECTOR (511 downto 0);
    signal input_r_TVALID_int : STD_LOGIC;
    signal input_r_TREADY_int : STD_LOGIC;
    signal regslice_both_input_data_V_U_ack_in : STD_LOGIC;
    signal regslice_both_input_last_V_U_apdone_blk : STD_LOGIC;
    signal input_r_TLAST_int : STD_LOGIC_VECTOR (0 downto 0);
    signal regslice_both_input_last_V_U_vld_out : STD_LOGIC;
    signal regslice_both_input_last_V_U_ack_in : STD_LOGIC;
    signal output_r_TDATA_int : STD_LOGIC_VECTOR (511 downto 0);
    signal output_r_TVALID_int : STD_LOGIC;
    signal output_r_TREADY_int : STD_LOGIC;
    signal regslice_both_output_data_V_U_vld_out : STD_LOGIC;
    signal regslice_both_output_last_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_output_last_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_output_last_V_U_vld_out : STD_LOGIC;

    component fir_to_fft_bufferbkb IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (8 downto 0);
        ce0 : IN STD_LOGIC;
        we0 : IN STD_LOGIC;
        d0 : IN STD_LOGIC_VECTOR (511 downto 0);
        address1 : IN STD_LOGIC_VECTOR (8 downto 0);
        ce1 : IN STD_LOGIC;
        q1 : OUT STD_LOGIC_VECTOR (511 downto 0) );
    end component;


    component regslice_both IS
    generic (
        DataWidth : INTEGER );
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_in : IN STD_LOGIC;
        ack_in : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_out : OUT STD_LOGIC;
        ack_out : IN STD_LOGIC;
        apdone_blk : OUT STD_LOGIC );
    end component;



begin
    buffer_V_0_U : component fir_to_fft_bufferbkb
    generic map (
        DataWidth => 512,
        AddressRange => 512,
        AddressWidth => 9)
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        address0 => buffer_V_0_address0,
        ce0 => buffer_V_0_ce0,
        we0 => buffer_V_0_we0,
        d0 => groupin_V_reg_324,
        address1 => buffer_V_0_address1,
        ce1 => buffer_V_0_ce1,
        q1 => buffer_V_0_q1);

    buffer_V_1_U : component fir_to_fft_bufferbkb
    generic map (
        DataWidth => 512,
        AddressRange => 512,
        AddressWidth => 9)
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        address0 => buffer_V_1_address0,
        ce0 => buffer_V_1_ce0,
        we0 => buffer_V_1_we0,
        d0 => groupin_V_reg_324,
        address1 => buffer_V_1_address1,
        ce1 => buffer_V_1_ce1,
        q1 => buffer_V_1_q1);

    regslice_both_input_data_V_U : component regslice_both
    generic map (
        DataWidth => 512)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => input_r_TDATA,
        vld_in => input_r_TVALID,
        ack_in => regslice_both_input_data_V_U_ack_in,
        data_out => input_r_TDATA_int,
        vld_out => input_r_TVALID_int,
        ack_out => input_r_TREADY_int,
        apdone_blk => regslice_both_input_data_V_U_apdone_blk);

    regslice_both_input_last_V_U : component regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => input_r_TLAST,
        vld_in => input_r_TVALID,
        ack_in => regslice_both_input_last_V_U_ack_in,
        data_out => input_r_TLAST_int,
        vld_out => regslice_both_input_last_V_U_vld_out,
        ack_out => input_r_TREADY_int,
        apdone_blk => regslice_both_input_last_V_U_apdone_blk);

    regslice_both_output_data_V_U : component regslice_both
    generic map (
        DataWidth => 512)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => output_r_TDATA_int,
        vld_in => output_r_TVALID_int,
        ack_in => output_r_TREADY_int,
        data_out => output_r_TDATA,
        vld_out => regslice_both_output_data_V_U_vld_out,
        ack_out => output_r_TREADY,
        apdone_blk => regslice_both_output_data_V_U_apdone_blk);

    regslice_both_output_last_V_U : component regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => or_ln55_reg_339_pp0_iter4_reg,
        vld_in => output_r_TVALID_int,
        ack_in => regslice_both_output_last_V_U_ack_in_dummy,
        data_out => output_r_TLAST,
        vld_out => regslice_both_output_last_V_U_vld_out,
        ack_out => output_r_TREADY,
        apdone_blk => regslice_both_output_last_V_U_apdone_blk);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter4_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter4 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter5_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter5 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter6_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter6 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter4 = ap_const_logic_1) and (bwrite_load_reg_348_pp0_iter3_reg = ap_const_lv1_1))) then
                buffer_V_0_load_reg_364 <= buffer_V_0_q1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter4 = ap_const_logic_1) and (bwrite_load_reg_348_pp0_iter3_reg = ap_const_lv1_0))) then
                buffer_V_1_load_reg_369 <= buffer_V_1_q1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln879_1_reg_335_pp0_iter1_reg = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then
                bwrite <= xor_ln52_fu_295_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                bwrite_load_reg_348 <= ap_sig_allocacmp_bwrite_load;
                groupin_V_reg_324 <= input_r_TDATA_int;
                icmp_ln879_1_reg_335 <= icmp_ln879_1_fu_236_p2;
                icmp_ln879_1_reg_335_pp0_iter1_reg <= icmp_ln879_1_reg_335;
                ndx_reg_330 <= ndx_fu_224_p2;
                or_ln55_reg_339 <= or_ln55_fu_242_p2;
                or_ln55_reg_339_pp0_iter1_reg <= or_ln55_reg_339;
                primed_load_reg_344 <= primed;
                primed_load_reg_344_pp0_iter1_reg <= primed_load_reg_344;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                bwrite_load_reg_348_pp0_iter2_reg <= bwrite_load_reg_348;
                bwrite_load_reg_348_pp0_iter3_reg <= bwrite_load_reg_348_pp0_iter2_reg;
                bwrite_load_reg_348_pp0_iter4_reg <= bwrite_load_reg_348_pp0_iter3_reg;
                or_ln55_reg_339_pp0_iter2_reg <= or_ln55_reg_339_pp0_iter1_reg;
                or_ln55_reg_339_pp0_iter3_reg <= or_ln55_reg_339_pp0_iter2_reg;
                or_ln55_reg_339_pp0_iter4_reg <= or_ln55_reg_339_pp0_iter3_reg;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                cycle_V <= add_ln700_1_fu_264_p2;
                primed <= or_ln59_fu_252_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (primed_load_reg_344_pp0_iter1_reg = ap_const_lv1_1))) then
                cycleout_V <= add_ln700_fu_306_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage0_subdone, ap_reset_idle_pp0)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    add_ln700_1_fu_264_p2 <= std_logic_vector(unsigned(cycle_V) + unsigned(ap_const_lv9_1));
    add_ln700_fu_306_p2 <= std_logic_vector(unsigned(cycleout_V) + unsigned(ap_const_lv9_1));
    and_ln50_fu_200_p2 <= (sub_ln50_fu_186_p2 and select_ln50_fu_192_p3);
    and_ln_fu_160_p3 <= (tmp_fu_152_p3 & ap_const_lv7_0);
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_enable_reg_pp0_iter6, regslice_both_output_data_V_U_apdone_blk, input_r_TVALID_int)
    begin
                ap_block_pp0_stage0_01001 <= (((regslice_both_output_data_V_U_apdone_blk = ap_const_logic_1) and (ap_enable_reg_pp0_iter6 = ap_const_logic_1)) or ((input_r_TVALID_int = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_enable_reg_pp0_iter5, ap_enable_reg_pp0_iter6, regslice_both_output_data_V_U_apdone_blk, input_r_TVALID_int, output_r_TREADY_int)
    begin
                ap_block_pp0_stage0_11001 <= (((ap_enable_reg_pp0_iter6 = ap_const_logic_1) and ((output_r_TREADY_int = ap_const_logic_0) or (regslice_both_output_data_V_U_apdone_blk = ap_const_logic_1))) or ((output_r_TREADY_int = ap_const_logic_0) and (ap_enable_reg_pp0_iter5 = ap_const_logic_1)) or ((input_r_TVALID_int = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_enable_reg_pp0_iter5, ap_enable_reg_pp0_iter6, regslice_both_output_data_V_U_apdone_blk, input_r_TVALID_int, output_r_TREADY_int)
    begin
                ap_block_pp0_stage0_subdone <= (((ap_enable_reg_pp0_iter6 = ap_const_logic_1) and ((output_r_TREADY_int = ap_const_logic_0) or (regslice_both_output_data_V_U_apdone_blk = ap_const_logic_1))) or ((output_r_TREADY_int = ap_const_logic_0) and (ap_enable_reg_pp0_iter5 = ap_const_logic_1)) or ((input_r_TVALID_int = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(input_r_TVALID_int)
    begin
                ap_block_state1_pp0_stage0_iter0 <= (input_r_TVALID_int = ap_const_logic_0);
    end process;

        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage0_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage0_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp0_stage0_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state7_pp0_stage0_iter6_assign_proc : process(regslice_both_output_data_V_U_apdone_blk)
    begin
                ap_block_state7_pp0_stage0_iter6 <= (regslice_both_output_data_V_U_apdone_blk = ap_const_logic_1);
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter5, ap_enable_reg_pp0_iter6, ap_enable_reg_pp0_iter4, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3)
    begin
        if (((ap_enable_reg_pp0_iter6 = ap_const_logic_0) and (ap_enable_reg_pp0_iter5 = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter4 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_reset_idle_pp0 <= ap_const_logic_0;

    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;


    ap_sig_allocacmp_bwrite_load_assign_proc : process(bwrite, ap_block_pp0_stage0, icmp_ln879_1_reg_335_pp0_iter1_reg, ap_enable_reg_pp0_iter2, xor_ln52_fu_295_p2)
    begin
        if (((icmp_ln879_1_reg_335_pp0_iter1_reg = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            ap_sig_allocacmp_bwrite_load <= xor_ln52_fu_295_p2;
        else 
            ap_sig_allocacmp_bwrite_load <= bwrite;
        end if; 
    end process;

    buffer_V_0_address0 <= sext_ln51_fu_276_p1(9 - 1 downto 0);
    buffer_V_0_address1 <= zext_ln544_fu_289_p1(9 - 1 downto 0);

    buffer_V_0_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
            buffer_V_0_ce0 <= ap_const_logic_1;
        else 
            buffer_V_0_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    buffer_V_0_ce1_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter4, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter4 = ap_const_logic_1)))) then 
            buffer_V_0_ce1 <= ap_const_logic_1;
        else 
            buffer_V_0_ce1 <= ap_const_logic_0;
        end if; 
    end process;


    buffer_V_0_we0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, bwrite_load_load_fu_281_p1, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (bwrite_load_load_fu_281_p1 = ap_const_lv1_0))) then 
            buffer_V_0_we0 <= ap_const_logic_1;
        else 
            buffer_V_0_we0 <= ap_const_logic_0;
        end if; 
    end process;

    buffer_V_1_address0 <= sext_ln51_fu_276_p1(9 - 1 downto 0);
    buffer_V_1_address1 <= zext_ln544_fu_289_p1(9 - 1 downto 0);

    buffer_V_1_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
            buffer_V_1_ce0 <= ap_const_logic_1;
        else 
            buffer_V_1_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    buffer_V_1_ce1_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter4, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter4 = ap_const_logic_1)))) then 
            buffer_V_1_ce1 <= ap_const_logic_1;
        else 
            buffer_V_1_ce1 <= ap_const_logic_0;
        end if; 
    end process;


    buffer_V_1_we0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, bwrite_load_load_fu_281_p1, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (bwrite_load_load_fu_281_p1 = ap_const_lv1_1))) then 
            buffer_V_1_we0 <= ap_const_logic_1;
        else 
            buffer_V_1_we0 <= ap_const_logic_0;
        end if; 
    end process;

    bwrite_load_load_fu_281_p1 <= ap_sig_allocacmp_bwrite_load;
    icmp_ln879_1_fu_236_p2 <= "1" when (cycle_V = ap_const_lv9_1FF) else "0";
    icmp_ln879_fu_230_p2 <= "1" when (cycle_V = ap_const_lv9_FF) else "0";

    input_r_TDATA_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, input_r_TVALID_int)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            input_r_TDATA_blk_n <= input_r_TVALID_int;
        else 
            input_r_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    input_r_TREADY_assign_proc : process(input_r_TVALID, regslice_both_input_data_V_U_ack_in)
    begin
        if (((input_r_TVALID = ap_const_logic_1) and (regslice_both_input_data_V_U_ack_in = ap_const_logic_1))) then 
            input_r_TREADY <= ap_const_logic_1;
        else 
            input_r_TREADY <= ap_const_logic_0;
        end if; 
    end process;


    input_r_TREADY_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            input_r_TREADY_int <= ap_const_logic_1;
        else 
            input_r_TREADY_int <= ap_const_logic_0;
        end if; 
    end process;

    ndx_fu_224_p2 <= std_logic_vector(signed(sext_ln1467_fu_206_p1) + signed(zext_ln50_3_fu_220_p1));
    or_ln55_fu_242_p2 <= (icmp_ln879_fu_230_p2 or icmp_ln879_1_fu_236_p2);
    or_ln59_fu_252_p2 <= (primed or icmp_ln879_1_fu_236_p2);

    output_r_TDATA_blk_n_assign_proc : process(ap_block_pp0_stage0, ap_enable_reg_pp0_iter5, ap_enable_reg_pp0_iter6, output_r_TREADY_int)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter6 = ap_const_logic_1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter5 = ap_const_logic_1)))) then 
            output_r_TDATA_blk_n <= output_r_TREADY_int;
        else 
            output_r_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    output_r_TDATA_int <= 
        buffer_V_0_load_reg_364 when (bwrite_load_reg_348_pp0_iter4_reg(0) = '1') else 
        buffer_V_1_load_reg_369;
    output_r_TVALID <= regslice_both_output_data_V_U_vld_out;

    output_r_TVALID_int_assign_proc : process(ap_enable_reg_pp0_iter5, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter5 = ap_const_logic_1))) then 
            output_r_TVALID_int <= ap_const_logic_1;
        else 
            output_r_TVALID_int <= ap_const_logic_0;
        end if; 
    end process;

    select_ln50_fu_192_p3 <= 
        ap_const_lv10_3FF when (trunc_ln1371_fu_148_p1(0) = '1') else 
        ap_const_lv10_0;
        sext_ln1467_fu_206_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(and_ln50_fu_200_p2),11));

        sext_ln51_fu_276_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(ndx_reg_330),64));

    sub_ln50_fu_186_p2 <= std_logic_vector(unsigned(zext_ln50_2_fu_182_p1) - unsigned(zext_ln50_1_fu_172_p1));
    tmp_1_fu_210_p4 <= cycle_V(8 downto 1);
    tmp_fu_152_p3 <= cycle_V(8 downto 8);
    trunc_ln1371_fu_148_p1 <= cycle_V(1 - 1 downto 0);
    xor_ln50_fu_176_p2 <= (zext_ln50_fu_168_p1 xor ap_const_lv9_180);
    xor_ln52_fu_295_p2 <= (bwrite_load_reg_348 xor ap_const_lv1_1);
    zext_ln50_1_fu_172_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(and_ln_fu_160_p3),10));
    zext_ln50_2_fu_182_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(xor_ln50_fu_176_p2),10));
    zext_ln50_3_fu_220_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_1_fu_210_p4),11));
    zext_ln50_fu_168_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(and_ln_fu_160_p3),9));
    zext_ln544_fu_289_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(cycleout_V),64));
end behav;
