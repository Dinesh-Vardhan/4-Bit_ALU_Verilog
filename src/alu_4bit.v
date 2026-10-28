`timescale 1ns / 1ps

module alu_4bit(
    input wire [3:0]A,
    input wire [3:0]B,
    input wire [3:0]sel,
    
    output reg [3:0]Result,
    output reg        carry,
    output reg        zero,
    output reg        negative,
    output reg        overflow
 );
 
 localparam ADD = 4'b0000;
 localparam SUB = 4'b0001;
 localparam AND = 4'b0010;
 localparam OR  = 4'b0011;
 localparam XOR = 4'b0100;
 localparam SLT  = 4'b0101;
 localparam SLTU = 4'b0110;
 localparam NOT_A = 4'b0111;
 localparam SLL   = 4'b1000;
 localparam SRL   = 4'b1001;
 localparam PASS_A = 4'b1010;

reg [4:0] temp;

 always @(*) begin
    Result = 4'b0000;
    carry = 1'b0;
    zero = 1'b0;
    negative = 1'b0;
    overflow = 1'b0;
    temp = 5'b00000;
    case(sel)
     ADD: begin
      temp={1'b0,A}+{1'b0,B};
      Result=temp[3:0];
      
      carry=temp[4];
      
      overflow=(~(A[3]^B[3])) & (A[3]^Result[3]);
      end
     SUB: begin 
        temp = {1'b0,A}-{1'b0,B};
        Result=temp[3:0];
        
        carry = (A>=B);
        
        overflow=(A[3]^B[3])&(A[3]^Result[3]);
        
        end
     AND: Result = A&B;
     OR : Result = A|B;
     XOR: Result = A^B;
     SLT: Result = ($signed(A) < $signed(B)) ? 4'b0001 : 4'b0000;
     SLTU: Result = (A < B) ? 4'b0001 : 4'b0000;
     NOT_A: Result = ~A;
     SLL: Result = A << 1;
     SRL: Result = A >> 1;
     PASS_A: Result = A;
     
     default Result = 4'b0000;
     
    endcase
    
    zero=(Result==4'b0000);
    negative = Result[3];
 end
    
endmodule
