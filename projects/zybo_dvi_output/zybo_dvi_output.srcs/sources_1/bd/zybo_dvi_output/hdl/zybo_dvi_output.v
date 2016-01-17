//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
//Date        : Thu Jan 14 15:06:41 2016
//Host        : thinkpad running 64-bit elementary OS Freya
//Command     : generate_target zybo_dvi_output.bd
//Design      : zybo_dvi_output
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "zybo_dvi_output,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=zybo_dvi_output,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=2,numHierBlks=0,maxHierDepth=0,da_board_cnt=2,da_ps7_cnt=2,synth_mode=Global}" *) (* HW_HANDOFF = "zybo_dvi_output.hwdef" *) 
module zybo_dvi_output
   (clk,
    hdmi_clk_n,
    hdmi_clk_p,
    hdmi_d_n,
    hdmi_d_p,
    hdmi_out_en);
  input clk;
  output hdmi_clk_n;
  output hdmi_clk_p;
  output [2:0]hdmi_d_n;
  output [2:0]hdmi_d_p;
  output [0:0]hdmi_out_en;

  wire clk_1;
  wire clk_wiz_0_clk_out1;
  wire clk_wiz_0_clk_out2;
  wire rgb2dvi_0_TMDS_Clk_n;
  wire rgb2dvi_0_TMDS_Clk_p;
  wire [2:0]rgb2dvi_0_TMDS_Data_n;
  wire [2:0]rgb2dvi_0_TMDS_Data_p;
  wire [7:0]test_pattern_generator_0_b;
  wire [7:0]test_pattern_generator_0_g;
  wire test_pattern_generator_0_hsync;
  wire [7:0]test_pattern_generator_0_r;
  wire test_pattern_generator_0_vde;
  wire test_pattern_generator_0_vsync;
  wire [23:0]xlconcat_0_dout;
  wire [0:0]xlconstant_0_dout;

  assign clk_1 = clk;
  assign hdmi_clk_n = rgb2dvi_0_TMDS_Clk_n;
  assign hdmi_clk_p = rgb2dvi_0_TMDS_Clk_p;
  assign hdmi_d_n[2:0] = rgb2dvi_0_TMDS_Data_n;
  assign hdmi_d_p[2:0] = rgb2dvi_0_TMDS_Data_p;
  assign hdmi_out_en[0] = xlconstant_0_dout;
  zybo_dvi_output_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .clk_out2(clk_wiz_0_clk_out2),
        .reset(1'b0));
  zybo_dvi_output_rgb2dvi_0_0 rgb2dvi_0
       (.PixelClk(clk_wiz_0_clk_out1),
        .SerialClk(clk_wiz_0_clk_out2),
        .TMDS_Clk_n(rgb2dvi_0_TMDS_Clk_n),
        .TMDS_Clk_p(rgb2dvi_0_TMDS_Clk_p),
        .TMDS_Data_n(rgb2dvi_0_TMDS_Data_n),
        .TMDS_Data_p(rgb2dvi_0_TMDS_Data_p),
        .aRst(1'b0),
        .vid_pData(xlconcat_0_dout),
        .vid_pHSync(test_pattern_generator_0_hsync),
        .vid_pVDE(test_pattern_generator_0_vde),
        .vid_pVSync(test_pattern_generator_0_vsync));
  zybo_dvi_output_test_pattern_generator_0_0 test_pattern_generator_0
       (.b(test_pattern_generator_0_b),
        .clk(clk_wiz_0_clk_out1),
        .g(test_pattern_generator_0_g),
        .hsync(test_pattern_generator_0_hsync),
        .r(test_pattern_generator_0_r),
        .vde(test_pattern_generator_0_vde),
        .vsync(test_pattern_generator_0_vsync));
  zybo_dvi_output_xlconcat_0_0 xlconcat_0
       (.In0(test_pattern_generator_0_r),
        .In1(test_pattern_generator_0_g),
        .In2(test_pattern_generator_0_b),
        .dout(xlconcat_0_dout));
  zybo_dvi_output_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule
