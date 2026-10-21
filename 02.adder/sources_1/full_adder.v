`timescale 1ns / 1ps

module full_adder(
    input a, b, carry_in, // 별도의 언급이 없으면 wire 1 bit 이다.
    output sum , carry_out
    );
    
    wire w_sum1, w_carry_out1;

    half_adder u1_half_adder(
        .a(a), 
        .b(b),
        .sum(w_sum1),
        .carry_out(w_carry_out1)
    );

    wire w_carry_out2;
     
    half_adder u2_half_adder(
        .a(w_sum1), 
        .b(carry_in),
        .sum(sum),
        .carry_out(w_carry_out2)
    );

    assign carry_out = w_carry_out1 | w_carry_out2;
endmodule
