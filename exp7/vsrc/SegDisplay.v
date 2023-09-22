module SegDisplay(
    input rst,
    input [7:0] ps2_data,
    input is_press,
    input [7:0] count,
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

  assign o_seg2 = ~8'b0;
  assign o_seg3 = ~8'b0;
  assign o_seg4 = ~8'b0;
  assign o_seg5 = ~8'b0;

  wire [7:0] o_seg0_t;
  wire [3:0] i_seg0_t;
  Hex2Segcode transfor0 (.x(i_seg0_t), .y(o_seg0_t));
  assign i_seg0_t = ps2_data[3:0];

  wire [7:0] o_seg1_t;
  wire [3:0] i_seg1_t;
  Hex2Segcode transfor1 (.x(i_seg1_t), .y(o_seg1_t));
  assign i_seg1_t = ps2_data[7:4];

  // 输出扫描码到o_seg0和o_seg1
  wire [15:0] o_seg01;
  assign o_seg01 = !is_press ? {~8'b0, ~8'b0} : {o_seg1_t, o_seg0_t};
  assign o_seg0 = o_seg01[7:0];
  assign o_seg1 = o_seg01[15:8];

  // 输出ascii码到seg2和seg3
  wire [7:0] ascii_out;
  Code2ASCII to_ascii (.code_in(ps2_data), .ascii_out_hx(ascii_out));

  wire [7:0] o_seg2_t;
  Hex2Segcode transfor2 (.x(ascii_out[3:0]), .y(o_seg2_t));

  wire [7:0] o_seg3_t;
  Hex2Segcode transfor3 (.x(ascii_out[7:4]), .y(o_seg3_t));

  wire [15:0] o_seg23;
  assign o_seg23 = !is_press ? {~8'b0, ~8'b0} : {o_seg3_t, o_seg2_t};

  assign o_seg2 = o_seg23[7:0];
  assign o_seg3 = o_seg23[15:8];

  always @(posedge rst) begin
    o_seg6_t <= ~8'b0;
    o_seg7_t <= ~8'b0;
  end

  // 输出16进制数到seg6和seg7
  reg [7:0] o_seg6_t;
  Hex2Segcode transfor6 (.x(count[3:0]), .y(o_seg6_t));
  assign o_seg6 = o_seg6_t;

  reg [7:0] o_seg7_t;
  Hex2Segcode transfor7 (.x(count[7:4]), .y(o_seg7_t));
  assign o_seg7 = o_seg7_t;

endmodule
