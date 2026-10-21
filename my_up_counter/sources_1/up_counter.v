`timescale 1ns / 1ps

module up_counter(
    input [1:0]clean_btn,
    input clk,
    input reset,
    output reg [15:0] led
    );

    reg [19:0] count = 0;
    reg [15:0] r_up_counter = 0;

    // 1이면 RUN 0이면 STOP
    reg state = 1;

    reg prev_btnU = 0;
    reg prev_btnD = 0;

    always @(posedge clk or posedge reset) begin
            if (reset) begin
            state <= 1;
            count <= 0;
            prev_btnU <= 0;
            prev_btnD <= 0;
            r_up_counter <= 0;
            led <= 0;
        end
            else begin
            prev_btnU <= clean_btn[0];
            prev_btnD <= clean_btn[1];
            
            if (state == 1) begin
                if (clean_btn[0] && !prev_btnU) begin
                    state <= 0;
                end
                if (count == 999_999) begin
                    count <= 0;
                    r_up_counter <= r_up_counter+1;
                    led <= led+1;
                end
            else begin
                    count <= count + 1;
                end
            end
            else begin
                count <= 0;
                if (clean_btn[0] && !prev_btnU) begin
                    state <= 1;
                end

                else if (clean_btn[1] && !prev_btnD) begin
                count <= 0;
                led <= 0;
                r_up_counter <= 0;
            end
            end
            end
    end
endmodule
