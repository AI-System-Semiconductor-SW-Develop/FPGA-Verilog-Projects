`timescale 1ns / 1ps

module top_buzzer(
    input clk,
    input reset,
    input [6:0] btn,
    input sw,
    output [1:0] led,
    output buzzer
    );

    wire [6:0] w_btn;
    wire buzzer_melody;
    wire buzzer_poweron;

    btn_debouncer u_btn_debouncer(
        .clk(clk),
        .reset(reset),
        .noisy_btn(btn),
        .clean_btn(w_btn)
    );

    play_melody u_play_melody(
        .clk(clk),
        .reset(reset),
        .btn(w_btn),
        .led(led),
        .buzzer(buzzer_melody),
        .sw(sw)
    );   

    play_poweron_opendoor u_play_poweron_opendoor(
        .clk(clk),
        .reset(reset),
        .btn(w_btn),
        .led(led),
        .buzzer(buzzer_poweron),
        .sw(sw)        
    );

    assign buzzer = (sw == 0) ? buzzer_melody : buzzer_poweron;
endmodule
