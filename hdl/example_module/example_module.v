module example_module (
    input               clk,
    input               reset,
    output reg [7:0]    count
);

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        $display("Reset");
        count <= 0;
    end else begin
        // Inc counter
        $display("Clk");
        $display("Count %d", count);
        count <= count + 1;
    end
end

endmodule