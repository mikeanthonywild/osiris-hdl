module example_module (
    input           clk,
    input           reset,
    output [7:0]    d
);

reg [7:0]   count;

assign d = count;

always @(posedge clk) begin
    if (!reset) begin
        count <= 1'b0;
    end else begin
        // Inc counter
        $display("Clk");
        count <= count + 1'd1;
    end
end

endmodule