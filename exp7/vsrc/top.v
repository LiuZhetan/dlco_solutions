module top (
    input clk,
    input rst,
    input [7:0] sw,
    input ps2_clk,
    input ps2_data,
    output [15:0] ledr,
    output [7:0] seg0,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] seg3,
    output [7:0] seg4,
    output [7:0] seg5,
    output [7:0] seg6,
    output [7:0] seg7
);

wire [7:0] ps2_out;

ps2_keyboard my_keyboard(
    .clk(clk),
    .clrn(~sw[0]),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .data(ps2_out),
    .nextdata_n(1'b0),
    .ready(ledr[0]),
    .overflow(ledr[1])
    );

seg mu_seg(
    .rst(rst),
    .ps2_data(ps2_out),
    .o_seg0(seg0),
    .o_seg1(seg1),
    .o_seg2(seg2),
    .o_seg3(seg3),
    .o_seg4(seg4),
    .o_seg5(seg5),
    .o_seg6(seg6),
    .o_seg7(seg7)
);

endmodule
