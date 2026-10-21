`timescale 1ns / 1ps

module my_tick_generator #(
    parameter DIV = 100_000
)(
    input clk,
    input reset,
    output reg tick
);

    reg [$clog2(DIV)-1:0] r_counter = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_counter <= 0;
            tick <= 0;
        end
        else begin
            if (r_counter == DIV - 1) begin
                r_counter <= 0;
                tick <= 1;
            end
            else begin
                r_counter <= r_counter + 1;
                tick <= 0;
            end
        end
    end

endmodule