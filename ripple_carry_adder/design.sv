module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

module ripple_carry_addr(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output carry
);
    wire [3:0] c; // Internal carry wires
    
    // Instantiate 4 full adders in series
    full_adder fa0(.a(a[0]), .b(b[0]), .cin(cin),  .sum(sum[0]), .cout(c[0]));
    full_adder fa1(.a(a[1]), .b(b[1]), .cin(c[0]), .sum(sum[1]), .cout(c[1]));
    full_adder fa2(.a(a[2]), .b(b[2]), .cin(c[1]), .sum(sum[2]), .cout(c[2]));
    full_adder fa3(.a(a[3]), .b(b[3]), .cin(c[2]), .sum(sum[3]), .cout(carry));
endmodule