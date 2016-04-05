/*
 * ov7670_capture.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 14th October 2015
 *
 * Module to capture pixel data from OV7670 image sensor. OV7670 requires a
 * clock input to drive 12 MHz pixel clock required for 30 FPS. This module
 * starts acquiring pixel data after OV7670 registers have been configured.
 * Pixel data is stored in a framebuffer  QVGA image resolution (320x240) is
 * used due to device block RAM constraints on the Spartan-3E FPGA.
 */

module ov7670_capture (
    input               pclk_12,    // 12MHz Pixel clock
    input               reset_n,    // Synchronous reset
    input               start,      // Start capturing
    input               vsync,      // Vertical sync signal
    input               href,       // Horizontal timing reference
    input [7:0]         d,          // RAW pixel data from sensor
    output reg [16:0]   addr,       // Framebuffer address - FIXME: OBSOLETE
    output reg [7:0]    dout,       // Data to write to framebuffer
    output reg          hsync,      // Resets i_buf_controller linebuffer addr
    output reg          vde         // i_buf_controller data valid
);

    reg [16:0] next_addr;
    reg [1:0] sync_start_pclk_12;

    always @(posedge pclk_12) begin
        if (!reset_n) begin
            // Reset everything
            addr <= 0;
            next_addr <= 0;
            dout <= 0;
            sync_start_pclk_12 <= 0;
            hsync <= 1;
            vde <= 0;
        end else begin
            // CDC sync the start capture signal
            sync_start_pclk_12[0] <= start;
            sync_start_pclk_12[1] <= sync_start_pclk_12[0];

            // Start capture
            if (sync_start_pclk_12[1]) begin
                // FIXME: OBSOLETE
                if (vsync) begin
                    addr <= 0;
                    next_addr <= 0;
                end else begin
                    if (href) begin
                        // Clock data from sensor into framebuffer
                        dout <= d[7:6];
                        addr <= next_addr;  // Output address must lag by 1
                        next_addr <= next_addr + 1;
                        vde <= 1;
                    end else begin
                        vde <= 0;
                    end
                end

                hsync <= href;
            end
        end
    end

endmodule
