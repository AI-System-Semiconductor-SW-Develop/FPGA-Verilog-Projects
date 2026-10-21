`timescale 1ns / 1ps

module tb_adder7;

    reg [6:0] a;
    reg [6:0] b;
    reg carry_in;

    wire [6:0] sum;
    wire carry_out;

    // DUT
    adder7 uut (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

initial begin

    // 0 + 0 = 0
    a = 7'b0000000;
    b = 7'b0000000;
    carry_in = 0;
    #10;

    // 1 + 1 = 2
    a = 7'b0000001;
    b = 7'b0000001;
    carry_in = 0;
    #10;

    // 15 + 10 = 25
    a = 7'b0001111;
    b = 7'b0001010;
    carry_in = 0;
    #10;

    // 63 + 1 = 64
    a = 7'b0111111;
    b = 7'b0000001;
    carry_in = 0;
    #10;

    // 127 + 1 = 128
    a = 7'b1111111;
    b = 7'b0000001;
    carry_in = 0;
    #10;

    // 100 + 50 + 1 = 151
    a = 7'b1100100;
    b = 7'b0110010;
    carry_in = 1;
    #10;

    $finish;
end

endmodule