/* 
 * ov7670_capture_dut.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 15th October 2015
 *
 * Instantiates ov7670_capture module for testing.
 */

module ov7670_capture_dut;

    reg         pclk_12; // 12MHz Pixel clock
    reg         reset_n; // Synchronous reset
    reg         start; // Start capturing
    reg         vsync; //Vertical sync signal
    reg         href; // Horizontal timing reference
    reg [7:0]   d; // Pixel data from sensor
    wire [16:0] addr; // Framebuffer address
    wire [1:0]  dout; // Data to write to framebuffer

    initial begin
        $dumpfile("tests/output/ov7670_capture.vcd");
        $dumpvars;
        $from_myhdl(pclk_12, reset_n, start, vsync, href, d);
        $to_myhdl(addr, dout);
    end

    ov7670_capture ov7670_capture (
        .pclk_12(pclk_12), 
        .reset_n(reset_n),
        .start(start),
        .vsync(vsync),
        .href(href),
        .d(d),
        .addr(addr),
        .dout(dout)
    );

endmodule