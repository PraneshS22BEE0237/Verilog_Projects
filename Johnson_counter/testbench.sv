//Pranesh S
//Johnson counter

module tb_johnson_counter;

reg clk;
reg reset;
wire [3:0] q;

johnson_counter uut (
    .clk(clk),
    .reset(reset),
    .q(q)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10-unit period
end

// Stimulus
initial begin
    reset = 1; #10;
    reset = 0;

    #100;
    $finish;
end

// Display output in terminal
initial begin
    $monitor("Time=%0t | q=%b", $time, q);
end

// Dumpfile for GTKWave
initial begin
    $dumpfile("johnson_counter.vcd"); // Name of the VCD file
    $dumpvars(0, tb_johnson_counter); // Dump all signals in this testbench
end

endmodule
