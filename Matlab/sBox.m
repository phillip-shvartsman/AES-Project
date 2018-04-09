function [ out ] = sBox( in )
%AES S-Box
inv = gfInv(in,8); %Invert input
pp = 283;

s = de2bi(inv.x,8); %Take s as the inverted value in binary
add = uint32(de2bi(99,8)); %Add value in binary
result = de2bi(0,8); %Temp results
for i=1:5
    result = xor(result,s); %XOR 5 Times
    buffer = s(8);
    s(2:8) = s(1:7);
    s(1) = buffer;
end
out = xor(result,add);
out = gf(bi2de(out),8,pp);
end

