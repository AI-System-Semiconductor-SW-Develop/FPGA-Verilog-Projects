`timescale 1ns / 1ps

module melay_fsm_101(
    input clk,
    input reset,
    input x1,
    input x2,
    output reg y,
    output btn_event
);

// ppt 16
    // 인코딩 ( S3는 불필요 : 상태는 3개만 필요 )
    localparam [1:0] S0 = 2'b00, // 대기 상태
                     S1 = 2'b01,
                     S2 = 2'b10;

    reg [1:0] r_curr_state, r_next_state;

    // 이전 버튼 상태 저장
    reg prev_x1, prev_x2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            prev_x1 <= 0;
            prev_x2 <= 0;
        end
        else begin
            prev_x1 <= x1;
            prev_x2 <= x2;
        end
    end

    // top에서 버튼 입력을 감지하기 위해 사용
    assign btn_event = (x1 && x1 != prev_x1)||(x2 && x2 != prev_x2);

    // 1. curr_state 상태 register ( moore와 동일하다.)
    always @(posedge clk , posedge reset) begin
        if(reset) r_curr_state <= S0;
        else if((x1 && x1 != prev_x1)||(x2 && x2 != prev_x2)) r_curr_state <= r_next_state;
    end

    // 2. next_state와 출력 y (입력을 참조)
    always @(*) begin
        r_next_state = r_curr_state;
        y = 1'b0;
        case (r_curr_state)
            S0: if((x1 && x1 != prev_x1)) r_next_state = S1;
            S1: if((x2 && x2 != prev_x2)) r_next_state = S2;
            S2: if((x1 && x1 != prev_x1)) begin
                y = 1'b1; // led on
                r_next_state = S1;
            end 
            else r_next_state = S0;
            default: r_next_state = S0;
        endcase
    end

endmodule
