/*
 * vga_controller.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 28th October 2015
 *
 * Module to generate VGA output to display image from framebuffer.
 * Outstanding issues:
 *  - Many other Verilog designs seem to lack a reset and instead just provide
 *    initialisation values.
 */

module vga_controller (
    input               vga_clk_25,     // VGA pixel clock (640x480 = 25 MHz)
    input               reset_n,        // Synchronous reset
    input [1:0]         din,            // RAW pixel value
    input               test_pattern,   // Output test pattern
    output reg [16:0]   addr,           // Framebuffer read address
    output reg          vsync,          // Vetical synchronisation signal
    output reg          hsync,          // Horizontal synchronisation signal
    output reg [1:0]    R,              // VGA red component
    output reg [1:0]    G,              // VGA green component
    output reg [1:0]    B               // VGA blue component
);

    reg         memory_ready;
    reg [9:0]   h_count;
    reg [9:0]   v_count;

    // Consts
    localparam DISPLAY_WIDTH    = 640;
    localparam H_FRONT_PORCH    = 16;
    localparam H_SYNC_PULSE     = 96;
    localparam H_BACK_PORCH     = 48;
    localparam BLANK_WIDTH      = H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;
    localparam MAX_H_COUNT      = DISPLAY_WIDTH + BLANK_WIDTH;
    localparam FRAMEBUF_WIDTH   = 320;

    localparam DISPLAY_HEIGHT   = 480;
    localparam V_FRONT_PORCH    = 10;
    localparam V_SYNC_PULSE     = 2;
    localparam V_BACK_PORCH     = 33;
    localparam BLANK_HEIGHT     = V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;
    localparam MAX_V_COUNT      = DISPLAY_HEIGHT + BLANK_HEIGHT;
    localparam FRAMEBUF_HEIGHT  = 240;

    always @(posedge vga_clk_25) begin
        if (!reset_n) begin
            // Reset everything
            addr <= 0;
            h_count <= 0;
            v_count <= 0;
            memory_ready <= 0;
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
                R <= test_pattern ?   ((h_count % 2) ? 'h7 : 0)   :                       // Test pattern
                     (h_count < FRAMEBUF_WIDTH && v_count < FRAMEBUF_HEIGHT) ? din   :    // Framebuffer
                     0;                                                                   // Blank
                G <= test_pattern ?   ((h_count % 2) ? 'h7 : 0)   :
                     (h_count < FRAMEBUF_WIDTH && v_count < FRAMEBUF_HEIGHT) ? din   :
                     0;
                B <= test_pattern ?   ((h_count % 2) ? 'h3 : 0)   :
                     (h_count < FRAMEBUF_WIDTH && v_count < FRAMEBUF_HEIGHT) ? din   :
                     0;
            end else begin
                // Read first pixel and increment address
                addr <= 1;
                memory_ready <= 1;
            end
        end
    end

endmodule
