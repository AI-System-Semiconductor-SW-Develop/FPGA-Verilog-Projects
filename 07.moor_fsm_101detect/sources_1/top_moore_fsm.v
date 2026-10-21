`timescale 1ns / 1ps

module top_moore_fsm(
    // 아 졸라 집가고싶다
    input clk,
    input reset, // 비동기 reset, active-high
    input btnU,
    input btnD,
    output led
    );

    wire w_clean_btnU;
    wire w_clean_btnD;    

    debouncer u_btn_debouncer_U(
        .clk(clk),
        .reset(reset),
        .noisy_btn(btnU), // raw noisy button input
        .clean_btn(w_clean_btnU)
    );

    debouncer u_btn_debouncer_D(
        .clk(clk),
        .reset(reset),
        .noisy_btn(btnD), // raw noisy button input
        .clean_btn(w_clean_btnD)
    );

    moor_fsm_101 u_moor_fsm_101(
        .clk(clk),
        .reset(reset),
        .x2(w_clean_btnD),
        .x1(w_clean_btnU),
        .y(led)
    );

endmodule
