
`timescale 1ns / 1ps

module tb_top_my_btn_debounce();

    parameter CLK_PERIOD = 10;  // 100MHz = 10ns

    // 시뮬레이션 시간 단축
    // 실제 DIV = 100_000 (1ms)
    // 시뮬레이션 DIV = 100 (1us)
    parameter SIMULATION_DIV = 100;

    localparam SAMPLE_PERIOD = SIMULATION_DIV * CLK_PERIOD;

    // 디바운싱 10주기 이상 유지
    parameter BTN_PRESS_LIMIT = SAMPLE_PERIOD * 15;

    reg clk;
    reg reset;
    reg btnU;
    reg btnD;
    reg sel;

    wire clean_btn;
    wire [2:0] led;

    // TOP 모듈 연결
    top_my_btn_debounce u_top_my_btn_debounce(
        .clk(clk),
        .reset(reset),
        .btnU(btnU),
        .btnD(btnD),
        .sel(sel),
        .clean_btn(clean_btn),
        .led(led)
    );

    // tick_generator 분주비 변경
    defparam u_top_my_btn_debounce.u_my_tick_generator.DIV
             = SIMULATION_DIV;

    // 100MHz 클럭 생성
    initial begin
        clk = 0;
        forever begin
            #(CLK_PERIOD/2);
            clk = ~clk;
        end
    end

    initial begin
        reset = 1;
        btnU = 0;
        btnD = 0;
        sel = 1;  // btnU 선택

        #100;
        reset = 0;

        // 1. 버튼 노이즈 발생
        $display("[%0t] btnU NOISE TEST START", $time);

        #100; btnU = 1;
        #200; btnU = 0;
        #300; btnU = 1;
        #120; btnU = 0;
        #500;

        // 노이즈가 제거되었는지 확인
        if (clean_btn == 0 && led[0] == 0)
            $display("[%0t] NOISE TEST PASSED!", $time);
        else
            $display("[%0t] NOISE TEST FAILED!", $time);

        // 2. 첫 번째 버튼 누르기
        $display("[%0t] FIRST PRESS START", $time);

        btnU = 1;
        #(BTN_PRESS_LIMIT);

        if (clean_btn == 1 &&
            led[0] == 1 &&
            led[2] == 1)
            $display("[%0t] FIRST PRESS PASSED!", $time);
        else
            $display("[%0t] FIRST PRESS FAILED!", $time);

        // 3. 버튼 떼기
        btnU = 0;
        #(BTN_PRESS_LIMIT);

        if (clean_btn == 0 &&
            led[0] == 0 &&
            led[2] == 1)
            $display("[%0t] RELEASE TEST PASSED!", $time);
        else
            $display("[%0t] RELEASE TEST FAILED!", $time);

        // 4. 두 번째 버튼 누르기
        $display("[%0t] SECOND PRESS START", $time);

        btnU = 1;
        #(BTN_PRESS_LIMIT);

        if (clean_btn == 1 &&
            led[0] == 1 &&
            led[2] == 0)
            $display("[%0t] SECOND PRESS PASSED!", $time);
        else
            $display("[%0t] SECOND PRESS FAILED!", $time);

        // 5. 버튼 떼기
        btnU = 0;
        #(BTN_PRESS_LIMIT);

        if (clean_btn == 0 &&
            led[0] == 0 &&
            led[2] == 0)
            $display("[%0t] FINAL RELEASE PASSED!", $time);
        else
            $display("[%0t] FINAL RELEASE FAILED!", $time);

        #1000;
        $display("[%0t] SIMULATION TEST FINISH!", $time);
        $finish;
    end

endmodule
