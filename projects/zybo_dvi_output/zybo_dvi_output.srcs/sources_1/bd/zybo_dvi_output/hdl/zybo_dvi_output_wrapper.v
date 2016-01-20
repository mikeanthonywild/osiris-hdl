//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
//Date        : Sun Jan 17 15:07:54 2016
//Host        : mike-HP-Z600-Workstation running 64-bit elementary OS Freya
//Command     : generate_target zybo_dvi_output_wrapper.bd
//Design      : zybo_dvi_output_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module zybo_dvi_output_wrapper
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

  wire clk;
  wire hdmi_clk_n;
  wire hdmi_clk_p;
  wire [2:0]hdmi_d_n;
  wire [2:0]hdmi_d_p;
  wire [0:0]hdmi_out_en;

  zybo_dvi_output zybo_dvi_output_i
       (.clk(clk),
        .hdmi_clk_n(hdmi_clk_n),
        .hdmi_clk_p(hdmi_clk_p),
        .hdmi_d_n(hdmi_d_n),
        .hdmi_d_p(hdmi_d_p),
        .hdmi_out_en(hdmi_out_en));
endmodule
