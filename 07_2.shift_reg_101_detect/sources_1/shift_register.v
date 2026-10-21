`timescale 1ns / 1ps

module shift_register(
    input clk,
    input reset,
    input btn_press,
    input x,
    output [15:0] led
    );

    // 버튼을 눌렀다 뗀 순간만 shift

    reg [2:0] sr3;

    always @(posedge clk, posedge reset) begin
        if(reset) begin
            sr3 <= 3'b000;
        end else if (btn_press)
                    sr3 <= {sr3[1:0], x}; // shift register
    end

    assign led[2:0] = sr3;
    assign led[14:3] = 12'b0;
    assign led[15] = (sr3 == 3'b101) ? 1 : 0;
endmodule
