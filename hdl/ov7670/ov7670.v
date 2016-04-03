/* 
 * ov7670.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 3rd April 2016
 *
 * This is the top-level module for the OV7670 camera module.
 */

module ov7670 (
    input           pclk_24,        // Pixel clock from OV7670
    input           clk_24          // Core clock
    input           reset_n,        // Reset button

    input           ov7670_vsync,   // OV7670 VSYNC
    input           ov7670_href,    // OV7670 HREF
    input [7:0]     ov7670_d,       // OV7670 pixel data

    inout           sda,            // SCCB data
    output          scl,            // SCCB clock
    
    output          ov7670_pwrdn,   // Active low power down mode
    output          ov7670_reset,   // Reset signal
    output          xclk_24,        // 24MHz OV7670 system clock0

    output [7:0]    dout,           // Output data 
    output          hsync,          // Resets i_buf_controller linebuffer addr
    output          vde         // i_buf_controller data valid
);

    wire        start_capture;

    assign xclk_24 = clk_24;

    // Instantiate core modules
    ov7670_controller ov7670_controller (
        .clk(clk_24),
        .reset_n(reset_n),
        .start_capture(start_capture), // TODO: IS THIS A CDC ISSUE?
        .ov7670_reset(ov7670_reset),
        .ov7670_pwrdn(ov7670_pwrdn),
        .sda(sda),
        .scl(scl)
    );

    ov7670_capture ov7670_capture (
        .pclk_24(pclk_24),
        .reset_n(reset_n),
        .start(start_capture),
        .vsync(ov7670_vsync),
        .href(ov7670_href),
        .d(ov7670_d),
        .dout(dout),
        .hsync(hsync),
        .vde(vde)
    );

endmodule