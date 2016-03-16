/* 
 * i_buf_controller_dut.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 16th March 2016
 *
 * Instantiates i_buf_controller module for testing.
 */

module i_buf_controller_dut;

    reg                         pclk;           // Pixel clock
    reg                         reset_n;        // Synchronous reset
    reg                         vsync;          // Vertical sync signal
    reg                         hsync;          // Horizontal sync signal
    reg                         vde;            // Video data enabled
    reg [7:0]                   i_data;         // Input pixel data
    wire [31:0]                 addr;           // Linebuffer address
    wire [31:0]                 o_data;         // Data to write to linebuffer
    wire                        line_valid;     // Line valid interrupt
    wire                        frame_valid;    // Frame valid interrupt 

    initial begin
        $dumpfile("tests/output/i_buf_controller.vcd");
        $dumpvars;
        $from_myhdl(pclk, reset_n, vsync, hsync, vde, i_data);
        $to_myhdl(addr, o_data, line_valid, frame_valid);
    end

    i_buf_controller i_buf_controller (
        .pclk(pclk),
        .reset_n(reset_n),
        .vsync(vsync),
        .hsync(hsync),
        .vde(vde),
        .i_data(i_data),
        .addr(addr),
        .o_data(o_data),
        .line_valid(line_valid),
        .frame_valid(frame_valid)
    );

endmodule