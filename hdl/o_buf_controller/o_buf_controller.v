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
    input                           pclk        // Video pixel clock
    input                           reset_n     // Synchronous reset 
    input                           i_data      // Data to read from linebuffer
    output reg [ADDRESS_WIDTH-1:0]  addr        // Linebuffer address
    output reg                      vsync       // Vertical sync signal
    output reg                      hsync       // Horizontal sync signal
    output reg                      o_data      // RAW pixel value
    output reg                      req_line    // Request new line from PS
    output reg                      req_frame   // Request new frame from PS
);

    // Parameters
    parameter ADDRESS_WIDTH = 32;
    parameter integer DISPLAY_WIDTH    = 640;
    parameter integer H_FRONT_PORCH    = 00;
    parameter integer H_SYNC_PULSE     = 40;
    parameter integer H_BACK_PORCH     = 220;
    parameter integer DISPLAY_HEIGHT   = 720;
    parameter integer V_FRONT_PORCH    = 5;
    parameter integer V_SYNC_PULSE     = 5;
    parameter integer V_BACK_PORCH     = 20;

    // Local params
    localparam BLANK_WIDTH      = H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;
    localparam MAX_H_COUNT      = DISPLAY_WIDTH + BLANK_WIDTH;
    localparam BLANK_HEIGHT     = V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;
    localparam MAX_V_COUNT      = DISPLAY_HEIGHT + BLANK_HEIGHT;

    // Registers
    reg memory_ready;
    reg [12:0] h_count;
    reg [12:0] v_count;


    always @(posedge pclk) begin
        
        if (!reset_n) begin
            h_count <= 0;
            v_count <= 0;
            memory_ready <= 0;
            addr <= 0;
            hsync <= 1;
            vsync <= 1;
            o_data <= 0;
            req_line <= 0;
            req_frame <= 0;
        end else begin
            if (memory_ready) begin
                //Increment counters to drive VGA sync logic
                if (h_count < MAX_H_COUNT-1) begin
                    h_count <= h_count + 1;

                    // Increment framebuffer address while we're drawing framebuffer
                    // and also twice more for the last two pixels of the line to
                    // ensure that the
                    if (v_count < MAX_V_COUNT-1) begin
                        if (h_count+1 < FRAMEBUF_WIDTH-1  && v_count < FRAMEBUF_HEIGHT ||
                            h_count == MAX_H_COUNT-2) begin
                            addr <= addr + 1;
                        end
                    end else begin
                        if (h_count+1 < FRAMEBUF_WIDTH-1  && v_count < FRAMEBUF_HEIGHT) begin
                            addr <= addr + 1;
                        end else if (h_count == MAX_H_COUNT-2) begin
                            addr <= 0;
                        end
                    end
                end else begin
                    // New line
                    h_count <= 0;
                    addr <= addr + 1;
                    if (v_count < MAX_V_COUNT-1) begin
                        v_count <= v_count + 1;
                    end else begin
                        // New frame
                        v_count <= 0;
                    end
                end

                // VGA sync logic
                vsync <= (v_count >= (DISPLAY_HEIGHT + V_FRONT_PORCH)) &&
                    (v_count < (MAX_V_COUNT - V_BACK_PORCH));
                hsync <= (h_count < (DISPLAY_WIDTH + H_FRONT_PORCH)) ||
                    (h_count >= (MAX_H_COUNT - H_BACK_PORCH));

                // Pixel output - the fuck is this?! Tidy this up!
                o_data <= i_data;
            end else begin
                // Read first pixel and increment address
                addr <= 1;
                memory_ready <= 1;
            end
        end

    end

endmodule