module example_module (
    input   clk,
    input   reset,
    output  d
);

reg count;

assign d = count;

always @(posedge clk) begin
    if (!reset) begin
        count <= 1'b0;
    end

    // Inc counter
    count <= count + 1'd1;
end

endmodule