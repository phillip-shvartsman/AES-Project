//Multiply ax^3 + bx^2 + cx +d by 0x^3 + 0x^2 + x + 1 in galois field
module multLambda(a,b);
input wire [3:0] a;
output wire [3:0] b;

wire xor1;
wire xor2;
wire xor3;

assign xor1 = a[3] ^ a[1];
assign xor2 = a[2] ^ a[0];
assign xor3 = xor1 ^ xor2;

assign b[0] = a[2];
assign b[1] = a[3];
assign b[2] = xor3;
assign b[3] = xor2;

endmodule