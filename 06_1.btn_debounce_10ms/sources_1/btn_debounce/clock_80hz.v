`timescale 1ns / 1ps

module clock_80hz #(
    parameter DIV = 1_250_000 // default 값 : 80Hz -> 시물레이션 TEST bench 에서 값을 작은 값으로 지정 ( overriding )
                             // 외부에서 값을 지정을 하지 않으면 현재 값으로 동작
)   (
    input clk, //100메가 헤르츠
    input reset, //sw15번
    output reg oclk
    );

    //reg[23:0]r_counter=0; // 1,250,000 : 10ns x 1,250,000 = 12.5ms
    // log2(8) : 8은 2의 몇제곱이냐 3제곱 1000 : reg [3:0] r_counter
    reg[$clog2(DIV)-1:0]r_counter=0; // 1,250,000 : 10ns x 1,250,000 = 12.5ms
    // 10ns의 clk이 상승엣지 거나 reset신호가 오면 항상 수행한다.
    always @(posedge clk, posedge reset) begin
        if (reset) begin //비동기 reset 0 --> 1
        oclk <= 0;
        r_counter <= 0;
        end else begin 
            if (r_counter == (DIV/2)-1) begin //_는 숫자를 읽기 쉽게 구분한 거임 (1250000과 같음) 625,000을 세는 거임.
                r_counter <= 0;
                oclk <= ~oclk;
            end else begin 
                r_counter <= r_counter + 1; 
            end
        end
    end
endmodule
