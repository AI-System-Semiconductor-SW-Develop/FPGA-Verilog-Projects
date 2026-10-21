`timescale 1ns / 1ps

module btn_debounce(
    input clk,        // 100MHz
    input reset,
    input btn,
    output clean_btn
);

    reg [19:0] count = 0;
    reg btn_stable = 0;

    // 100MHz에서 10ms = 1,000,000클럭
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            btn_stable <= 0;
        end
        else begin
            if (btn == btn_stable) begin
                count <= 0;
            end
            else if (count == 999_999) begin
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