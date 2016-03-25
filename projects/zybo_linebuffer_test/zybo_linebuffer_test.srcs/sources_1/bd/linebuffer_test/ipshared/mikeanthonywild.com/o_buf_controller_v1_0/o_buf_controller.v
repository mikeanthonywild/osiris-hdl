/*
 * o_buf_controller.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 17th March 2016
 *
 * Module to perform conversion of linebuffer into video signal.
 * Processing System reads data out from framebuffer into linebuffer
 * when requested so o_buf_controller can generate the output
 * video.
 */

module o_buf_controller (
    input                           pclk,       // Video pixel clock
    input                           reset_n,    // Synchronous reset 
    input [31:0]                    i_data,     // Data to read from linebuffer
    output reg [ADDRESS_WIDTH-1:0]  addr,       // Linebuffer address
    output reg                      vsync,      // Vertical sync signal
    output reg                      hsync,      // Horizontal sync signal
    output reg                      vde,        // Video data enable
    output reg [7:0]                o_data,     // RAW pixel value
    output reg                      req_line,   // Request new line from PS
    output reg                      req_frame   // Request new frame from PS
);

    // Parameters
    parameter ADDRESS_WIDTH = 32;
    parameter integer DISPLAY_WIDTH    = 640;
    parameter integer H_FRONT_PORCH    = 16;
    parameter integer H_SYNC_PULSE     = 96;
    parameter integer H_BACK_PORCH     = 48;
    parameter integer DISPLAY_HEIGHT   = 480;
    parameter integer V_FRONT_PORCH    = 1;
    parameter integer V_SYNC_PULSE     = 3;
    parameter integer V_BACK_PORCH     = 25;

    // Local params
    localparam BLANK_WIDTH      = H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;
    localparam MAX_H_COUNT      = DISPLAY_WIDTH + BLANK_WIDTH;
    localparam BLANK_HEIGHT     = V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;
    localparam MAX_V_COUNT      = DISPLAY_HEIGHT + BLANK_HEIGHT;

    // Registers
    reg [12:0] h_count;
    reg [12:0] v_count;
    reg [31:0] read_buffer;
    reg hsync_next;
    reg vsync_next;

    always @(posedge pclk) begin
        
        if (!reset_n) begin
            h_count <= 0;
            v_count <= 0;
            addr <= 0;
            hsync_next <= 1;
            vsync_next <= 1;
            hsync <= 1;
            vsync <= 1;
            vde <= 0;
            o_data <= 0;
            req_line <= 0;
            req_frame <= 0;
        end else begin
            
            if (h_count < MAX_H_COUNT-1) begin
                h_count <= h_count + 1;
                o_data <= (i_data >> ((3 - ((h_count-1) % 4)) * 8)) & 'h000000ff;
                if (h_count < DISPLAY_WIDTH-1) begin
                    if (!((h_count+1) % 4) && (h_count+1)) begin
                        addr <= addr + 1;
                    end
                end
            end else begin
                h_count <= 0;
                addr <= 0;
                v_count <= v_count + 1;
                if (v_count == MAX_V_COUNT-1) begin
                    v_count <= 0;
                end
            end

            // VGA sync logic
            vsync <= (v_count < (DISPLAY_HEIGHT + V_FRONT_PORCH)) ||
                (v_count >= (MAX_V_COUNT - V_BACK_PORCH));
            vsync <= vsync_next;
            hsync_next <= (h_count < (DISPLAY_WIDTH + H_FRONT_PORCH)) ||
                (h_count >= (MAX_H_COUNT - H_BACK_PORCH));
            hsync <= hsync_next;

            // PS interrupts
            req_line <= h_count >= DISPLAY_WIDTH-1 && v_count < DISPLAY_HEIGHT;
            req_frame <= v_count == DISPLAY_HEIGHT-1;

        end

    end

endmodule