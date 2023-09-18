module seg(
    input rst,
    input [7:0] ps2_data,
    // o_seg0和o_seg1输出扫描码
    output [7:0] o_seg0,
    output [7:0] o_seg1,
    // o_seg2和o_seg3输出ascii码
    output [7:0] o_seg2,
    output [7:0] o_seg3,
    // o_seg4和o_seg5不输出
    output [7:0] o_seg4,
    output [7:0] o_seg5,
    // o_seg6和o_seg7输出计数
    output [7:0] o_seg6,
    output [7:0] o_seg7
  );

  assign o_seg4 = 8'b1;
  assign o_seg5 = 8'b1;

  wire [7:0] o_seg0_t;
  wire [3:0] i_seg0_t;
  assign i_seg0_t = ps2_data[3:0];
  Hex2Segcode transfor0 (.x(i_seg0_t), .y(o_seg0_t));

  wire [7:0] o_seg1_t;
  wire [3:0] i_seg1_t;
  assign i_seg1_t = ps2_data[7:4];
  Hex2Segcode transfor1 (.x(i_seg1_t), .y(o_seg1_t));

  wire [15:0] o_seg01;
  assign o_seg01 = is_release ? {8'b1, 8'b1} : {o_seg1_t, o_seg0_t};
  assign o_seg0 = o_seg01[7:0];
  assign o_seg1 = o_seg01[15:8];

  reg [7:0] count;

  always @(posedge rst) begin
    count = 8'b0;
    o_seg6_t <= 8'b1;
    o_seg6_t <= 8'b1;
  end

  // 记录是否松开按键
  reg is_release;
  assign is_release = ps2_data == 8'h1d ? 1 : 0;
  always @(is_release) begin
    $display("count = %d", count);
    count = count + 1;
  end
  // 输出16进制数到seg6和seg7
  reg [7:0] o_seg6_t;
  Hex2Segcode transfor6 (.x(count[3:0]), .y(o_seg6_t));
  assign o_seg6 = o_seg6_t;

  reg [7:0] o_seg7_t;
  Hex2Segcode transfor7 (.x(count[3:0]), .y(o_seg7_t));
  assign o_seg7 = o_seg7_t;

  // 输出ascii码到seg2和seg3

endmodule
