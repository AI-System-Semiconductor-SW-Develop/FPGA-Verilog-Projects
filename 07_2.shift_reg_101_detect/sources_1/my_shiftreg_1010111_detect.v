`timescale 1ns / 1ps

module my_shiftreg_1010111_detect(
    input clk,
    input reset,
    input btn_press,
    input x,
    output [15:0] led
    );

    // 버튼을 눌렀다 뗀 순간만 shift

    reg [6:0] sr7;

    always @(posedge clk, posedge reset) begin
        if(reset) begin
            sr7 <= 7'b0000000;
        end else if (btn_press)
                    sr7 <= {sr7[5:0], x}; // shift register
    end

    assign led[6:0] = sr7;
    assign led[14:7] = 8'b0;
    assign led[15] = (sr7 == 7'b1010111) ? 1 : 0;
endmodule
