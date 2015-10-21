/* 
 * example_module_dut.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 21st October 2015
 *
 * DUT module for example_module.v. Essentially this is a thin wrapper around
 * the design under test which exposes the IO ports to MyHDL.
 */

module example_module_dut;

reg         clk;
reg         reset;
wire [7:0]  count;

initial begin
    $dumpfile("tests/example_module.vcd");
    $dumpvars;
    $from_myhdl(clk, reset);
    $to_myhdl(count);
    $display("Verilog DUT wrapper starting...");
end

example_module example_module (.clk(clk), .reset(reset), .count(count));

endmodule
