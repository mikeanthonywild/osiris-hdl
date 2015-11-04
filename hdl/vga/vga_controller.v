/* 
 * vga_controller.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 28th October 2015
 *
 * Module to generate VGA output to display image from framebuffer.
 * Outstanding issues:
 *  - addr and h_count start at 0x01 after reset_n deasserted
 *  - Are v_sync and h_sync pulsing at correct count and interval?
 *  - How do we account for BRAM read delay?
 *  - Many other Verilog designs seem to lack a reset and instead just provide
 *    initialisation values.
 */

module vga_controller (
    input               vga_clk_25,     // VGA pixel clock (640x480 = 25 MHz)
    input               reset_n,        // Synchronous reset
    input [7:0]         din,            // RAW pixel value
    input               test_pattern,   // Output test pattern
    output reg [15:0]   addr,           // Framebuffer read address
    output              vsync,          // Vetical synchronisation signal
    output              hsync,          // Horizontal synchronisation signal
    output [7:0]        R,              // VGA red component
    output [7:0]        G,              // VGA green component
    output [7:0]        B               // VGA blue component
);

    reg [9:0] h_count;      
    reg [9:0] v_count;       

    // Consts
    localparam DISPLAY_WIDTH    = 640;
    localparam H_FRONT_PORCH    = 16;
    localparam H_SYNC_PULSE     = 96;
    localparam H_BACK_PORCH     = 48;
    localparam BLANK_WIDTH      = H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;
    localparam MAX_H_COUNT      = DISPLAY_WIDTH + BLANK_WIDTH;
    localparam FRAMEBUF_WIDTH   = 176;

    localparam DISPLAY_HEIGHT   = 480;
    localparam V_FRONT_PORCH    = 10;
    localparam V_SYNC_PULSE     = 2;
    localparam V_BACK_PORCH     = 33;
    localparam BLANK_HEIGHT     = V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;
    localparam MAX_V_COUNT      = DISPLAY_HEIGHT + BLANK_HEIGHT;
    localparam FRAMEBUF_HEIGHT  = 144;

    // Combinatorial VGA sync logic
    assign vsync = (v_count >= (DISPLAY_HEIGHT + V_FRONT_PORCH)) && 
        (v_count < (MAX_V_COUNT - V_BACK_PORCH));
    assign hsync = (h_count < (DISPLAY_WIDTH + H_FRONT_PORCH)) || 
        (h_count >= (MAX_H_COUNT - H_BACK_PORCH)); 

    // Pixel output - the fuck is this?! Tidy this up!
    assign R = test_pattern ?   ((v_count % 2) ? 255 : 0)   :                       // Test pattern
               (h_count < FRAMEBUF_WIDTH && v_count < FRAMEBUF_HEIGHT) ? din   :    // Framebuffer
               0;                                                                   // Blank
    assign G = test_pattern ?   ((v_count % 2) ? 255 : 0)   :
               (h_count < FRAMEBUF_WIDTH && v_count < FRAMEBUF_HEIGHT) ? din   :
               0;
    assign B = test_pattern ?   ((v_count % 2) ? 255 : 0)   :
               (h_count < FRAMEBUF_WIDTH && v_count < FRAMEBUF_HEIGHT) ? din   :
               0;


    always @(posedge vga_clk_25) begin
        if (!reset_n) begin
            // Reset everything
            addr <= 0;
            h_count <= 0;
            v_count <= 0;
        end else begin
            //Increment counters to drive VGA sync logic
            if (h_count < MAX_H_COUNT-1) begin
                h_count <= h_count + 1;
                if (h_count+1 < FRAMEBUF_WIDTH) begin
                    addr <= addr + 1;
                end
            end else begin
                // New line
                h_count <= 0;
                if (v_count < MAX_V_COUNT-1) begin
                    v_count <= v_count + 1;
                    addr <= addr + 1;   // Make sure that we roll the address over
                end else begin
                    // New frame
                    v_count <= 0;
                    addr <= 0;
                end
            end
        end
    end

endmodule