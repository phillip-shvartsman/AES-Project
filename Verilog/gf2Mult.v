module gf2Mult(a,b,c);
input wire [1:0] a;
input wire [1:0] b;

output wire [1:0] c;

wire and1;
wire and2;
wire and3;

assign and1 = a[1] & b[1];
assign and2 = (a[1] ^ a[0]) & (b[1] ^ b[0]);
assign and3 = a[0] & b[0];

assign c[1] = and2 ^ and3;
assign c[0] = and1 ^ and3;
endmodule