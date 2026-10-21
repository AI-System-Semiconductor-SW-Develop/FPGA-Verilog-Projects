`timescale 1ns / 1ps

module tb_shift_register();

    reg clk = 0;
    reg reset = 0;
    reg btn_press = 0;
    reg x = 0;

    wire [15:0] led;

    // 인스턴스 생성
    my_shiftreg_1010111_detect  uut(
        .clk(clk),
        .reset(reset),
        .btn_press(btn_press),
        .x(x),
        .led(led)
    );
    
    // clk 설정
    always #5 clk = ~clk;  // 100MHz

    // 데이터 1비트 입력
    task send_data(input data);
    begin
        @(negedge clk);
        x = data;
        btn_press = 1;

        @(negedge clk);
        btn_press = 0;
    end
    endtask

    initial begin
        reset = 1;
        #20;
        reset = 0;

        // 1010111 입력
        send_data(1);
        send_data(0);
        send_data(1);
        send_data(0);
        send_data(1);
        send_data(1);
        send_data(1);

        #1;
        // 1010111이 입력되었을 때 led[15] on
        if (led[6:0] == 7'b1010111 && led[15] == 1)
            $display("TEST PASS!");
        else
            $display("TEST FAIL! led=%b", led);

        #20;
        $finish;
    end

endmodule