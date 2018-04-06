//Multipy ax+b in galois field by x+0;
module multPhi(in,out);
input wire [1:0] in;
output wire [1:0] out;

assign out[1] = in[1] ^ in[0];
assign out[0] = in[1];
endmodule