module seg4 (
    // 接收四位补码输入
    input [3:0] x,
    //输出两位带符号十进制数
    output [7:0] o_seg_0,
    output [7:0] o_seg_1
);

reg [3:0] pos_val;
reg [7:0] o_seg_t;

always @(x)
    pos_val = x[3] ? ((~x) + {3'b0,1'b1}) : x;
    // 数字位，注意最小负数的特殊情况
    assign o_seg_0 = x == 4'b1000 ? ~(8'b11111110) : ~(Binary2DecCode(pos_val[2:0],0));
    // 符号位
    assign o_seg_1 = ~(FlagCode(x[3]));

function [7:0] Binary2DecCode;
    input [2:0] x;
    input dot;
 
    reg [7:0] seg_t;
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
    seg_t = dot ? (seg_t|{7'b0, 1'b1}) : seg_t;
    assign Binary2DecCode = seg_t;

endfunction

function [7:0] FlagCode;
    input flag;
    reg [7:0] flag_t;
    assign flag_t = {8{flag}};
    assign FlagCode = (flag_t&8'b00000010) | (~flag_t&8'b00000000);
endfunction
endmodule