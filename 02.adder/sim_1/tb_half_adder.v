`timescale 1ns / 1ps

module tb_half_adder();

    reg i_a;
    reg i_b; 
    wire o_sum , o_carry_out;

    half_adder u_half_adder
    (
        .a(i_a),
        .b(i_b),
        .sum(o_sum),
        .carry_out(o_carry_out)
    );

    // a b
    // 0 0
    // 0 1
    // 1 0
    // 1 1

    initial begin
        #00 i_a = 1'b0; i_b = 1'b0;
        #10 i_a = 1'b0; i_b = 1'b1;
        #10 i_a = 1'b0; i_b = 1'b1;
        #10 i_a = 1'b1; i_b = 1'b0;
        #10 i_a = 1'b1; i_b = 1'b1;
    end
endmodule
