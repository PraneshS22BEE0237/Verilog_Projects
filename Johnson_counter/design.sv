//Pranesh S
//Johnson counter


module johnson_counter (
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0000;  // Reset all bits to 0
    else
        q <= {~q[0], q[3:1]};  // Shift right and complement q[0]
end

endmodule
