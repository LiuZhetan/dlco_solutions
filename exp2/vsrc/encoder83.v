module encoder83 (
    input [8:0] sw,
    output [2:0] ledr
);

EncoderInternal #(.output_len(3)) encoder (
    .x  (sw[7:0]),
    .en (sw[8]),
    .y  (ledr)
);

endmodule