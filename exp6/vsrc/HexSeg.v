module HexSeg (
    input [3:0] ledr,
    input dot,
    output [7:0] seg
);
    reg [7:0] tmp;
    always @(ledr) begin
        tmp = Binary2HexCode(ledr,dot);
    end

    assign seg = ~tmp;

    function [7:0] Binary2HexCode;
        input [3:0] x;
        input dot;
        reg [7:0] seg_t;

        case(x)
            4'h0: seg_t = 8'b11111100;
            4'h1: seg_t = 8'b01100000;
            4'h2: seg_t = 8'b11011010;
            4'h3: seg_t = 8'b11110010;
            4'h4: seg_t = 8'b01100110;
            4'h5: seg_t = 8'b10110110;
            4'h6: seg_t = 8'b10111110;
            4'h7: seg_t = 8'b11100000;
            4'h8: seg_t = 8'b11111110;
            4'h9: seg_t = 8'b11100110;
            4'ha: seg_t = 8'b11101110;
            4'hb: seg_t = 8'b00111110;
            4'hc: seg_t = 8'b00011010;
            4'hd: seg_t = 8'b01111010;
            4'he: seg_t = 8'b11011110;
            4'hf: seg_t = 8'b10001110;
        endcase
        seg_t = dot ? (seg_t|{7'b0, 1'b1}) : seg_t;
        assign Binary2HexCode = seg_t;
    endfunction

endmodule