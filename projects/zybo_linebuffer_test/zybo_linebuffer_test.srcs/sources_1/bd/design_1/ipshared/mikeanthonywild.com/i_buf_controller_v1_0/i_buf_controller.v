/*
 * i_buf_controller.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 14th March 2016
 *
 * Module to perform readout of image data into linebuffer. Two
 * interrupts are used to notify the processing system about the
 * state of the linebuffer so it can perform a DMA to copy the data 
 * into a DRAM framebuffer. AXI BRAM controller is limited to min.
 * 32-bit data width, so we need to shift 4 pixels into write_buffer
 * before clocking them out.
 */

module i_buf_controller (
    input                           pclk,       // Pixel clock
    input                           reset_n,    // Synchronous reset
    input                           vsync,      // Vertical sync signal
    input                           hsync,      // Horizontal sync signal
    input                           vde,        // Video data enabled
    input [7:0]                     i_data,     // Input pixel data
    output reg [ADDRESS_WIDTH:0]    addr,       // Linebuffer address
    output reg [31:0]               o_data,     // Data to write to linebuffer
    output                          line_valid, // Line valid interrupt
    output                          frame_valid // Frame valid interrupt 
);

    parameter ADDRESS_WIDTH = 16;

    reg [16:0] next_addr;
    reg [31:0] write_buffer;
    reg [12:0] h_count;

    assign line_valid = vde;
    assign frame_valid = vsync;

    always @(posedge pclk) begin
        if (!reset_n) begin
            addr <= 0;
            o_data <= 0;
            h_count <= 0;
            write_buffer <= 0;
        end else begin
            if (vde) begin
                h_count <= h_count + 1;
                write_buffer <= {write_buffer[23:0], i_data};
                addr <= next_addr;
                if (!(h_count % 4)) begin
                    o_data <= write_buffer;
                    next_addr <= next_addr + 1;
                end
            end else begin
                if (!hsync) begin
                    addr <= 0;
                    next_addr <= 0;
                    h_count <= 0;
                end
            end
        end
    end

endmodule