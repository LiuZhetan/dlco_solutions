module SegControl (
    input clk,
    input rst,
    input ready,
    input [7:0] ps2_data_r,
    // 是否按住
    output is_press,
    // 按键计数
    output [7:0] count,
    // 输出区位码
    output [7:0] data_out 
);
    reg [7:0] count_reg = 8'b0;
    reg [23:0] buff = 24'hf0f0f0;
    reg [3:0] current_state = 4'b0; 

    // state[2]为当前是否按下
    assign current_state[2] = buff[23:16] != 8'hf0;
    assign current_state[1] = buff[15:8] != 8'hf0;
    assign current_state[0] = buff[7:0] != 8'hf0;

    assign count = count_reg;
    assign data_out = buff[7:0];

    reg switch_out = 1'b0;;

    MuxKeyWithDefault #(11, 4, 1) state_transfor (switch_out, current_state, 1'b0, {
    4'b0000, 1'b0,
    4'b0001, 1'b1,
    4'b0010, 1'b0,
    4'b1010, 1'b1,
    4'b0011, 1'b1,
    4'b1011, 1'b1,
    4'b1110, 1'b1,
    4'b1111, 1'b1,
    // 两个按键同时按下再松开就会停止显示并只加上一次计数
    4'b0101, 1'b0,
    4'b1101, 1'b0,
    4'b0100, 1'b0
  });

    always @(posedge rst) begin
        count_reg = 0;
    end

    always @(posedge clk) begin 
        if (ready) begin
            buff = {buff[15:0], ps2_data_r};
            current_state[3] = switch_out;
        end
    end

    always @(switch_out) begin
        $display("buff: %x, current_state: %b, switch_out: %b", buff, current_state, switch_out);
        // current_state[3] = switch_out;
    end

    always @(negedge switch_out) begin
        count_reg = count_reg + 1;
        $display("count_reg: %b, buff: %x", is_press, buff);
    end

    assign is_press = switch_out;

    /*always @(is_press) begin
        $display("is_press: %b, switch_out: %x", is_press, switch_out);
    end*/

    /*always @(current_state[2:0]) begin
        $display("buff: %x, current_state: %b, switch_out: %b", buff, current_state, switch_out);
    end*/

    /*always @(switch_out) begin
        $display("buff: %x, current_state: %b, switch_out: %b", buff, current_state, switch_out);
    end*/

    always @(data_out) begin
        $display("data_out %x", data_out);
    end
endmodule