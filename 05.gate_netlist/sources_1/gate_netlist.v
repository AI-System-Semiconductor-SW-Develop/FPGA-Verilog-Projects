`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/14 10:21:00
// Design Name: 
// Module Name: gate_netlist
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gate_netlist(a,b,cin,sum,cout);
    input a,b,cin;
    output sum, cout;

    wire s1,c1,c2;

    xor (s1,a,b);
    and (c1,a,b);
    and G3 (c2, s1, cin);
    xor G4 (sum, s1,cin);
    or G5 (cout,c1,c2);
endmodule

module full_adder_1bit(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;

    assign {cout, sum} = {1'b0, a} + {1'b0, b} + {1'b0, cin};

endmodule