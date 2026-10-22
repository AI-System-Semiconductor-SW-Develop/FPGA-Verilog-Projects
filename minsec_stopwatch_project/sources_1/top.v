`timescale 1ns / 1ps

module top(
    input clk,
    input reset,
    input [2:0]btn,
    output [7:0]seg,
    output [3:0]an,
    output [15:14]led
);

wire clock_dot;
wire w_animation;
wire [2:0] w_clean_btn;
wire [13:0] w_seg_data; // FND에 max 9999의 bin값 표시
wire w_tick;

// 집가고싶다
btn_debouncer u_btn_debouncer(
    .clk(clk),
    .reset(reset),
    .noisy_btn(btn),
    .clean_btn(w_clean_btn)
);

main_controller u_main_controller(
    .clk(clk),
    .reset(reset), //sw[15]
    .btn(w_clean_btn),
    .seg_data(w_seg_data),
    .led(led),
    .clock_dot(clock_dot),
    .animation(w_animation)    
);

tick_generator u_tick_generator(
    .clk(clk),
    .reset(reset), //sw[15]
    .tick(w_tick)
);

fnd_controller u_fnd_controller(
    .clk(clk),
    .reset(reset), //sw[15]
    .tick(w_tick),
    .an(an),
    .seg(seg),
    .in_data(w_seg_data),
    .clock_dot(clock_dot),
    .animation(w_animation)  
);


endmodule
