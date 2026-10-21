`timescale 1ns / 1ps

module top_my_up_counter(
    input clk,
    input reset,
    input btnU,
    input btnD,
    output [15:0]led
    );

    wire [1:0] w_clean_btn;

    btn_debounce u_btn_debounce_U(
        .clk(clk),
        .reset(reset),
        .btn(btnU),
        .clean_btn(w_clean_btn[0])
    );

    btn_debounce u_btn_debounce_D(
        .clk(clk),
        .reset(reset),
        .btn(btnD),
        .clean_btn(w_clean_btn[1])
    );

    up_counter u_up_counter(
        .clk(clk),
        .reset(reset),
        .clean_btn(w_clean_btn),
        .led(led)
    );
endmodule
