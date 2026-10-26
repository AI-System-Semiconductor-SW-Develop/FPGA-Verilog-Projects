
`timescale 1ns / 1ps

module fnd_controller(
    input clk,
    input reset,
    input tick,
    input [13:0] in_data,
    input [1:0] motor_direction,
    output [3:0] an,
    output [7:0] seg
);

    wire [1:0] w_sel;
    wire [3:0] w_d1, w_d10, w_d100, w_d1000;

    reg [26:0] r_count;
    reg r_blink;

    // 100MHz 기준 1초마다 ON/OFF 전환
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_count <= 0;
            r_blink <= 1'b1;
        end
        else if (r_count == 100_000_000 - 1) begin
            r_count <= 0;
            r_blink <= ~r_blink;
        end
        else begin
            r_count <= r_count + 1;
        end
    end

    fnd_digit_select u_fnd_digit_select(
        .clk(clk),
        .reset(reset),
        .tick(tick),
        .sel(w_sel)
    );

    bin2bcd4digit u_bin2bcd4digit(
        .in_data(in_data),
        .d1(w_d1),
        .d10(w_d10),
        .d100(w_d100),
        .d1000(w_d1000)
    );

    fnd_digit_display u_fnd_digit_display(
        .sel(w_sel),
        .d1(w_d1),
        .d10(w_d10),
        .d100(w_d100),
        .d1000(w_d1000),
        .motor_direction(motor_direction),
        .blink(r_blink),
        .an(an),
        .seg(seg)
    );

endmodule


// 1ms마다 표시 자릿수 변경
module fnd_digit_select(
    input clk,
    input reset,
    input tick,
    output reg [1:0] sel
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            sel <= 0;
        else if (tick)
            sel <= sel + 1'b1;
    end

endmodule


// Binary -> BCD 변환
module bin2bcd4digit(
    input [13:0] in_data,
    output [3:0] d1,
    output [3:0] d10,
    output [3:0] d100,
    output [3:0] d1000
);

    assign d1    = in_data % 10;
    assign d10   = (in_data / 10) % 10;
    assign d100  = (in_data / 100) % 10;
    assign d1000 = (in_data / 1000) % 10;

endmodule


// FND 자리 선택 및 세그먼트 출력
module fnd_digit_display(
    input [1:0] sel,
    input [3:0] d1,
    input [3:0] d10,
    input [3:0] d100,
    input [3:0] d1000,
    input [1:0] motor_direction,
    input blink,
    output reg [3:0] an,
    output reg [7:0] seg
);

    reg [3:0] bcd_data;

    always @(*) begin

        bcd_data = 0;
        an = 4'b1111;
        seg = 8'b11111111;

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
                an = 4'b0111;
            end
        endcase

        // 1000의 자리 : 모터 방향 표시
        if (sel == 2'b11) begin
            if (blink) begin
                case (motor_direction)
                    2'b10: seg = 8'b10001110; // F
                    2'b01: seg = 8'b10000011; // b
                    default: seg = 8'b11111111;
                endcase
            end
            else begin
                seg = 8'b11111111; // OFF
            end
        end

        // 나머지 세 자리 : 숫자 표시
        else begin
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
        end

    end

endmodule
