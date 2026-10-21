`timescale 1ns / 1ps

module top_melay_fsm_101(
    input clk,
    input reset,
    input btnU,
    input btnD,
    output reg led
);

wire w_clean_btnU;
wire w_clean_btnD;
wire w_y;    
wire w_btn_event;

debouncer u_btn_debounce_U(
    .clk(clk),
    .reset(reset),
    .noisy_btn(btnU),
    .clean_btn(w_clean_btnU)
);

debouncer u_btn_debounce_D(
    .clk(clk),
    .reset(reset),
    .noisy_btn(btnD),
    .clean_btn(w_clean_btnD)
);

melay_fsm_101 u_melay_fsm_101(
    .clk(clk),
    .reset(reset),
    .x1(w_clean_btnU),
    .x2(w_clean_btnD),
    .y(w_y),
    .btn_event(w_btn_event)
);

always @(posedge clk or posedge reset) begin
    if(reset) led <= 1'b0;
    else if (w_y) led <= 1'b1;
    else if (w_btn_event) led <= 1'b0;
end
endmodule
