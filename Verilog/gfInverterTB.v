module gfInverterTB();
reg [7:0] a;
wire [7:0] c;
gfInverter uut(a,c);


initial begin 
a = 8'd0;
end
always begin
#10 a = a + 1;
end
endmodule