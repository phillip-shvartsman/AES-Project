module gf4Mult(a,b,c);
input wire [3:0] a,b;
output wire [3:0] c;

wire  [1:0]U1;
wire [1:0]U0;
wire [1:0]L1;
wire[1:0] L0;

assign U1 = a[3:2];
assign U0 = a[1:0];

assign L1 = b[3:2];
assign L0 = b[1:0];

wire [1:0] mult1Out;
wire [1:0] mult2Out;
wire [1:0] mult3Out;
wire [1:0] phiOut;

gf2Mult mult1(U1,L1,mult1Out);
gf2Mult mult2((U1^U0),(L1^L0),mult2Out);
gf2Mult mult3(U0,L0,mult3Out);

multPhi multPhi(mult1Out,phiOut);

assign c[3:2] = mult2Out ^ mult3Out;
assign c[1:0] = phiOut ^ mult3Out; 
endmodule