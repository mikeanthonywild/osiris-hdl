/*
 * i_buf_controller.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 14th March 2016
 *
 * Module to perform readout of image data into linebuffer. Two
 * interrupts are used to notify the processing system about the
 * state of the linebuffer so it can perform a DMA to copy the data 
 * into a DRAM framebuffer.
 */

module i_buf_controller (
    input               pclk,       // Pixel clock
    input               vsync,      // Vertical sync signal
    input               hsync,      // Horizontal sync signal
    input               vde,        // Video data enabled
    input [7:0]         i_data,     // Input pixel data
    output reg [16:0]   addr,       // Linebuffer address
    output reg [31:0]   o_data,     // Data to write to linebuffer
    output reg          line_valid, // Line valid interrupt
    output reg          frame_valid // Frame valid interrupt 
);

    always @(posedge pclk) begin
        
    end

endmodule