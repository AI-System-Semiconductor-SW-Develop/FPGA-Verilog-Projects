`timescale 1ns / 1ps

module tb_gates();
    reg [2:0] i_a; // r_a변수는 1bit짜리 저장 메모리다.
    wire [5:0] o_led; //신호선이 다섯가닥 0~5 led[0]~led[5]

    // port 지정 : name port mapping 방식
    gates u_gates( // u_gates 이름으로 인스턴스를 생성
    .a(i_a),
    .led(o_led) //신호선이 다섯가닥 0~5 led[0]~led[5]
    );

    // a b 값 변환
    // 0 0
    // 0 1
    // 1 0
    // 1 1
    
    initial begin
        #00 i_a[0]=1'b0; i_a[1]=1'b0;
        #20 i_a[0]=1'b0; i_a[1]=1'b1;
        #20 i_a[0]=1'b1; i_a[1]=1'b0;
        #20 i_a[0]=1'b1; i_a[1]=1'b1;
        #20 $stop;
    end
endmodule
