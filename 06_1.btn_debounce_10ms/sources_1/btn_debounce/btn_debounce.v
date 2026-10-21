`timescale 1ns / 1ps

module btn_debounce(
    input clk,
    input reset,
    input btnC,
    output clean_btn
    );

    wire w_clk;
    wire w_Q1;
    wire w_Q2, w_Q2_bar;

    clock_80hz u_clock_80hz(
        .clk(clk), //100메가
        .reset(reset),
        .oclk(w_clk) //80헤르츠
        );
    
    d_ff u1_d_ff (
        .clk(w_clk), //80HZ
        .reset(reset),
        .D(btnC),
        .Q(w_Q1)
        );

    d_ff u2_d_ff (
        .clk(w_clk), //80HZ
        .reset(reset),
        .D(w_Q1),
        .Q(w_Q2)
        );

    assign w_Q2_bar = ~w_Q2;
    assign clean_btn = w_Q1 & w_Q2_bar;

endmodule
