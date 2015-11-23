/* 
 * ov7670_init_dut.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 23rd November 2015
 *
 * Instantiates ov7670_init module for testing.
 */

module ov7670_init_dut;

    reg         clk,        // Core clock
    reg         reset_n,    // Synchronous reset
    reg         continue,   // Continue with register intialisation
    wire [15:0] data,       // Register address and value for SCCB
    wire        done,       // Register initialisation finished

    initial begin
        $dumpfile("tests/output/ov7670_init.vcd");
        $dumpvars;
        $from_myhdl(clk, reset_n);
        $to_myhdl(data, done);
    end

    ov7670_init ov7670_init (
        .clk(clk),
        .reset_n(reset_n),
        .continue(continue),
        .data(data),
        .done(done)
    );

endmodule