module top (
    input clk,
    input rst,
    input [8:0] sw,
    output [15:0] ledr,
    output [7:0] seg0
);

encoder83 encoder_1(
    .sw(sw),
    .ledr(ledr[2:0])
);

seg3 seg_1(
    .x(ledr[2:0]),
    .o_seg(seg0)
);

endmodule
