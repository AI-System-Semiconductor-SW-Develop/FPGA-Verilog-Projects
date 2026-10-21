`timescale 1ns / 1ps

module tb_btn_debounce();

    parameter CLK_FREQ = 1000_000_000; // 100KMHz
    parameter CLK_PERIOD = 10; // 10ns (100MHz의 1주기)

    // 시물레이션 시간 비 조정
    // 실제 동작 분주비 : DIV = 1_250_000 => 1주기 12.5ms (80Hz)
    // 시물레이션 용 분주비 : DIV = 100 -> 1주기 1us ( 1MHz ) ---> 실제 보드 동작 비보다 12,500 배 단축
    parameter SIMULATION_DIV = 100; // 1MHz
    localparam  SAMPLE_PREIOD = SIMULATION_DIV * CLK_PERIOD; // 1000ns ===> 1us
    // 버튼을 누르고 있는 시간을 정한다 (simulation 시)
    // sample clk 3주기 동안 누르고 있다고 설정
    parameter BTN_PRESS_LIMIT = SAMPLE_PREIOD * 3; // 3,000 ns 

    // clock 80Hz 분주비를 시뮬레이션용 분주비 값으로 덮어 쓴다.
    defparam top_btn_debounce.u_btn_debounce.u_clock_80hz.DIV = SIMULATION_DIV;

    reg clk;
    reg reset;
    reg btnC;
    wire led;

    top_btn_debounce u_top_btn_debounce(
        .clk(clk),
        .reset(reset),
        .btnC(btnC),
        .led(led)
    ); 

    initial begin
        clk=0;
        forever begin
            #(CLK_PERIOD/2); clk = ~clk; // 100MHz clk 생성

        end
    end                                                    

    initial begin
        reset = 1;
        btnC = 0;
        #100;
        reset=0;
        // btn input
        $display("[%0t] start noise sig generation .........", $time);
        #100; btnC=1;
        #200; btnC=0;
        #300; btnC=1;
        #120; btnC=0;
        #500; // 쓰레기 noise

        btnC=1;
        #(BTN_PRESS_LIMIT); // 3us (3주기)
        #100;
        if (led == 1) begin
            $display("[%0t] SIMULATION TEST PASSED! ..........",$time);
        end else begin
            $display("[%0t] SIMULATION TEST FAILED! ..........",$time);
        end
        #1000;
        $display("[%0t] SIMULATION TEST FINISH! ..........",$time);
        $finish;
    end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
endmodule
