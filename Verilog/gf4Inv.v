module gf4Inv(in,out);
input wire [3:0] in;
output wire [3:0] out;

wire and321;
wire and320;
wire and310;

assign and321 = in[3]&in[2]&in[1];
assign and320 = in[3]&in[2]&in[0];
assign and310 = in[3]&in[1]&in[0];
assign and30 = in[3]&in[0];
assign and21 = in[2]&in[1];
assign and20 = in[2]&in[0];

assign out[3] = in[3] + and321 + and30 + in[2];
assign out[2] = and321 + and320+ and30 +in[2]+ and21;
assign out[1] = in[3] + and321 + and310 + in[2] + and20 + in[1];
assign out[0] = and321 + and320+ (in[3]&in[1]) + and310 + and30 +in[2] + and21 + (in[2]&in[1]&in[0]) + in[1] + in[0];

endmodule