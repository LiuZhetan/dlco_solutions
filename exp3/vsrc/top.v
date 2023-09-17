module top (
    input clk,
    input rst,
    // {en, op[2:0], A[3:0], B[3:0]}
    input [11:0] sw,
    // {zero, overflow, carry, result[3:0]}
    output [6:0] ledr,
    // result in dec
    output [7:0] seg0,
    // flag
    output [7:0] seg1
);

Alu #(.N(4)) alu_1(
    .en(sw[11]),
    .op(sw[10:8]),
    .A(sw[7:4]),
    .B(sw[3:0]),
    .result(ledr[3:0]),
    .carry(ledr[4]),
    .overflow(ledr[5]),
    .zero(ledr[6])
);

seg4 seg_1(
    .x(ledr[3:0]),
    .o_seg_0(seg0),
    .o_seg_1(seg1)
);

endmodule
