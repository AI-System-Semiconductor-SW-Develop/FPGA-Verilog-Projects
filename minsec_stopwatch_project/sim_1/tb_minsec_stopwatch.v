`timescale 1ns / 1ps

module tb_minsec_stopwatch();

    reg clk = 0;
    reg reset = 1;
    reg [2:0] btn = 0;

    wire [13:0] seg_data;
    wire [15:14] led;
    wire clock_dot;
    wire animation;

    main_controller dut (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .seg_data(seg_data),
        .led(led),
        .clock_dot(clock_dot),
        .animation(animation)
    );

    // 100MHz
    always #5 clk = ~clk;

    // 디바운싱이 끝난 버튼 입력을 가정
    task press_button;
        input [2:0] button;
        begin
            @(negedge clk); // 하강엣지 기다림
            btn = button; // 버튼 누름
            repeat (2) @(negedge clk); // 20ns 기다리고 버튼 놓음
            btn = 0;
        end
    endtask

    initial begin
        #30;
        reset = 0;

        // 시계 1초 도달
        dut.r_1sec_counter = 99_999_999;

        // 스톱워치 시작
        press_button(3'b001);

        // 스톱워치 10ms 도달
        dut.r_10ns_counter = 999_999;

        // 일시정지
        press_button(3'b100);

        // 무입력 3초 도달
        dut.r_idle_counter = 299_999_999;
        #100;

        // 재개
        press_button(3'b100);

        // 스톱워치 초기화
        press_button(3'b010);

        #100;
        $finish;
    end

endmodule