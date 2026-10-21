`timescale 1ns / 1ps

module tb_adder_subtracter();

    reg r_add_nsub;
    reg [3:0] r_a;
    reg [3:0] r_b;
    wire w_carry_out;
    wire [3:0] w_sum;

    adder_subtracter u_adder_subtracter(
        .add_nsub(r_add_nsub),
        .a(r_a),
        .b(r_b),
        .carry_out(w_carry_out),
        .sum(w_sum)
    );

    initial begin
    
    r_add_nsub = 1'b0; r_a = 4'b0000; r_b = 4'b0000;
    $monitor("time = %0t | mode = %b | a = %d b = %d | carry_out = %b sum = %b", $time, r_add_nsub, r_a, r_b, w_carry_out, w_sum);
    

    // 덧셈
    r_add_nsub = 1;
    r_a = 4'd0;  r_b = 4'd0;  #10; // carry=0, sum=0000
    r_a = 4'd5;  r_b = 4'd3;  #10; // carry=0, sum=1000
    r_a = 4'd15; r_b = 4'd1;  #10; // carry=1, sum=0000
    r_a = 4'd15; r_b = 4'd15; #10; // carry=1, sum=1110

    // 뺄셈
    r_add_nsub = 0;
    r_a = 4'd5; r_b = 4'd3; #10; // carry=0, sum=0010
    r_a = 4'd7; r_b = 4'd7; #10; // carry=0, sum=0000
    r_a = 4'd3; r_b = 4'd5; #10; // carry=1, sum=1110
    r_a = 4'd0; r_b = 4'd1; #10; // carry=1, sum=1111

    // 같은 값 덧셈 뺄셈
    r_a = 4'd9;
    r_b = 4'd2;
    r_add_nsub = 1; #10; // carry=0, sum=1011
    r_add_nsub = 0; #10; // carry=0, sum=0111

    $finish;

    end

endmodule
