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
    input           pclk_12,        // Pixel clock from OV7670
    input           clk_25,         // Core clock
    input           reset_n,        // Reset button - TODO: Does this pose CDC issues?

    input           ov7670_vsync,   // OV7670 VSYNC
    input           ov7670_href,    // OV7670 HREF
    input [7:0]     ov7670_d,       // OV7670 pixel data

    inout           sda,            // SCCB data
    output          scl,            // SCCB clock
    
    output          ov7670_pwrdn,   // Active low power down mode
    output          ov7670_reset,   // Reset signal
    output          xclk_25,        // 25MHz OV7670 system clock0 - should be 24MHz!

    output [2:0]    vga_r,          // Output red channel
    output [2:0]    vga_g,          // Output green channel
    output [1:0]    vga_b,          // Output blue channel
    output          vga_vsync,      // VGA VSYNC signal      
    output          vga_hsync       // VGA HSYNC signal    
);

    wire        start_capture;
    wire        test_pattern;
    wire [16:0] framebuf_addra;
    wire [16:0] framebuf_addrb;
    wire [1:0]  framebuf_din;
    wire [1:0]  framebuf_dout;
    wire        framebuf_we;

    assign test_pattern = 0;
    assign we = 1;

    // Instantiate core modules
    ov7670_controller ov7670_controller (
        .clk(clk_25),
        .reset_n(reset_n),
        .start_capture(start_capture), // TODO: IS THIS A CDC ISSUE?
        .ov7670_reset(ov7670_reset),
        .ov7670_pwrdn(ov7670_pwrdn),
        .sda(sda),
        .scl(scl)
    );

    ov7670_capture ov7670_capture (
        .pclk_12(pclk_12),
        .reset_n(reset_n),
        .start(start_capture),
        .vsync(ov7670_vsync),
        .href(ov7670_href),
        .d(ov7670_d),
        .addr(framebuf_addra),
        .dout(framebuf_din)
    );

    block_ram_framebuf your_instance_name (
        .clka(pclk_12), // input clka
        .wea(framebuf_we), // input [0 : 0] wea
        .addra(framebuf_addra), // input [16 : 0] addra
        .dina(framebuf_din), // input [1 : 0] dina
        .clkb(vga_clk_25), // input clkb
        .addrb(framebuf_addrb), // input [16 : 0] addrb
        .doutb(framebuf_dout) // output [1 : 0] doutb
    );

    vga_controller vga_controller (
        .vga_clk_25(clk_25),
        .reset_n(reset_n),
        .din(framebuf_dout),
        .test_pattern(test_pattern),
        .addr(framebuf_addrb),
        .vsync(vga_vsync),
        .hsync(vga_hsync),
        .R(vga_r),
        .G(vga_g),
        .B(vga_b)
    );

endmodule