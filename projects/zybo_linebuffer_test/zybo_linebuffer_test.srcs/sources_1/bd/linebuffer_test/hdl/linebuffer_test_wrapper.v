//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
//Date        : Mon Apr 11 16:56:10 2016
//Host        : Study running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target linebuffer_test_wrapper.bd
//Design      : linebuffer_test_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module linebuffer_test_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    clk,
    d,
    ddc_scl_io,
    ddc_sda_io,
    hdmi_clk_n,
    hdmi_clk_p,
    hdmi_d_n,
    hdmi_d_p,
    href,
    pclk,
    rst_btn,
    scl,
    sda,
    vsync,
    xclk);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input clk;
  input [7:0]d;
  inout ddc_scl_io;
  inout ddc_sda_io;
  output hdmi_clk_n;
  output hdmi_clk_p;
  output [2:0]hdmi_d_n;
  output [2:0]hdmi_d_p;
  input href;
  input pclk;
  input [0:0]rst_btn;
  output scl;
  inout sda;
  input vsync;
  output xclk;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire clk;
  wire [7:0]d;
  wire ddc_scl_i;
  wire ddc_scl_io;
  wire ddc_scl_o;
  wire ddc_scl_t;
  wire ddc_sda_i;
  wire ddc_sda_io;
  wire ddc_sda_o;
  wire ddc_sda_t;
  wire hdmi_clk_n;
  wire hdmi_clk_p;
  wire [2:0]hdmi_d_n;
  wire [2:0]hdmi_d_p;
  wire href;
  wire pclk;
  wire [0:0]rst_btn;
  wire scl;
  wire sda;
  wire vsync;
  wire xclk;

  IOBUF ddc_scl_iobuf
       (.I(ddc_scl_o),
        .IO(ddc_scl_io),
        .O(ddc_scl_i),
        .T(ddc_scl_t));
  IOBUF ddc_sda_iobuf
       (.I(ddc_sda_o),
        .IO(ddc_sda_io),
        .O(ddc_sda_i),
        .T(ddc_sda_t));
  linebuffer_test linebuffer_test_i
       (.DDC_scl_i(ddc_scl_i),
        .DDC_scl_o(ddc_scl_o),
        .DDC_scl_t(ddc_scl_t),
        .DDC_sda_i(ddc_sda_i),
        .DDC_sda_o(ddc_sda_o),
        .DDC_sda_t(ddc_sda_t),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .clk(clk),
        .d(d),
        .hdmi_clk_n(hdmi_clk_n),
        .hdmi_clk_p(hdmi_clk_p),
        .hdmi_d_n(hdmi_d_n),
        .hdmi_d_p(hdmi_d_p),
        .href(href),
        .pclk(pclk),
        .rst_btn(rst_btn),
        .scl(scl),
        .sda(sda),
        .vsync(vsync),
        .xclk(xclk));
endmodule
