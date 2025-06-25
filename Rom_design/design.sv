//Pranesh S
//ROM Design


module ROM #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4  // 2^4 = 16 locations
)(
    input wire [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data_out
);

// Preloaded ROM data (e.g., Fibonacci sequence)
reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

initial begin
    mem[0] = 8'h00; mem[1] = 8'h01;
    mem[2] = 8'h01; mem[3] = 8'h02;
    mem[4] = 8'h03; mem[5] = 8'h05;
    mem[6] = 8'h08; mem[7] = 8'h0D;
    // Fill remaining with zeros
    for (integer i = 8; i < (1<<ADDR_WIDTH); i = i + 1)
        mem[i] = 8'h00;
end

// Read logic (combinational)
always @(*) begin
    data_out = mem[addr];
end

endmodule
