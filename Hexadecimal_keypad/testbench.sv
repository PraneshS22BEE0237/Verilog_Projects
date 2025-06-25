`timescale 1ns / 1ps

module test_Hex_Keypad ();
    wire [3:0] Code;
    wire Valid;
    wire [3:0] Col;
    wire [3:0] Row;
    reg clock, reset;
    reg [15:0] Key;
    reg [39:0] Pressed;
    
    // Key name parameters
    parameter [39:0] Key_0 = "Key_0";
    parameter [39:0] Key_1 = "Key_1";
    parameter [39:0] Key_2 = "Key_2";
    parameter [39:0] Key_3 = "Key_3";
    parameter [39:0] Key_4 = "Key_4";
    parameter [39:0] Key_5 = "Key_5";
    parameter [39:0] Key_6 = "Key_6";
    parameter [39:0] Key_7 = "Key_7";
    parameter [39:0] Key_8 = "Key_8";
    parameter [39:0] Key_9 = "Key_9";
    parameter [39:0] Key_A = "Key_A"; 
    parameter [39:0] Key_B = "Key_B";
    parameter [39:0] Key_C = "Key_C"; 
    parameter [39:0] Key_D = "Key_D"; 
    parameter [39:0] Key_E = "Key_E";
    parameter [39:0] Key_F = "Key_F";
    parameter [39:0] None = "None";
    
    integer j, k;
    
    // Key press decoder
    always @(Key) begin
        case (Key)
            16'h0000: Pressed = None;
            16'h0001: Pressed = Key_0;
            16'h0002: Pressed = Key_1;
            16'h0004: Pressed = Key_2;
            16'h0008: Pressed = Key_3;
            16'h0010: Pressed = Key_4;
            16'h0020: Pressed = Key_5;
            16'h0040: Pressed = Key_6;
            16'h0080: Pressed = Key_7;
            16'h0100: Pressed = Key_8;
            16'h0200: Pressed = Key_9;
            16'h0400: Pressed = Key_A;
            16'h0800: Pressed = Key_B;
            16'h1000: Pressed = Key_C;
            16'h2000: Pressed = Key_D;
            16'h4000: Pressed = Key_E;
            16'h8000: Pressed = Key_F;
            default: Pressed = None;
        endcase
    end
    
    // Module instantiations
    Hex_Keypad_Grayhill_072 M1(Row, S_Row, clock, reset, Code, Valid, Col);
    Row_Signal M2(Key, Col, Row);
    Synchronizer M3(Row, clock, reset, S_Row);
    
    // VCD Dump setup
    initial begin
        $dumpfile("hex_keypad_waveform.vcd");  // Waveform output file
        $dumpvars(0, test_Hex_Keypad);        // Dump all variables
    end
    
    // Simulation control
    initial #2000 $finish;
    initial begin clock = 0; forever #5 clock = ~clock; end
    initial begin reset = 1; #10 reset = 0; end
    
    // Test sequence
    initial begin
        for (k = 0; k <= 1; k = k+1) begin 
            Key = 0;
            #20;
            for (j = 0; j <= 15; j = j+1) begin
                #20 Key = (1 << j);  // One-hot encoding
                #60 Key = 0;         // Release key
            end 
        end 
    end
endmodule