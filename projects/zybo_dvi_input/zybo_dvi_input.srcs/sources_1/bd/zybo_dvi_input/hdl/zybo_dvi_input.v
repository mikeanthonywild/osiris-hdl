//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
//Date        : Wed Jan 20 19:56:07 2016
//Host        : mike-HP-Z600-Workstation running 64-bit elementary OS Freya
//Command     : generate_target zybo_dvi_input.bd
//Design      : zybo_dvi_input
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "zybo_dvi_input,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=zybo_dvi_input,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=2,numHierBlks=0,maxHierDepth=0,synth_mode=Global}" *) (* HW_HANDOFF = "zybo_dvi_input.hwdef" *) 
module zybo_dvi_input
   (DDC_scl_i,
    DDC_scl_o,
    DDC_scl_t,
    DDC_sda_i,
    DDC_sda_o,
    DDC_sda_t,
    clk,
    hdmi_clk_n,
    hdmi_clk_p,
    hdmi_d_n,
    hdmi_d_p,
    hdmi_hpd,
    hdmi_out_en,
    vga_b,
    vga_g,
    vga_hs,
    vga_r,
    vga_vs);
  input DDC_scl_i;
  output DDC_scl_o;
  output DDC_scl_t;
  input DDC_sda_i;
  output DDC_sda_o;
  output DDC_sda_t;
  input clk;
  input hdmi_clk_n;
  input hdmi_clk_p;
  input [2:0]hdmi_d_n;
  input [2:0]hdmi_d_p;
  output [0:0]hdmi_hpd;
  output [0:0]hdmi_out_en;
  output [4:0]vga_b;
  output [5:0]vga_g;
  output vga_hs;
  output [4:0]vga_r;
  output vga_vs;

  wire [0:0]GND_dout;
  wire clk_1;
  wire clk_wiz_0_clk_out1;
  wire dvi2rgb_0_DDC_SCL_I;
  wire dvi2rgb_0_DDC_SCL_O;
  wire dvi2rgb_0_DDC_SCL_T;
  wire dvi2rgb_0_DDC_SDA_I;
  wire dvi2rgb_0_DDC_SDA_O;
  wire dvi2rgb_0_DDC_SDA_T;
  wire dvi2rgb_0_PixelClk;
  wire dvi2rgb_0_RGB_ACTIVE_VIDEO;
  wire [23:0]dvi2rgb_0_RGB_DATA;
  wire dvi2rgb_0_RGB_HSYNC;
  wire dvi2rgb_0_RGB_VSYNC;
  wire hdmi_clk_n_1;
  wire hdmi_clk_p_1;
  wire [2:0]hdmi_d_n_1;
  wire [2:0]hdmi_d_p_1;
  wire [4:0]rgb2vga_0_vga_pBlue;
  wire [5:0]rgb2vga_0_vga_pGreen;
  wire rgb2vga_0_vga_pHSync;
  wire [4:0]rgb2vga_0_vga_pRed;
  wire rgb2vga_0_vga_pVSync;
  wire [0:0]xlconstant_0_dout;

  assign DDC_scl_o = dvi2rgb_0_DDC_SCL_O;
  assign DDC_scl_t = dvi2rgb_0_DDC_SCL_T;
  assign DDC_sda_o = dvi2rgb_0_DDC_SDA_O;
  assign DDC_sda_t = dvi2rgb_0_DDC_SDA_T;
  assign clk_1 = clk;
  assign dvi2rgb_0_DDC_SCL_I = DDC_scl_i;
  assign dvi2rgb_0_DDC_SDA_I = DDC_sda_i;
  assign hdmi_clk_n_1 = hdmi_clk_n;
  assign hdmi_clk_p_1 = hdmi_clk_p;
  assign hdmi_d_n_1 = hdmi_d_n[2:0];
  assign hdmi_d_p_1 = hdmi_d_p[2:0];
  assign hdmi_hpd[0] = xlconstant_0_dout;
  assign hdmi_out_en[0] = GND_dout;
  assign vga_b[4:0] = rgb2vga_0_vga_pBlue;
  assign vga_g[5:0] = rgb2vga_0_vga_pGreen;
  assign vga_hs = rgb2vga_0_vga_pHSync;
  assign vga_r[4:0] = rgb2vga_0_vga_pRed;
  assign vga_vs = rgb2vga_0_vga_pVSync;
  zybo_dvi_input_xlconstant_1_0 GND
       (.dout(GND_dout));
  zybo_dvi_input_xlconstant_0_0 VDD
       (.dout(xlconstant_0_dout));
  zybo_dvi_input_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .reset(1'b0));
  zybo_dvi_input_dvi2rgb_0_0 dvi2rgb_0
       (.DDC_SCL_I(dvi2rgb_0_DDC_SCL_I),
        .DDC_SCL_O(dvi2rgb_0_DDC_SCL_O),
        .DDC_SCL_T(dvi2rgb_0_DDC_SCL_T),
        .DDC_SDA_I(dvi2rgb_0_DDC_SDA_I),
        .DDC_SDA_O(dvi2rgb_0_DDC_SDA_O),
        .DDC_SDA_T(dvi2rgb_0_DDC_SDA_T),
        .PixelClk(dvi2rgb_0_PixelClk),
        .RefClk(clk_wiz_0_clk_out1),
        .TMDS_Clk_n(hdmi_clk_n_1),
        .TMDS_Clk_p(hdmi_clk_p_1),
        .TMDS_Data_n(hdmi_d_n_1),
        .TMDS_Data_p(hdmi_d_p_1),
        .aRst(1'b0),
        .pRst(1'b0),
        .vid_pData(dvi2rgb_0_RGB_DATA),
        .vid_pHSync(dvi2rgb_0_RGB_HSYNC),
        .vid_pVDE(dvi2rgb_0_RGB_ACTIVE_VIDEO),
        .vid_pVSync(dvi2rgb_0_RGB_VSYNC));
  zybo_dvi_input_rgb2vga_0_0 rgb2vga_0
       (.PixelClk(dvi2rgb_0_PixelClk),
        .rgb_pData(dvi2rgb_0_RGB_DATA),
        .rgb_pHSync(dvi2rgb_0_RGB_HSYNC),
        .rgb_pVDE(dvi2rgb_0_RGB_ACTIVE_VIDEO),
        .rgb_pVSync(dvi2rgb_0_RGB_VSYNC),
        .vga_pBlue(rgb2vga_0_vga_pBlue),
        .vga_pGreen(rgb2vga_0_vga_pGreen),
        .vga_pHSync(rgb2vga_0_vga_pHSync),
        .vga_pRed(rgb2vga_0_vga_pRed),
        .vga_pVSync(rgb2vga_0_vga_pVSync));
endmodule
