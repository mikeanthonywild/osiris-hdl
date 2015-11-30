/* 
 * top.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 30th November 2015
 *
 * This is the top-level module for testing the OV7670 camera module
 * on the Digilient Basys board with VGA output.
 */

module basys_top (
    input               pclk_12,        // Pixel clock from OV7670
    input               clk_25,         // Core clock

    input               ov7670_vsync,   // OV7670 VSYNC
    input               ov7670_href     // OV7670 HREF
    input [7:0]         ov7670_d,       // OV7670 pixel data

    inout reg           sda,            // SCCB data
    output reg          scl,            // SCCB clock
    
    output              ov7670_pwrdn    // Active low power down mode
    output              ov7670_reset    // Reset signal
    output              xclk_25         // 25MHz OV7670 system clock0 - should be 24MHz!

    output reg [2:0]    vga_r           // Output red channel
    output reg [2:0]    vga_g           // Output green channel
    output reg [1:0]    vga_b           // Output blue channel
    output reg          vga_vsync       // VGA VSYNC signal      
    output reg          vga_hsync       // VGA HSYNC signal     
);

// Instantiate core modules
ov7670_capture ov7670_capture (
    .pclk_12(pclk_12),
    .reset_n(REPLACE_ME),
    .start(REPLACE_ME),
    .vsync(ov7670_vsync),
    .href(ov7670_href),
    .d(ov7670_d),
    .addr(REPLACE_ME),
    .dout(REPLACE_ME)
);

// FRAMEBUFFER HERE

ov7670_controller ov7670_controller (
    
);
/*
    input   clk,            // Core clock
    input   reset_n,        // Synchronous reset
    output  start_capture,  // Signal the capture module to start
    output  ov7670_reset,   // Camera IC reset registers (active high)
    output  ov7670_pwrdn,   // Camera IC power down mode (active low)
    output  sda,            // SCCB data
    output  scl             // SCCB clock
    */
endmodule