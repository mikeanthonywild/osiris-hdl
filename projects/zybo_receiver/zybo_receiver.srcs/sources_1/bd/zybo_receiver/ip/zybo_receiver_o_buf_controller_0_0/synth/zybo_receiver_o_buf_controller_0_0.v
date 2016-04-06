// (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: mikeanthonywild.com:user:o_buf_controller:1.0
// IP Revision: 3

(* X_CORE_INFO = "o_buf_controller,Vivado 2015.4" *)
(* CHECK_LICENSE_TYPE = "zybo_receiver_o_buf_controller_0_0,o_buf_controller,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module zybo_receiver_o_buf_controller_0_0 (
  pclk,
  reset_n,
  i_data,
  addr,
  vsync,
  hsync,
  vde,
  o_data,
  req_line,
  req_frame
);

input wire pclk;
input wire reset_n;
input wire [31 : 0] i_data;
output wire [31 : 0] addr;
output wire vsync;
output wire hsync;
output wire vde;
output wire [7 : 0] o_data;
output wire req_line;
output wire req_frame;

  o_buf_controller #(
    .ADDRESS_WIDTH(32),
    .DISPLAY_WIDTH(640),
    .H_FRONT_PORCH(16),
    .H_SYNC_PULSE(96),
    .H_BACK_PORCH(48),
    .DISPLAY_HEIGHT(480),
    .V_FRONT_PORCH(10),
    .V_SYNC_PULSE(2),
    .V_BACK_PORCH(33)
  ) inst (
    .pclk(pclk),
    .reset_n(reset_n),
    .i_data(i_data),
    .addr(addr),
    .vsync(vsync),
    .hsync(hsync),
    .vde(vde),
    .o_data(o_data),
    .req_line(req_line),
    .req_frame(req_frame)
  );
endmodule
