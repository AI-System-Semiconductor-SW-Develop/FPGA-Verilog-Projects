`timescale 1ns / 1ps

module main_controller(
    input clk,
    input reset,
    input [2:0]btn, // btn[0] : btnL btn[1] : btnC btn[2] : btnR
    output [13:0]seg_data,
    output reg [15:14]led,
    output clock_dot,
    output animation
    );

    // mode define
    parameter MIN_SEC_CLK = 2'b00;
    parameter STOP_WATCH = 2'b01;
    parameter PAUSE = 2'b10;
    parameter RESET = 2'b11;

    wire [13:0] w_clock_data;
    wire w_btn_pressed;
    reg r_blink;
    reg r_prev_btnL = 0;
    reg r_prev_btnC = 0;
    reg r_prev_btnR = 0;
    reg [1:0]r_mode = MIN_SEC_CLK;
    reg [$clog2(1_000_000)-1:0] r_10ns_counter; // 10ns counter 100_000
    reg [$clog2(10_000)-1:0] r_10ms_counter; // 10ms counter 10_000
    reg [$clog2(100_000_000)-1:0] r_1sec_counter; // 1sec counter 100_000_000
    reg [$clog2(300_000_000)-1:0] r_idle_counter; // idle counter 300_000_000
    reg [$clog2(60)-1:0] r_sec;
    reg [$clog2(60)-1:0] r_min;

    // btn mode check
    always @(posedge clk, posedge reset) begin
        if(reset) begin
            r_mode <= MIN_SEC_CLK;
            r_prev_btnL <= 0;
            r_prev_btnC <= 0;
            r_prev_btnR <= 0;
        end else begin
            if (r_mode == RESET) r_mode <= STOP_WATCH;
            else if(btn[0] && !r_prev_btnL) 
                r_mode <= (r_mode == MIN_SEC_CLK) ? STOP_WATCH : MIN_SEC_CLK;
            else if (btn[1] && !r_prev_btnC) begin
               if (r_mode == STOP_WATCH || r_mode == PAUSE) r_mode <= RESET;
            end
            else if (btn[2] && !r_prev_btnR) begin
                if(r_mode == STOP_WATCH) r_mode <= PAUSE;
                else if(r_mode == PAUSE) r_mode <= STOP_WATCH;
            end
            r_prev_btnL <= btn[0];
            r_prev_btnC <= btn[1];
            r_prev_btnR <= btn[2];   
        end     
    end

    // stop_watch
    always @(posedge clk, posedge reset) begin
        if(reset) begin
            r_10ms_counter <= 0;
            r_10ns_counter <= 0;
        end else if(r_mode == STOP_WATCH) begin
            if(r_10ns_counter == 20'd1_000_000-1) begin // 10ms reached
                r_10ns_counter <= 0;
                if (r_10ms_counter >= 9999)
                    r_10ms_counter <=0;
                else r_10ms_counter <= r_10ms_counter +1;
            end else begin
                r_10ns_counter <= r_10ns_counter +1;
            end
        end else if (r_mode == PAUSE) begin
            r_10ms_counter <= r_10ms_counter;
        end else if (r_mode == RESET) begin
            r_10ms_counter <= 0;
            r_10ns_counter <= 0;
        end
    end

    // 분.초 시계용 카운터
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_1sec_counter <= 0;
            r_sec <= 0;
            r_min <= 0;
            r_blink <= 0;
        end else begin
            if (r_1sec_counter == 100_000_000 - 1) begin
                r_1sec_counter <= 0;
                r_blink <= ~r_blink;
                if (r_sec == 59) begin
                    r_sec <= 0;
                    if (r_min == 59)
                        r_min <= 0;
                    else
                        r_min <= r_min + 1;
                end else begin
                    r_sec <= r_sec + 1;
                end
            end else begin
                r_1sec_counter <= r_1sec_counter + 1;
            end
        end
    end

    // 
    always @(posedge clk or posedge reset) begin
        if (reset)
            r_idle_counter <= 0;
        else if (r_mode != PAUSE || w_btn_pressed)
            r_idle_counter <= 0;
        else if (r_idle_counter < 300_000_000)
            r_idle_counter <= r_idle_counter + 1;
        // 3초에 도달하면 값 유지
    end

    // mode display
    always @(r_mode) begin
        led = r_mode;
    end

    assign w_btn_pressed = (btn[0] && !r_prev_btnL) || (btn[1] && !r_prev_btnC) || (btn[2] && !r_prev_btnR);
    
    assign animation = (r_mode == PAUSE) && (r_idle_counter == 300_000_000) && !w_btn_pressed;
    
    assign clock_dot = (r_mode == MIN_SEC_CLK) && r_blink;

    assign w_clock_data = r_min * 100 + r_sec;

    assign seg_data = (r_mode == MIN_SEC_CLK) ? w_clock_data : r_10ms_counter;
endmodule
