module gfSquareTB();
reg [3:0] a;
wire [3:0] c;
gf4Square uut(a,c);
initial begin
	a = 4'd0;
end
always begin
	#5 a = a + 1'd1;
end
endmodule