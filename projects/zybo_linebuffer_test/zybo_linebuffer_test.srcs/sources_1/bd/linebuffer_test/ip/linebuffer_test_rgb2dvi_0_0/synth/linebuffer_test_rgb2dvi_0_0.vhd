-- (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: digilentinc.com:ip:rgb2dvi:1.2
-- IP Revision: 13

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY linebuffer_test_rgb2dvi_0_0 IS
  PORT (
    TMDS_Clk_p : OUT STD_LOGIC;
    TMDS_Clk_n : OUT STD_LOGIC;
    TMDS_Data_p : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    TMDS_Data_n : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    aRst : IN STD_LOGIC;
    vid_pData : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    vid_pVDE : IN STD_LOGIC;
    vid_pHSync : IN STD_LOGIC;
    vid_pVSync : IN STD_LOGIC;
    shutter_sync : IN STD_LOGIC;
    PixelClk : IN STD_LOGIC;
    SerialClk : IN STD_LOGIC;
    RefClk : IN STD_LOGIC;
    DDC_SDA_I : IN STD_LOGIC;
    DDC_SDA_O : OUT STD_LOGIC;
    DDC_SDA_T : OUT STD_LOGIC;
    DDC_SCL_I : IN STD_LOGIC;
    DDC_SCL_O : OUT STD_LOGIC;
    DDC_SCL_T : OUT STD_LOGIC
  );
END linebuffer_test_rgb2dvi_0_0;

ARCHITECTURE linebuffer_test_rgb2dvi_0_0_arch OF linebuffer_test_rgb2dvi_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF linebuffer_test_rgb2dvi_0_0_arch: ARCHITECTURE IS "yes";

  COMPONENT rgb2dvi IS
    GENERIC (
      kGenerateSerialClk : BOOLEAN;
      kClkPrimitive : STRING;
      kRstActiveHigh : BOOLEAN;
      kClkRange : INTEGER;
      kEmulateDDC : BOOLEAN;
      kESIDFile : STRING
    );
    PORT (
      TMDS_Clk_p : OUT STD_LOGIC;
      TMDS_Clk_n : OUT STD_LOGIC;
      TMDS_Data_p : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      TMDS_Data_n : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      aRst : IN STD_LOGIC;
      aRst_n : IN STD_LOGIC;
      vid_pData : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      vid_pVDE : IN STD_LOGIC;
      vid_pHSync : IN STD_LOGIC;
      vid_pVSync : IN STD_LOGIC;
      shutter_sync : IN STD_LOGIC;
      PixelClk : IN STD_LOGIC;
      SerialClk : IN STD_LOGIC;
      RefClk : IN STD_LOGIC;
      DDC_SDA_I : IN STD_LOGIC;
      DDC_SDA_O : OUT STD_LOGIC;
      DDC_SDA_T : OUT STD_LOGIC;
      DDC_SCL_I : IN STD_LOGIC;
      DDC_SCL_O : OUT STD_LOGIC;
      DDC_SCL_T : OUT STD_LOGIC
    );
  END COMPONENT rgb2dvi;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF linebuffer_test_rgb2dvi_0_0_arch: ARCHITECTURE IS "rgb2dvi,Vivado 2015.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF linebuffer_test_rgb2dvi_0_0_arch : ARCHITECTURE IS "linebuffer_test_rgb2dvi_0_0,rgb2dvi,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF TMDS_Clk_p: SIGNAL IS "digilentinc.com:interface:tmds:1.0 TMDS CLK_P";
  ATTRIBUTE X_INTERFACE_INFO OF TMDS_Clk_n: SIGNAL IS "digilentinc.com:interface:tmds:1.0 TMDS CLK_N";
  ATTRIBUTE X_INTERFACE_INFO OF TMDS_Data_p: SIGNAL IS "digilentinc.com:interface:tmds:1.0 TMDS DATA_P";
  ATTRIBUTE X_INTERFACE_INFO OF TMDS_Data_n: SIGNAL IS "digilentinc.com:interface:tmds:1.0 TMDS DATA_N";
  ATTRIBUTE X_INTERFACE_INFO OF aRst: SIGNAL IS "xilinx.com:signal:reset:1.0 AsyncRst RST";
  ATTRIBUTE X_INTERFACE_INFO OF vid_pData: SIGNAL IS "xilinx.com:interface:vid_io:1.0 RGB DATA";
  ATTRIBUTE X_INTERFACE_INFO OF vid_pVDE: SIGNAL IS "xilinx.com:interface:vid_io:1.0 RGB ACTIVE_VIDEO";
  ATTRIBUTE X_INTERFACE_INFO OF vid_pHSync: SIGNAL IS "xilinx.com:interface:vid_io:1.0 RGB HSYNC";
  ATTRIBUTE X_INTERFACE_INFO OF vid_pVSync: SIGNAL IS "xilinx.com:interface:vid_io:1.0 RGB VSYNC";
  ATTRIBUTE X_INTERFACE_INFO OF PixelClk: SIGNAL IS "xilinx.com:signal:clock:1.0 PixelClk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF SerialClk: SIGNAL IS "xilinx.com:signal:clock:1.0 SerialClk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF DDC_SDA_I: SIGNAL IS "xilinx.com:interface:iic:1.0 DDC SDA_I";
  ATTRIBUTE X_INTERFACE_INFO OF DDC_SDA_O: SIGNAL IS "xilinx.com:interface:iic:1.0 DDC SDA_O";
  ATTRIBUTE X_INTERFACE_INFO OF DDC_SDA_T: SIGNAL IS "xilinx.com:interface:iic:1.0 DDC SDA_T";
  ATTRIBUTE X_INTERFACE_INFO OF DDC_SCL_I: SIGNAL IS "xilinx.com:interface:iic:1.0 DDC SCL_I";
  ATTRIBUTE X_INTERFACE_INFO OF DDC_SCL_O: SIGNAL IS "xilinx.com:interface:iic:1.0 DDC SCL_O";
  ATTRIBUTE X_INTERFACE_INFO OF DDC_SCL_T: SIGNAL IS "xilinx.com:interface:iic:1.0 DDC SCL_T";
BEGIN
  U0 : rgb2dvi
    GENERIC MAP (
      kGenerateSerialClk => false,
      kClkPrimitive => "MMCM",
      kRstActiveHigh => true,
      kClkRange => 1,
      kEmulateDDC => true,
      kESIDFile => "c:/Users/Mike/Documents/osiris-hdl/ESID/ov7670/ov7670.txt"
    )
    PORT MAP (
      TMDS_Clk_p => TMDS_Clk_p,
      TMDS_Clk_n => TMDS_Clk_n,
      TMDS_Data_p => TMDS_Data_p,
      TMDS_Data_n => TMDS_Data_n,
      aRst => aRst,
      aRst_n => '1',
      vid_pData => vid_pData,
      vid_pVDE => vid_pVDE,
      vid_pHSync => vid_pHSync,
      vid_pVSync => vid_pVSync,
      shutter_sync => shutter_sync,
      PixelClk => PixelClk,
      SerialClk => SerialClk,
      RefClk => RefClk,
      DDC_SDA_I => DDC_SDA_I,
      DDC_SDA_O => DDC_SDA_O,
      DDC_SDA_T => DDC_SDA_T,
      DDC_SCL_I => DDC_SCL_I,
      DDC_SCL_O => DDC_SCL_O,
      DDC_SCL_T => DDC_SCL_T
    );
END linebuffer_test_rgb2dvi_0_0_arch;
