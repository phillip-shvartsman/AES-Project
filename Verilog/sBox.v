module sBox(in,out);
input wire [7:0] in;
output reg [7:0] out;

wire [3:0] gamma0;
wire [3:0] gamma1;
wire [3:0] gamma1Squared;
wire [3:0] gamma1Plusgamm0;

assign gamma1 = in[7:4];
assign gamma0 = in[3:0];
assign gamma1Plusgamm0 = gamma1 xor gamma0;
gfSquare gamma1Squarer(gamma1, gamma1Squared);


endmodule