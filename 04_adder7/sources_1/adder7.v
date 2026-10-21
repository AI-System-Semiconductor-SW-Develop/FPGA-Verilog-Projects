`timescale 1ns / 1ps

module adder7(
    input [6:0] a,
    input [6:0] b,
    input carry_in,
    output [6:0] sum,
    output carry_out
);

    wire c0, c1, c2, c3, c4, c5;

    full_adder u0 (
        .a(a[0]),
        .b(b[0]),
        .carry_in(carry_in),
        .sum(sum[0]),
        .carry_out(c0)
    );

    full_adder u1 (
        .a(a[1]),
        .b(b[1]),
        .carry_in(c0),
        .sum(sum[1]),
        .carry_out(c1)
    );

    full_adder u2 (
        .a(a[2]),
        .b(b[2]),
        .carry_in(c1),
        .sum(sum[2]),
        .carry_out(c2)
    );

    full_adder u3 (
        .a(a[3]),
        .b(b[3]),
        .carry_in(c2),
        .sum(sum[3]),
        .carry_out(c3)
    );

    full_adder u4 (
        .a(a[4]),
        .b(b[4]),
        .carry_in(c3),
        .sum(sum[4]),
        .carry_out(c4)
    );

    full_adder u5 (
        .a(a[5]),
        .b(b[5]),
        .carry_in(c4),
        .sum(sum[5]),
        .carry_out(c5)
    );

    full_adder u6 (
        .a(a[6]),
        .b(b[6]),
        .carry_in(c5),
        .sum(sum[6]),
        .carry_out(carry_out)
    );

endmodule
