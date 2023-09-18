module MuxKeyInternal #(
  parameter NR_KEY = 2, 
  parameter KEY_LEN = 1, 
  parameter DATA_LEN = 1, 
  parameter HAS_DEFAULT = 0
  ) 
/*
NR_KEY为键值对的数目，即case的数目
KEY_LEN为输入的键的位长
DATA_LEN为输入和输入的数据长度
*/
(
  output reg [DATA_LEN-1:0] out,
  input [KEY_LEN-1:0] key,
  input [DATA_LEN-1:0] default_out,
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
);
// lut为键值对列表
/*
    例如：
        {
            2'b00, a[0],
            2'b01, a[1],
            2'b10, a[2],
            2'b11, a[3]
        }
*/

  //键值对总长
  localparam PAIR_LEN = KEY_LEN + DATA_LEN;
  wire [PAIR_LEN-1:0] pair_list [NR_KEY-1:0];
  wire [KEY_LEN-1:0] key_list [NR_KEY-1:0];
  wire [DATA_LEN-1:0] data_list [NR_KEY-1:0];

  // 给pair_list、key_list、data_list赋值
  genvar n;
  generate
    for (n = 0; n < NR_KEY; n = n + 1) begin
      assign pair_list[n] = lut[PAIR_LEN*(n+1)-1 : PAIR_LEN*n];
      assign data_list[n] = pair_list[n][DATA_LEN-1:0];
      assign key_list[n]  = pair_list[n][PAIR_LEN-1:DATA_LEN];
    end
  endgenerate

  reg [DATA_LEN-1 : 0] lut_out;
  reg hit;
  integer i;
  always @(*) begin
    lut_out = 0;
    hit = 0;
    for (i = 0; i < NR_KEY; i = i + 1) begin
      // 如果key == key_list[i]成立，
      // {DATA_LEN{key == key_list[i]}} & data_list[i]的值为data_list[i]
      // 否则为DATA_LEN{0}
      lut_out = lut_out | ({DATA_LEN{key == key_list[i]}} & data_list[i]);
      hit = hit | (key == key_list[i]);
    end
    if (!HAS_DEFAULT) out = lut_out;
    else out = (hit ? lut_out : default_out);
  end

endmodule

module MuxKey #(
  parameter NR_KEY = 2, 
  parameter KEY_LEN = 1, 
  parameter DATA_LEN = 1) (
  output [DATA_LEN-1:0] out,
  input [KEY_LEN-1:0] key,
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
);
  MuxKeyInternal #(NR_KEY, KEY_LEN, DATA_LEN, 0) i0 (out, key, {DATA_LEN{1'b0}}, lut);
endmodule

module MuxKeyWithDefault #(
  parameter NR_KEY = 2, 
  parameter KEY_LEN = 1, 
  parameter DATA_LEN = 1) (
  output [DATA_LEN-1:0] out,
  input [KEY_LEN-1:0] key,
  input [DATA_LEN-1:0] default_out,
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
);
  MuxKeyInternal #(NR_KEY, KEY_LEN, DATA_LEN, 1) i0 (out, key, default_out, lut);
endmodule