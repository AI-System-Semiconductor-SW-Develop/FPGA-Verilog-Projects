`timescale 1ns / 1ps

module play_melody(
    input clk,
    input reset,
    input [6:0] btn,
    input sw,
    output [1:0] led,
    output buzzer
    );

    //clk : 100MHz
    // 주파수 만들기 
    // 100000000 / 원하는 주파수 / 2 
    // duty 50% 이므로 절반값 계산값만큼 high low 반복
    localparam DO = 22'd191_112; // 도 261.6256 Hz
    localparam RE = 22'd170_261; // 레 293.6648 Hz
    localparam MI = 22'd151_685; // 미 329.6276 Hz
    localparam FA = 22'd143_172; // 파 349.2282 Hz
    localparam SOL = 22'd127_552; // 솔 391.9954 Hz
    localparam LA = 22'd113_635; // 라 440.0000 Hz
    localparam SI = 22'd101_237; // 시 493.8833 Hz

    reg [21:0] r_clk_cnt[6:0]; // 2차원 array
    reg [6:0] r_buzzer_frequency;
    integer i; // integer : signed 32bit / unsigned : reg [31:0]

    always @(posedge clk, posedge reset) begin
        if(reset) begin
            for (i = 0; i < 7; i=i+1) begin
                r_clk_cnt[i] <= 22'd0;
                r_buzzer_frequency[i] <= 1'b0;
            end
        end else begin // 10ns 상승 엣지 클럭
               if(!btn[0]) begin //btnU
                    r_clk_cnt[0] <= 22'd0;
                    r_buzzer_frequency[0] <= 1'b0;
                end else if (r_clk_cnt[0] >= DO -1) begin
                    r_clk_cnt[0] <= 22'd0;
                    r_buzzer_frequency[0] <= ~r_buzzer_frequency[0];
                end else r_clk_cnt[0] <= r_clk_cnt[0] + 1;

                if(!btn[1]) begin //btnL
                    r_clk_cnt[1] <= 22'd0;
                    r_buzzer_frequency[1] <= 1'b0;
                end else if (r_clk_cnt[1] >= RE -1) begin
                    r_clk_cnt[1] <= 22'd0;
                    r_buzzer_frequency[1] <= ~r_buzzer_frequency[1];
                end else r_clk_cnt[1] <= r_clk_cnt[1] + 1;

                if(!btn[2]) begin //btnC
                    r_clk_cnt[2] <= 22'd0;
                    r_buzzer_frequency[2] <= 1'b0;
                end else if (r_clk_cnt[2] >= MI -1) begin
                    r_clk_cnt[2] <= 22'd0;
                    r_buzzer_frequency[2] <= ~r_buzzer_frequency[2];
                end else r_clk_cnt[2] <= r_clk_cnt[2] + 1;

                if(!btn[3]) begin //btnR
                    r_clk_cnt[3] <= 22'd0;
                    r_buzzer_frequency[3] <= 1'b0;
                end else if (r_clk_cnt[3] >= FA -1) begin
                    r_clk_cnt[3] <= 22'd0;
                    r_buzzer_frequency[3] <= ~r_buzzer_frequency[3];
                end else r_clk_cnt[3] <= r_clk_cnt[3] + 1;

                if(!btn[4]) begin //btnD
                    r_clk_cnt[4] <= 22'd0;
                    r_buzzer_frequency[4] <= 1'b0;
                end else if (r_clk_cnt[4] >= SOL -1) begin
                    r_clk_cnt[4] <= 22'd0;
                    r_buzzer_frequency[4] <= ~r_buzzer_frequency[4];
                end else r_clk_cnt[4] <= r_clk_cnt[4] + 1;

                if(btn[5]) begin //btn5
                    r_clk_cnt[5] <= 22'd0;
                    r_buzzer_frequency[5] <= 1'b0;
                end else if (r_clk_cnt[5] >= LA -1) begin
                    r_clk_cnt[5] <= 22'd0;
                    r_buzzer_frequency[5] <= ~r_buzzer_frequency[5];
                end else r_clk_cnt[5] <= r_clk_cnt[5] + 1;

                if(btn[6]) begin //btn6
                    r_clk_cnt[6] <= 22'd0;
                    r_buzzer_frequency[6] <= 1'b0;
                end else if (r_clk_cnt[6] >= SI -1) begin
                    r_clk_cnt[6] <= 22'd0;
                    r_buzzer_frequency[6] <= ~r_buzzer_frequency[6];
                end else r_clk_cnt[6] <= r_clk_cnt[6] + 1; 
            end            
    end

    assign buzzer = |r_buzzer_frequency;
    assign led[0] = (sw == 1'b0) ? 1'b1 : 1'b0;
    // 축약 연산자 OR 연산자 
endmodule
