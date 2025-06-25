//Pranesh S
//ROM Design

module ROM_TB;
    reg [3:0] addr;
    wire [7:0] data_out;

    // Instantiate ROM
    ROM uut (
        .addr(addr),
        .data_out(data_out)
    );

    // Generate VCD file
    initial begin
        $dumpfile("rom_waveform.vcd");  // Output VCD file
        $dumpvars(0, ROM_TB);          // Dump all variables
    end

    initial begin
        // Read ROM contents
        for (integer i = 0; i < 8; i = i + 1) begin
            addr = i; #10;
        end
        $finish;
    end
endmodule
