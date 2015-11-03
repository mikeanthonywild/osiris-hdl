/* 
 * vga_controller.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 28th October 2015
 *
 * Module to generate VGA output to display image from framebuffer.
 */

module vga_controller (
    input               vga_clk_25,     // VGA pixel clock (640x480 = 25 MHz)
    input               reset_n,        // Asynchronous reset
    input [7:0]         din,            // RAW pixel value
    input               test_pattern,   // Output test pattern
    output reg [15:0]   addr,           // Framebuffer read address
    output              vsync,          // Vetical synchronisation signal
    output              hsync,          // Horizontal synchronisation signal
    output reg [7:0]    R,              // VGA red component
    output reg [7:0]    G,              // VGA green component
    output reg [7:0]    B               // VGA blue component
);

    reg [9:0] h_count;      // Need to check the width of this include overscan
    reg [9:0] v_count;      //   

    reg [8:0] pixel_out;    // Output pixel value

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
    assign vsync = (v_count > (DISPLAY_HEIGHT + V_FRONT_PORCH)) || 
        (v_count < (MAX_V_COUNT - V_BACK_PORCH));
    assign hsync = (h_count < (DISPLAY_WIDTH + H_FRONT_PORCH)) || 
        (h_count > (MAX_H_COUNT - H_BACK_PORCH)); 

    always @(posedge vga_clk_25 or negedge reset_n) begin
        if (!reset_n) begin
            // Reset everything
            addr <= 0;
            R <= 0;
            G <= 0;
            B <= 0;

            h_count <= 0;
            v_count <= 0;
        end

        if (vga_clk_25) begin
            //Increment counters to drive VGA sync logic
            if (h_count < MAX_H_COUNT) begin
                h_count <= h_count + 1;
                if (h_count < FRAMEBUF_WIDTH) begin
                    addr <= addr + 1;
                end
            end else begin
                h_count <= 0;
            end

            if (v_count < MAX_V_COUNT) begin
                v_count <= v_count + 1;
            end else begin
                v_count <= 0;
                addr <= 0;
            end

            if (test_pattern) begin
                // Output alternating stripes test pattern
                // TODO: Is compiler clever enough to just examine LSB?
                R <= (v_count % 2) ? 255 : 0;
                G <= (v_count % 2) ? 255 : 0;
                B <= (v_count % 2) ? 255 : 0;
            end else begin
                // Output framebuffer
                if (h_count < FRAMEBUF_WIDTH && v_count < FRAMEBUF_HEIGHT) begin
                    R <= din;
                    G <= din;
                    B <= din;
                end else begin
                    R <= 0; 
                    G <= 0;
                    B <= 0;
                end
            end
        end
    end

endmodule