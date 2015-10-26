/* 
 * ov7670_capture.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 14th October 2015
 *
 * Module to capture pixel data from OV7670 image sensor.
 */

module ov7670_capture (
    input               pclk_24, // 24MHz Pixel clock
    input               rst, // Synchronous reset
    input               start, /// Start capturing
    input               vsync, //Vertical sync signal
    input               href, // Horizontal timing reference
    input [7:0]         d, // Pixel data from sensor
    output reg [7:0]    addr, // Framebuffer address
    output reg [7:0]    dout // Data to write to framebuffer
);

always @(posedge pclk_24 or negedge rst) begin
    if (!rst) begin
        // Reset everything
    end

    if (pclk_24) begin
        if (vsync) begin
            addr <= 0;
        end else begin
            // Clock data from sensor into framebuffer
            dout <= d;
            addr <= addr + 1;
        end
    end
end

endmodule;