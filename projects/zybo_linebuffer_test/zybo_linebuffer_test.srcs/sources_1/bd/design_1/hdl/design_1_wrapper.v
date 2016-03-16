//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
//Date        : Tue Mar 15 23:53:48 2016
//Host        : mike-HP-Z600-Workstation running 64-bit elementary OS Freya
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk);
  input clk;

  wire clk;

  design_1 design_1_i
       (.clk(clk));
endmodule
