`timescale 1ns / 1ps

module my_led_toggle(
    input clk,
    input reset,
    input btn,
    output reg led
);

    reg btn_prev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_prev <= 0;
            led <= 0;
        end
        else begin
            btn_prev <= btn;

            if (btn && !btn_prev)
                led <= ~led;
        end
    end

endmodule