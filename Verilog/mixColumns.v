 module mixColumns(dIn,en,clk,dOut0,dOut1,dOut2,dOut3);

input wire [7:0] dIn;
input wire en;
input wire clk;

output reg [7:0] dOut0;
output reg [7:0] dOut1;
output reg [7:0] dOut2;
output reg [7:0] dOut3;

wire [7:0] dInMult3;
wire [7:0] dInMult2;

reg [7:0] dOutComb0;
reg [7:0] dOutComb1;
reg [7:0] dOutComb2;
reg [7:0] dOutComb3;

ffMult Mult2(dIn,8'b0000_0010,8'h1b,dInMult2);
ffMult Mult3(dIn,8'b0000_0011,8'h1b,dInMult3);
always @* begin
	dOutComb0 <= dIn^(dOut1 & {8{en}});
	dOutComb1 <= dIn^(dOut2 & {8{en}});
	dOutComb2 <= dIn^(dOut3 & {8{en}});
	dOutComb3 <= dIn^(dOut0 & {8{en}});
end
always @(posedge clk) begin
	dOut0<=dOutComb0;
	dOut1<=dOutComb1;
	dOut2<=dOutComb2;
	dOut3<=dOutComb3;
end

endmodule