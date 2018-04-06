module gfInverter(in,out);
input wire [7:0] in;
output wire [7:0] out;

wire [3:0] G1;
wire [3:0] G0;
assign G1 = in[7:4];
assign G0 = in[3:0];

wire [3:0] G1Square;
wire [3:0] upperIn;

wire [3:0] lowerIn;

wire [3:0] inverted;



gf4Square G1Squarer(G1,G1Square);
multLambda G1XLamba(G1Square,G1SquareXLambda);

gf4Mult lowerMult(G1^G0,G0,lowerIn);

gf4Inv inverter(lowerIn^G1SquareXLambda,inverted);

gf4Mult upperOut(inverted,G1,out[7:4]);
gf4Mult lowerOut(inverted,G1^G0,out[3:0]);
endmodule