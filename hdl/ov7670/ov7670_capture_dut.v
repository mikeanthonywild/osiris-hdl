/* 
 * ov7670_capture_dut.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 15th October 2015
 *
 * Instantiates ov7670_capture module for testing.
 */

 module ov7670_capture_dut;

    reg pclk;

    initial begin
        $from_myhdl(pclk);
    end

    ov7670_capture ov7670_capture (.pclk(pclk), .vsync(vsync));

/*
        input           pclk, // Pixel clock
    input           vsync, //Vertical sync signal
    input           href, // Horizontal timing reference
    input [7:0]     d, // Pixel data
    input           reset // Synchronous reset
    */

endmodule