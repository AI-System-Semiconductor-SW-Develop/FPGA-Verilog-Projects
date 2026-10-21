`timescale 1ns / 1ps

module tb_mux2_1();
    // 입력 신호는 reg , 출력 신호는 wire로 선언
    reg a,b,sel;
    wire out;

    // 검증할 모듈(DUT(Design Under Test))을 인스턴스화
    mux2_1 u_mux2_1(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
        );

        // test 시나리오 작성
        initial begin
            
            // 초기값 설정
            a = 0; b = 0; sel = 0;
            
            // 결과 화면 출력
            $monitor("Time=%0t | sel=%b | a=%b | b=%b| out=%b", $time, sel, a, b, out);
            
            // 시뮬레이터 조건

            // sel = 0 일 때, b가 출력 되어야 함.
            #10; sel = 0; a = 1; b = 0; // out은 b = 0 이 되어야 함.
            #10; sel = 0; a = 0; b = 1; // out은 b = 1 이 되어야 함.

            // sel = 1 일 때, a가 출력 되어야 함.
            #10; sel = 1; a = 0; b = 1; // out은 a = 0 이 되어야 함.
            #10; sel = 1; a = 1; b = 0; // out은 a = 1 이 되어야 함.

            // 추가적인 조합
            #10; sel = 0; a = 1; b = 1; // out은 b = 1 이 되어야 함.
            #10; sel = 1; a = 1; b = 1; // out은 a = 1 이 되어야 함.
            
            // 종료
            #10; $finish;
        
        end

endmodule
