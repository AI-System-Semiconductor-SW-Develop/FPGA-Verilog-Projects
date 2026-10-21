`timescale 1ns / 1ps

module my_btn_debounce(
    input clk,
    input reset,
    input tick,
    input btn,
    output clean_btn
);

    reg [3:0] count = 0;
    reg btn_stable = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            btn_stable <= 0;
        end
        else if (tick) begin
            if (btn == btn_stable) begin
                count <= 0;
            end
            else if (count == 9) begin
                btn_stable <= btn;
                count <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    assign clean_btn = btn_stable;

endmodule