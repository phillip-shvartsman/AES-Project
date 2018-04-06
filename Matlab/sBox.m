function [ out ] = sBox( in )
%sBox 
inv = gfInv(in,8);
pp = 283;
d = [uint32(de2bi(248,8));de2bi(248/2,8);de2bi(248/4,8);de2bi(248/8,8);
    de2bi(143,8);de2bi(199,8);de2bi(227,8);de2bi(241,8)];
d = flipud(d);
s = de2bi(inv.x,8);
add = uint32(de2bi(99,8));
result = de2bi(0,8);
for i=1:5
    result = xor(result,s);
    buffer = s(8);
    s(2:8) = s(1:7);
    s(1) = buffer;
end
out = xor(result,add);
out = gf(bi2de(out),8,pp);
end

