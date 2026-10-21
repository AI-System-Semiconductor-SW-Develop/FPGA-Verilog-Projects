`timescale 1ns / 1ps

// module led_toggle(
//     input clean_btn,
//     output led
//     );

//     reg r_toggle = 1'b0;

//     always @(posedge clean_btn) begin
//         r_toggle <= ~r_toggle;
//     end

//     assign led = (r_toggle == 1)? 1'b1 : 1'b0;
// endmodule

module led_fsm(
    input clk,
    input reset,
    input clean_btn,
    output reg [4:0] led
);

    localparam [1:0] S0 = 2'b00,
                     S1 = 2'b01,
                     S2 = 2'b10,
                     S3 = 2'b11;

    reg [1:0] state, next_state;
    reg dir, next_dir;
    reg prev_btn;

    wire btn_pulse;

    // 버튼을 누른 순간만 1
    assign btn_pulse = clean_btn & ~prev_btn;

    // 이전 버튼 상태 저장
    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_btn <= 0;
        else
            prev_btn <= clean_btn;
    end

    // 현재 상태 및 방향 저장
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            dir <= 0;
        end
        else begin
            state <= next_state;
            dir <= next_dir;
        end
    end

    // 다음 상태 결정
    always @(*) begin
        next_state = state;
        next_dir = dir;

    if (btn_pulse) begin
        if (dir == 0) begin  // 정방향
            if (state == S3) begin
                next_state = S2;
                next_dir = 1;
            end
            else
                next_state = state + 1'b1;
        end
        else begin           // 역방향
            if (state == S0) begin
                next_state = S1;
                next_dir = 0;
            end
            else
                next_state = state - 1'b1;
        end
    end
end

    // Mealy 출력
    // 현재 상태와 버튼 입력으로 계산된 next_state 사용
    always @(*) begin
        led = 5'b00000;

        led[3:0] = 4'b0001 << next_state;

        // 역방향이면 LED4 ON
        led[4] = next_dir;
    end

endmodule
