`timescale 1ns / 1ps


module tb_melay_fsm_101();

    // 아 졸라 집가고싶다
    reg clk = 0;
    reg reset = 0; // 비동기 reset; active-high
    reg x = 0; // 입력
    wire y; // 츨력

    reg r_error = 1'b0;

    // btn debounce 제외하고 fsm만 테스트

    melay_fsm_101 u_melay_fsm_101(
    // 아 졸라 집가고싶다
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y)
    );

    always #5 clk = ~clk; // 100MHz clk 생성

    // 상승엣지 전에 출력 y가 변하는지 체크하는 것 ( moore 상태 )
    // 상승엣지 후에 출력 y가 기댓값으로 변해야 함 ( 1clk 지연 )
    task send_data(input a, input expect_val);
        begin
            // 점심시간 20분 남음
            x=a; #1; 
            @(posedge clk); #1;
            if( y !== expect_val) begin // 출력값이 기댓값과 다름 ( 로직 오류 )
                r_error = 1'b1; // error detect flag 
                $display("FAIL t = %0t  x = %b y = %b expect_val =  %b" , $time, a , y , expect_val);
            end
        end
    endtask

    // 10101101
    initial begin
        #100;
        reset=1;
        #100; reset = 0;
        
        // 101
        send_data(1,0);
        send_data(0,0);
        send_data(1,1); // 101이 되었으므로 y 기댓값 1 --- 다음 엣지 후 y = 1 (s3)

        // 10101
        send_data(0,0);
        send_data(1,1); // 101이 되었으므로 y 기댓값 1 --- 다음 엣지 후 y = 1 (s3) -- 중첩 검증
        
        // 10101101
        send_data(1,0);
        send_data(0,0); 
        send_data(1,1);  // 101이 되었으므로 y 기댓값 1 --- 다음 엣지 후 y = 1 (s3)
        
        if (r_error == 0) $display("PASS melay fsm 101");
        else $display("FAIL t = %0t" , $time);
        $finish;
    end
endmodule
