`timescale 1ns / 1ps

module tb_buzzer;

    reg clk = 0;
    reg reset = 1;
    reg [6:0] btn = 7'b1100000; // 외부 풀업 버튼 5, 6은 기본 1
    reg sw = 0;

    wire [1:0] led;
    wire buzzer;

    top_buzzer dut (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .sw(sw),
        .led(led),
        .buzzer(buzzer)
    );

    always #5 clk = ~clk; // 100 MHz

    initial begin
        #100;
        reset = 0;

        // sw=0: 일반 음계, 왼쪽 버튼 100 ms 누르기
        #100;
        btn[1] = 1;
        #100_000_000;
        btn[1] = 0;
        #100_000_000;

        // sw=1: 왼쪽 버튼 한 번 누르고 멜로디 완료 대기
        sw = 1;
        #100;
        btn[1] = 1;
        #100_000_000;
        btn[1] = 0;
        #300_000_000;

        // sw=0: 일반 음계로 다시 돌아오는지 확인
        sw = 0;
        #100;
        btn[1] = 1;
        #100_000_000;
        btn[1] = 0;
        #100_000_000;

        $finish;
    end

endmodule
