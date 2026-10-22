`timescale 1ns / 1ps

module fnd_controller(
    input clk,
    input reset,
    input tick,
    input clock_dot,
    input animation,
    input [13:0] in_data,
    output [7:0] seg,
    output [3:0] an
    );

    wire [1:0] w_sel;
    wire [3:0] w_d1, w_d10, w_d100, w_d1000;

    reg [6:0] r_anim_count; // 0~99
    reg [2:0] r_anim_step;  // 0~5

    // 애니메이션 속도와 단계 제어
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_anim_count <= 0;
            r_anim_step <= 0;
        end else if (!animation) begin
            r_anim_count <= 0;
            r_anim_step <= 0;
        end else if (tick) begin
            if (r_anim_count == 99) begin
                r_anim_count <= 0;

                if (r_anim_step == 5)
                    r_anim_step <= 0;
                else
                    r_anim_step <= r_anim_step + 1;
            end else begin
                r_anim_count <= r_anim_count + 1;
            end
        end
    end

    fnd_digit_select u_fnd_digit_select(
        .clk(clk),
        .reset(reset),
        .tick(tick),
        .sel(w_sel) // 00 01 10 11 : 1ms 마다 바뀜
    );

    bin2bcd_4digit u_bin2bcd_4digit(
        .in_data(in_data),
        .d1(w_d1),
        .d10(w_d10), 
        .d100(w_d100), 
        .d1000(w_d1000)                    
    );

    fnd_digit_diplay u_fnd_digit_diplay(
        .sel(w_sel), // 00 01 10 11 : 1ms 마다 바뀜        
        .d1(w_d1),
        .d10(w_d10), 
        .d100(w_d100), 
        .d1000(w_d1000),
        .seg(seg),
        .an(an),
        .clock_dot(clock_dot),
        .animation(animation),
        .anim_step(r_anim_step)
    );
endmodule


// 1ms마다 fnd를 display digit 1자리씩 선택하는 logic
module fnd_digit_select(
    input clk,
    input reset,
    input tick,
    output reg[1:0] sel // 00 01 10 11 : 1ms 마다 바뀜
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            sel <= 0;
        else if (tick)
            sel <= sel + 1;
    end
endmodule

// in_data : 14bit fnd에 9999까지 표현 하기 위한 bin size
// 0~9999 천/백/십/일 자리 숫자 0~9 bcd로 4bit 표현한다.
module bin2bcd_4digit (
    input [13:0] in_data,
    output [3:0] d1,
    output [3:0] d10,
    output [3:0] d100,
    output [3:0] d1000            
    );

    assign d1 = in_data % 10;
    assign d10 = (in_data / 10) % 10;
    assign d100 = (in_data / 100) % 10;
    assign d1000 = (in_data / 1000) % 10;   

endmodule

module fnd_digit_diplay(
    input [1:0] sel,
    input [3:0] d1,
    input [3:0] d10,
    input [3:0] d100,
    input [3:0] d1000,
    input clock_dot,
    input animation,
    input [2:0] anim_step,
    output reg [7:0] seg,
    output reg [3:0] an
);

    reg [3:0] bcd_data;

    // 표시할 자리와 해당 숫자 선택
    always @(*) begin
        case (sel)
            2'b00: begin
                bcd_data = d1;
                an = 4'b1110;
            end
            2'b01: begin
                bcd_data = d10;
                an = 4'b1101;
            end
            2'b10: begin
                bcd_data = d100;
                an = 4'b1011;
            end
            2'b11: begin
                bcd_data = d1000;
                an = 4'b0111;
            end
            default: begin
                bcd_data = 0;
                an = 4'b1111;
            end
        endcase
    end

    // seg 비트 순서: {dp, g, f, e, d, c, b, a}
    // active-low: 0이면 켜짐
    always @(*) begin
        if (animation) begin
            case (anim_step)
                3'd0: seg = 8'b11111110; // a
                3'd1: seg = 8'b11111101; // b
                3'd2: seg = 8'b11111011; // c
                3'd3: seg = 8'b11110111; // d
                3'd4: seg = 8'b11101111; // e
                3'd5: seg = 8'b11011111; // f
                default: seg = 8'b11111111;
            endcase
        end else begin
            case (bcd_data)
                4'd0: seg = 8'b11000000;
                4'd1: seg = 8'b11111001;
                4'd2: seg = 8'b10100100;
                4'd3: seg = 8'b10110000;
                4'd4: seg = 8'b10011001;
                4'd5: seg = 8'b10010010;
                4'd6: seg = 8'b10000010;
                4'd7: seg = 8'b11111000;
                4'd8: seg = 8'b10000000;
                4'd9: seg = 8'b10010000;
                default: seg = 8'b11111111;
            endcase

            // 분·초 사이 소수점
            seg[7] = ~((sel == 2'b10) && clock_dot);
        end
    end

endmodule