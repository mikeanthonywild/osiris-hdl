/* 
 * ov7670_capture.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 14th October 2015
 *
 * Module to capture pixel data from OV7670 image sensor. OV7670 requires a
 * clock input to drive 24 MHz pixel clock required for 30 FPS. This module
 * starts acquiring pixel data after OV7670 registers have been configured.
 * Pixel data is stored in a framebuffer – QCIF image resolution (176x132) is
 * used due to device block RAM constraints on the Spartan-3E FPGA.
 */

module ov7670_capture (
    input               pclk_24,    // 24MHz Pixel clock
    input               reset_n,    // Synchronous reset
    input               start,      // Start capturing
    input               vsync,      //Vertical sync signal
    input               href,       // Horizontal timing reference
    input [7:0]         d,          // RAW pixel data from sensor
    output reg [15:0]   addr,       // Framebuffer address
    output reg [7:0]    dout        // Data to write to framebuffer
);

    reg [15:0] next_addr;

    always @(posedge pclk_24) begin
        if (!reset_n) begin
            // Reset everything
            addr <= 0;
            next_addr <= 0;
            dout <= 0;
        end else begin
            if (start) begin
                if (vsync) begin
                    addr <= 0;
                end else if (href) begin
                    // Clock data from sensor into framebuffer
                    dout <= d;
                    addr <= next_addr;  // Output address must lag by 1
                    next_addr <= next_addr + 1;
                end
            end 
        end
    end

endmodule