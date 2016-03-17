/* 
 * o_buf_controller_dut.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 17th March 2016
 *
 * Instantiates o_buf_controller module for testing.
 */

module o_buf_controller_dut;

    reg                         pclk;           // Pixel clock
    reg                         reset_n;        // Synchronous reset
    reg [31:0]                  i_data;         // Input pixel data
    wire                        vsync;          // Vertical sync signal
    wire                        hsync;          // Horizontal sync signal
    wire                        vde;            // Video data enabled
    wire [31:0]                 addr;           // Linebuffer address
    wire [7:0]                  o_data;         // Data to write to linebuffer
    wire                        req_line;       // PS line request
    wire                        req_frame;      // PS frame request

    initial begin
        $dumpfile("tests/output/o_buf_controller.vcd");
        $dumpvars;
        $from_myhdl(pclk, reset_n, i_data);
        $to_myhdl(vsync, hsync, vde, addr, o_data, req_line, req_frame);
    end

    o_buf_controller o_buf_controller (
        .pclk(pclk),
        .reset_n(reset_n),
        .i_data(i_data),
        .vsync(vsync),
        .hsync(hsync),
        .vde(vde),
        .addr(addr),
        .o_data(o_data),
        .req_line(req_line),
        .req_frame(req_frame)
    );

endmodule