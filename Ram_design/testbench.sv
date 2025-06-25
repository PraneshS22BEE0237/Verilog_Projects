module RAM_TB;
    reg clk, we;
    reg [3:0] addr;
    reg [7:0] data_in;
    wire [7:0] data_out;

    // Instantiate RAM
    RAM uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Generate VCD file
    initial begin
        $dumpfile("ram_waveform.vcd");  // Output VCD file
        $dumpvars(0, RAM_TB);          // Dump all variables
    end

    initial begin
        clk = 0; we = 0; addr = 0; data_in = 0;
        
        // Write data
        we = 1;
        addr = 4'b0001; data_in = 8'hAA; #10;
        addr = 4'b0010; data_in = 8'h55; #10;
        we = 0;

        // Read data
        addr = 4'b0001; #10;
        addr = 4'b0010; #10;
        $finish;
    end
endmodule