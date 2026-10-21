`timescale 1ns / 1ps

module tb_mux4bit();
    reg [3:0]a;
    reg [3:0]b;
    reg sel;
    wire [3:0] out;
    wire [7:0] led;

    mux4bit u_mux4bit(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out),
        .led(led)
    );

    initial begin
        a = 4'b0000; b = 4'b0000; sel = 0;
        #10;
        $monitor("Time=%0t | sel=%b | a=%b | b=%b| out=%b", $time, sel, a, b, out);

        // a[0] 또는 b[3] 선택
        a = 4'b0001; b = 4'b1000;
        sel = 1; #10;  // out = 0001
        sel = 0; #10;  // out = 1000

        // a[1] 또는 b[2] 선택
        a = 4'b0010; b = 4'b0100;
        sel = 1; #10;  // out = 0010
        sel = 0; #10;  // out = 0100

        // a[2] 또는 b[1] 선택
        a = 4'b0100; b = 4'b0010;
        sel = 1; #10;  // out = 0100
        sel = 0; #10;  // out = 0010

        // a[3] 또는 b[0] 선택
        a = 4'b1000; b = 4'b0001;
        sel = 1; #10;  // out = 1000
        sel = 0; #10;  // out = 0001

        #10;
        $finish;
    end
endmodule
