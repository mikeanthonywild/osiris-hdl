//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
//Date        : Tue Mar 15 23:53:48 2016
//Host        : mike-HP-Z600-Workstation running 64-bit elementary OS Freya
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=2,numHierBlks=0,maxHierDepth=0,da_axi4_cnt=6,da_ps7_cnt=1,synth_mode=Global}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (clk);
  input clk;

  wire clk_1;
  wire clk_wiz_0_clk_out1;
  wire [31:0]i_buf_controller_0_addr;
  wire [31:0]i_buf_controller_0_o_data;
  wire test_pattern_generator_0_hsync;
  wire [7:0]test_pattern_generator_0_r;
  wire test_pattern_generator_0_vde;
  wire test_pattern_generator_0_vsync;

  assign clk_1 = clk;
  design_1_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(i_buf_controller_0_addr),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clk_wiz_0_clk_out1),
        .clkb(1'b0),
        .dina(i_buf_controller_0_o_data),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ena(1'b0),
        .enb(1'b0),
        .rsta(1'b0),
        .rstb(1'b0),
        .wea({1'b0,1'b0,1'b0,1'b0}),
        .web({1'b0,1'b0,1'b0,1'b0}));
  design_1_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .reset(1'b0));
  design_1_i_buf_controller_0_0 i_buf_controller_0
       (.addr(i_buf_controller_0_addr),
        .hsync(test_pattern_generator_0_hsync),
        .i_data(test_pattern_generator_0_r),
        .o_data(i_buf_controller_0_o_data),
        .pclk(clk_wiz_0_clk_out1),
        .reset_n(1'b0),
        .vde(test_pattern_generator_0_vde),
        .vsync(test_pattern_generator_0_vsync));
  design_1_test_pattern_generator_0_0 test_pattern_generator_0
       (.clk(clk_wiz_0_clk_out1),
        .hsync(test_pattern_generator_0_hsync),
        .r(test_pattern_generator_0_r),
        .vde(test_pattern_generator_0_vde),
        .vsync(test_pattern_generator_0_vsync));
endmodule
