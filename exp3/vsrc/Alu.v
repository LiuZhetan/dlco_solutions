module Alu #(parameter N)
(
    input en,
    input [2:0] op,
    input [N-1:0] A,
    input [N-1:0] B,
    output [N-1:0] result,
    output carry,
    output overflow,
    output zero
);

// overflow, carry and result
reg [N+1:0] collection;
reg zero_t;

always @(en or op or A or B) begin
    if (en) begin
        $display("receive op(3bit):%b A(4bit):%b B(4bit):%b", op, A, B);
        case(op)
            3'b000: collection = AluAdd(A,B);
            3'b001: collection = AluSub(A,B);
            3'b010: collection = {2'b0, AluNot(A)};
            3'b011: collection = {2'b0, AluAnd(A,B)};
            3'b100: collection = {2'b0, AluOr(A,B)};
            3'b101: collection = {2'b0, AluXor(A,B)};
            // If A<B then out=1; else out=0;
            // out is overflow flag here
            3'b110: begin
                collection = AluSub(A,B);
                // less = out_s ^ overflow
                collection[N-1:0] = {{N-1{1'b0}}, collection[N-1] ^ collection[N+1]};
            end
            // If A==B then out=1; else out=0; 
            // out is zero flag here
            3'b111: begin
                collection = AluSub(A,B);
                collection[N-1:0] = IsZero(collection[N-1:0]) ? {{N-1{1'b0}}, 1'b1}:{N{1'b0}};
            end
        endcase
        assign zero_t = IsZero(collection[N-1:0]);
        $display("zero flag:%b overflow flag:%b carry flag:%b", 
        zero_t, collection[N+1], collection[N]);
    end
    else begin
        assign collection = {(N+2){1'b0}};
        assign zero_t= 1'b0;
    end
end

assign result = collection[N-1:0];
assign carry = collection[N];
assign overflow = collection[N+1];
assign zero = zero_t;

function [N-1:0] AluAnd;
    input [N-1:0] x;
    input [N-1:0] y;
        begin
            AluAnd = x & y;
        end
    $display("compute 0b%b and 0b%b = 0b%b", x,y,AluAnd[N-1:0]);
endfunction

function [N-1:0] AluOr;
    input [N-1:0] x;
    input [N-1:0] y;
        begin
            AluOr = x | y;
        end
    $display("compute 0b%b or 0b%b = 0b%b", x,y,AluOr[N-1:0]);
endfunction

function [N-1:0] AluNot;
    input [N-1:0] x;
    begin
        AluNot = ~x;
    end
    $display("compute not 0b%b = 0b%b", x,AluNot[N-1:0]);
endfunction

function [N-1:0] AluXor;
    input [N-1:0] x;
    input [N-1:0] y;
        begin
            AluXor = x ^ y;
        end
    $display("compute 0b%b xor 0b%b = 0b%b", x,y,AluXor[N-1:0]);
endfunction

function IsZero;
    input [N-1:0] x;
    assign IsZero = ~(| x);
endfunction

function [N+1:0] AluAdder;
    input cin;
    input [N-1:0] x;
    input [N-1:0] y;
    reg [N-1:0] t_no_cin;
        begin
            assign t_no_cin = {N{ cin }}^y;
            // {Carry,Result}
            assign AluAdder[N:0] = x + t_no_cin + {{N{1'b0}}, cin};
            // Overflow
            assign AluAdder[N+1] = (x[N-1] == t_no_cin[N-1]) && (AluAdder[N-1] != x[N-1]);
        end
endfunction

function [N+1:0] AluAdd;
    input [N-1:0] x;
    input [N-1:0] y;
        begin
            AluAdd = AluAdder(0,x,y);
        end
    $display("compute 0b%b + 0b%b = 0b%b", x,y,AluAdd[N-1:0]);
endfunction

function [N+1:0] AluSub;
    input [N-1:0] x;
    input [N-1:0] y;
        begin
            AluSub = AluAdder(1,x,y);
        end
    $display("compute 0b%b - 0b%b = 0b%b", x,y,AluSub[N-1:0]);
endfunction

endmodule