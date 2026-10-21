`timescale 1ns / 1ps

module gates(
    input [1:0]sw,
    output [5:0] led //신호선이 다섯가닥 0~5 led[0]~led[5]
    );

    assign led[0] = sw[0] & sw[1]; //AND
    assign led[1] = sw[0] | sw[1]; // OR
    assign led[2] = ~(sw[0] & sw[1]); // NAND
    assign led[3] = ~(sw[0] | sw[1]); // NOR
    assign led[4] = sw[0] ^ sw[1]; // XOR
    assign led[5] = ~sw[0]; // NOT
endmodule

// module gates(
//     input a,
//     input b,
//     output led0,
//     output led1,
//     output led2,
//     output led3,
//     output led4,
//     output led5
//     );

//     assign led0 = a & b; //AND
//     assign led1 = a | b; // OR
//     assign led2 = ~(a & b); // NAND
//     assign led3 = ~(a | b); // NOR
//     assign led4 = a ^ b; // XOR
//     assign led5 = ~a; // NOT
// endmodule
