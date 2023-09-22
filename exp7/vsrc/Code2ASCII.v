module Code2ASCII (
    input [7:0] code_in,
    output [7:0] ascii_out_hx
);

    MuxKeyWithDefault #(36, 8, 8) tarnsfor_table (ascii_out_hx, code_in, 8'b0, {
    8'h1c, 8'd65,
    8'h32, 8'd66,
    8'h21, 8'd67,
    8'h23, 8'd68,
    8'h24, 8'd69,
    8'h2b, 8'd70,
    8'h34, 8'd71,
    8'h33, 8'd72,
    8'h43, 8'd73,
    8'h3b, 8'd74,
    8'h42, 8'd75,
    8'h4b, 8'd76,
    8'h3a, 8'd77,
    8'h31, 8'd78,
    8'h44, 8'd79,
    8'h4d, 8'd80,
    8'h15, 8'd81,
    8'h2d, 8'd82,
    8'h1b, 8'd83,
    8'h2c, 8'd84,
    8'h3c, 8'd85,
    8'h2a, 8'd86,
    8'h1d, 8'd87,
    8'h22, 8'd88,
    8'h35, 8'd89,
    8'h1a, 8'd90,
    8'h70, 8'h30,
    8'h69, 8'h31,
    8'h72, 8'h32,
    8'h7a, 8'h33,
    8'h6b, 8'h34,
    8'h73, 8'h35,
    8'h74, 8'h36,
    8'h6c, 8'h37,
    8'h75, 8'h38,
    8'h7d, 8'h39
  });

endmodule