`timescale 1ns / 1ps

module tb_led_fsm();

    reg clk = 0;
    reg reset = 0;
    reg clean_btn = 0;

    wire [4:0] led;

    reg r_error = 1'b0;

    // debounce 제외하고 FSM만 테스트
    led_fsm u_led_fsm(
        .clk(clk),
        .reset(reset),
        .clean_btn(clean_btn),
        .led(led)
    );

    always #5 clk = ~clk; // 100MHz clk 생성

    // 버튼을 한 번 누르고 LED 결과 확인
    task send_data(input [4:0] expect_val);
        begin
            @(negedge clk);
            clean_btn = 1;

            @(posedge clk); #1;

            if (led !== expect_val) begin
                r_error = 1'b1;
                $display("FAIL t=%0t led=%b expect=%b", $time, led, expect_val);
            end

            @(negedge clk);
            clean_btn = 0;

            @(posedge clk); #1;
        end
    endtask

    initial begin
        #100;
        reset = 1;
        #100;
        reset = 0;

        // 초기 LED0
        #1;
        if (led !== 5'b00001)
            r_error = 1'b1;

        // 정방향
        send_data(5'b00010); // LED1
        send_data(5'b00100); // LED2
        send_data(5'b01000); // LED3

        // 역방향 (LED4 ON)
        send_data(5'b10100); // LED4 + LED2
        send_data(5'b10010); // LED4 + LED1
        send_data(5'b10001); // LED4 + LED0

        // 다시 정방향
        send_data(5'b00010); // LED1
        send_data(5'b00100); // LED2

        if (r_error == 0)
            $display("PASS melay FSM");
        else
            $display("FAIL melay FSM");

        $finish;
    end

endmodule
