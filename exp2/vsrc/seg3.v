module seg3 (
    // 接收三位数字输入
    input [2:0] x,
    output [7:0] o_seg
);

reg [7:0] seg_t;

always @(x)
    case(x)
        3'b000: seg_t = 8'b11111100;
        3'b001: seg_t = 8'b01100000;
        3'b010: seg_t = 8'b11011010;
        3'b011: seg_t = 8'b11110010;
        3'b100: seg_t = 8'b01100110;
        3'b101: seg_t = 8'b10110110;
        3'b110: seg_t = 8'b10111110;
        3'b111: seg_t = 8'b11100000;
    endcase

    assign o_seg = ~(seg_t);

endmodule