module top (
    input clk,
    input rst,
    input [9:0] sw,
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

    RandGen rand1(
        .next(sw[0]),
        .rst(sw[1]),
        .out(ledr[7:0])
    );

    assign seg0 = ~(8'b01101110);

    HexSeg seg_o1(
        .sw(ledr[3:0]),
        .dot(0),
        .seg(seg1)
    );

    HexSeg seg_o2(
        .sw(ledr[7:4]),
        .dot(0),
        .seg(seg2)
    );

    
    assign seg3 = ~(8'b0);
    assign seg4 = ~(8'b0);
    assign seg5 = ~(8'b0);
    assign seg6 = ~(8'b0);
    assign seg7 = ~(8'b0);

endmodule
