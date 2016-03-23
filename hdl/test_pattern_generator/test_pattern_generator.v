/*
 * test_pattern_generator.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 14th January 2016
 *
 * Module to generate video test patterns to feed into various
 * outputs.
 */

 module test_pattern_generator (
     input  clk,                // Pixel clock
     output reg [7:0]   r,      // Red
     output reg [7:0]   g,      // Green
     output reg [7:0]   b,      // Blue
     output reg         vsync,  // Vertical syncrhonisation pulses
     output reg         hsync,  // Horizontal synchronisation pulses
     output reg         vde     // Video data valid (low during blanking)
);

    // Parameters
    parameter integer DISPLAY_WIDTH    = 1280;
    parameter integer H_FRONT_PORCH    = 110;
    parameter integer H_SYNC_PULSE     = 40;
    parameter integer H_BACK_PORCH     = 220;
    parameter integer DISPLAY_HEIGHT   = 720;
    parameter integer V_FRONT_PORCH    = 5;
    parameter integer V_SYNC_PULSE     = 5;
    parameter integer V_BACK_PORCH     = 20;

    // Registers
    reg [12:0] h_count;
    reg [12:0] v_count;

    localparam BLANK_WIDTH      = H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;
    localparam MAX_H_COUNT      = DISPLAY_WIDTH + BLANK_WIDTH;
    localparam BLANK_HEIGHT     = V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;
    localparam MAX_V_COUNT      = DISPLAY_HEIGHT + BLANK_HEIGHT;

    always @(posedge clk) begin

        // Increment counters
        if (h_count < MAX_H_COUNT-1) begin
            h_count <= h_count + 1;
        end else begin
            h_count <= 0;
            if (v_count < MAX_V_COUNT-1) begin
                v_count <= v_count + 1;
            end else begin
                v_count <= 0;
            end
        end

        // VGA sync logic
        vsync <= (v_count < (DISPLAY_HEIGHT + V_FRONT_PORCH)) ||
            (v_count >= (MAX_V_COUNT - V_BACK_PORCH));
        hsync <= (h_count < (DISPLAY_WIDTH + H_FRONT_PORCH)) ||
            (h_count >= (MAX_H_COUNT - H_BACK_PORCH));
        vde <= h_count < DISPLAY_WIDTH && v_count < DISPLAY_HEIGHT;

        // Colour bars
        r <= (h_count <= DISPLAY_WIDTH / 3) ? 'hff : 0;
        g <= (h_count > DISPLAY_WIDTH / 3 && h_count <= DISPLAY_WIDTH - DISPLAY_WIDTH / 3) ? 'hff : 0;
        b <= (h_count > DISPLAY_WIDTH - DISPLAY_WIDTH / 3) ? 'hff : 0;
    end

endmodule
