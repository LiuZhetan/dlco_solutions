module EncoderInternal
# (
    // 输出编码的长度，默认为2，即42编码器
    parameter output_len = 2
)
(
    input [(1 << output_len) - 1 : 0] x,
    input en,
    output reg [output_len - 1 : 0] y
);

integer input_len =  1 << output_len;
integer i;

always @(x or en) begin
    if (en) begin
        y = 0;
        for (i = input_len - 1; i >= 0; i = i - 1)
            if(x[i] == 1) begin
                y = i[output_len - 1:0];
                break;
            end
    end
    else y = 0;
end

endmodule