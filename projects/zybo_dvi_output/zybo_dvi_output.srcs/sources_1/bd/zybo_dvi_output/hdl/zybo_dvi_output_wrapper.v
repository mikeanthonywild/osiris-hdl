//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
//Date        : Mon Apr 04 17:51:48 2016
//Host        : Study running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target zybo_dvi_output_wrapper.bd
//Design      : zybo_dvi_output_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module zybo_dvi_output_wrapper
   (btn,
    clk,
    hdmi_clk_n,
    hdmi_clk_p,
    hdmi_d_n,
    hdmi_d_p,
    hdmi_out_en);
  input [0:0]btn;
  input clk;
  output hdmi_clk_n;
  output hdmi_clk_p;
  output [2:0]hdmi_d_n;
  output [2:0]hdmi_d_p;
  output [0:0]hdmi_out_en;

  wire [0:0]btn;
  wire clk;
  wire hdmi_clk_n;
  wire hdmi_clk_p;
  wire [2:0]hdmi_d_n;
  wire [2:0]hdmi_d_p;
  wire [0:0]hdmi_out_en;

  zybo_dvi_output zybo_dvi_output_i
       (.btn(btn),
        .clk(clk),
        .hdmi_clk_n(hdmi_clk_n),
        .hdmi_clk_p(hdmi_clk_p),
        .hdmi_d_n(hdmi_d_n),
        .hdmi_d_p(hdmi_d_p),
        .hdmi_out_en(hdmi_out_en));
endmodule
