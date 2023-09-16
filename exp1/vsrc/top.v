module top (
    input clk,
    input rst,
    input [9:0] sw,
    output [15:0] ledr
);

mutex41 mutex(
    .clk(clk),
    .rst(rst),
    .sw(sw),
    .ledr(ledr)
);

endmodule
