`timescale 1ns/1ps

module tb_ripple_carry();
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire carry;
    
    // Instantiate the Unit Under Test (UUT)
    ripple_carry_addr uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry(carry)
    );
    
    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;
        cin = 0;
        
        // Wait 100 ns for global reset to finish
        #100;
        
        // Add stimulus here
        $display("Time\t a\t b\t cin\t|\t sum\t carry");
        $display("------------------------------------------------");
        
        // Test case 1: 0 + 5 + 0
        a = 4'b0000; b = 4'b0101; cin = 0;
        #10;
        $display("%0t\t %b\t %b\t %b\t|\t %b\t %b", $time, a, b, cin, sum, carry);
        
        // Test case 2: 6 + 5 + 1
        a = 4'b0110; b = 4'b0101; cin = 1;
        #10;
        $display("%0t\t %b\t %b\t %b\t|\t %b\t %b", $time, a, b, cin, sum, carry);
        
        // Test case 3: 6 + 15 + 0
        a = 4'b0110; b = 4'b1111; cin = 0;
        #10;
        $display("%0t\t %b\t %b\t %b\t|\t %b\t %b", $time, a, b, cin, sum, carry);
        
        // Test case 4: 15 + 15 + 1
        a = 4'b1111; b = 4'b1111; cin = 1;
        #10;
        $display("%0t\t %b\t %b\t %b\t|\t %b\t %b", $time, a, b, cin, sum, carry);
        
        // Additional test cases
        // Test case 5: 8 + 7 + 0
        a = 4'b1000; b = 4'b0111; cin = 0;
        #10;
        $display("%0t\t %b\t %b\t %b\t|\t %b\t %b", $time, a, b, cin, sum, carry);
        
        $finish;
    end
    
    // Generate waveform file
    initial begin
        $dumpfile("ripple_carry_waveform.vcd");
        $dumpvars(0, tb_ripple_carry);
    end
endmodule