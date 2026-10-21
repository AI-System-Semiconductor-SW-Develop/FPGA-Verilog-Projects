`timescale 1ns / 1ps

module mux4bit(a , b, sel, out , led);
    input [3:0] a, b;
    input sel;
    output[3:0] out;
    output[7:0] led;
    reg [3:0] out;

    assign led[3:0] = a;
    assign led[7:4] = b;
    
    always @(sel,a,b) begin
        case(sel)
        1'b1: out = a;
        1'b0: out = b;
        endcase
    end
endmodule
