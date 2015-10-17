module example_module_dut;

reg clk;
reg reset;
wire d;

initial begin
    $from_myhdl(clk);
    $from_myhdl(reset);
    $to_myhdl(d);
end

example_module_dut example_module_dut (.clk(clk), .reset(reset), .d(d));

endmodule