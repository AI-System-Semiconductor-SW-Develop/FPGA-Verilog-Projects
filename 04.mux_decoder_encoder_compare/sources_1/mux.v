`timescale 1ns / 1ps

module mux2_1(a,b,sel,out);
    input a, b, sel;
    output out;
    
    reg r_out; // 내부변수 선언
        always @(sel,a,b) 
        begin
            case(sel)
                1'b1 : r_out = a;
                1'b0 : r_out = b;
                default: r_out = 1'bx; // bx: unknown
            endcase
        end

        assign out = r_out; //점퍼선으로 레그 값 연결
endmodule
