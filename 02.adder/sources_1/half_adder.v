`timescale 1ns / 1ps

module half_adder(
    input wire a,
    input b, // 별도의 언급이 없으면 wire 1 bit 이다.
    output sum , carry_out
    );

    assign sum = a^b;
    assign carry_out =  a & b;
endmodule
