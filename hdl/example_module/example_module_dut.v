module example_module_dut;

reg         clk;
reg         reset;
wire [7:0]  d;

initial begin
    $from_myhdl(clk, reset);
    $to_myhdl(d);
    $display("Test message!");
end

example_module example_module_dut (.clk(clk), .reset(reset), .d(d));

endmodule
