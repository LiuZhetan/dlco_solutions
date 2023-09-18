module RandGen (
    input next,
    input rst,
    output [7:0] out
);

    reg [7:0] q;

    always @(next or posedge rst) begin
        q = rst ? 8'b00000001 : {q[4]^q[3]^q[2]^q[0] , q[7:1]};
        q = ~|q ? 8'b00000001 : q;
    end

    assign out = q;

endmodule