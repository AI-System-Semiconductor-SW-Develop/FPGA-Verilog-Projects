`timescale 1ns / 1ps

module top_my_btn_debounce(
    input clk,
    input reset,
    input btnU,
    input btnD,
    input sel,
    output clean_btn,
    output [2:0] led
);

    wire w_tick;
    wire w_btn;
    wire w_clean_btn;
    wire w_led;

    assign w_btn = sel ? btnU : btnD;

    my_tick_generator u_my_tick_generator(
        .clk(clk),
        .reset(reset),
        .tick(w_tick)
    );

    my_btn_debounce u_my_btn_debounce(
        .clk(clk),
        .reset(reset),
        .tick(w_tick),
        .btn(w_btn),
        .clean_btn(w_clean_btn)
    );

    my_led_toggle u_my_led_toggle(
        .clk(clk),
        .reset(reset),
        .btn(w_clean_btn),
        .led(w_led)
    );

    // 5. LED 출력
    assign clean_btn = w_clean_btn;
    assign led[0] = w_clean_btn;
    assign led[1] = 1'b0;
    assign led[2] = w_led;

endmodule