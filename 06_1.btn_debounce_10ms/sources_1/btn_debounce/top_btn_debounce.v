`timescale 1ns / 1ps

module top_btn_debounce(
    input clk,
    input reset,
    input btnC,
    output [4:0]led
    );
    wire w_clean_btn;

    debouncer u_btn_debounce(
        .clk(clk),
        .reset(reset),
        .noisy_btn(btnC),
        .clean_btn(w_clean_btn)
    );

    led_fsm u_led_fsm (
        .clk(clk),
        .reset(reset),
        .clean_btn(w_clean_btn),
        .led(led)
    );

endmodule
