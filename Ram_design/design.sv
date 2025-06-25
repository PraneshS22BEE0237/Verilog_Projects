module RAM #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4  // 2^4 = 16 locations
)(
    input wire clk,
    input wire we,            // Write enable (1=write, 0=read)
    input wire [ADDR_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out
);

// Memory array
reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

// Read/Write logic
always @(posedge clk) begin
    if (we)
        mem[addr] <= data_in; // Write operation
    data_out <= mem[addr];    // Read operation (synchronous)
end

endmodule