/* 
 * vga_controller_dut.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 2nd November 2015
 *
 * Instantiates vga_controller module for testing.
 */

module vga_controller_dut;

    reg         vga_clk_25;     // VGA pixel clock (640x480 = 25 MHz)
    reg         reset_n;        // Synchronous reset
    reg [2:0]   din;            // RAW pixel value
    reg         test_pattern;   // Output test pattern
    wire [16:0] addr;           // Framebuffer read address
    wire        vsync;          // Vetical synchronisation signal
    wire        hsync;          // Horizontal synchronisation signal
    wire [2:0]  R;              // VGA red component
    wire [2:0]  G;              // VGA green component
    wire [1:0]  B;              // VGA blue component

    initial begin
        $dumpfile("tests/output/vga_controller.vcd");
        $dumpvars;
        $from_myhdl(vga_clk_25, reset_n, din, test_pattern);
        $to_myhdl(addr, vsync, hsync, R, G, B);
    end

    vga_controller vga_controller (
        .vga_clk_25(vga_clk_25),
        .reset_n(reset_n),
        .din(din),
        .test_pattern(test_pattern),
        .addr(addr), 
        .vsync(vsync),
        .hsync(hsync),
        .R(R),
        .G(G),
        .B(B)
    );

endmodule