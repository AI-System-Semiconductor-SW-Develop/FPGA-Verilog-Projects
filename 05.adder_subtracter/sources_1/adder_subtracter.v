`timescale 1ns / 1ps

module adder_subtracter(
    input add_nsub,
    input [3:0] a,
    input [3:0] b,
    output carry_out,
    output [3:0]sum
    );

    reg r_carry_out;
    reg [3:0] r_sum;

    always @(*) begin
        if(add_nsub == 1) {r_carry_out,r_sum} = a[3:0] + b[3:0];
        else {r_carry_out,r_sum} = a[3:0] + ~b[3:0] + 4'b1;
    end

    assign carry_out =  r_carry_out;
    assign sum = r_sum;
endmodule
