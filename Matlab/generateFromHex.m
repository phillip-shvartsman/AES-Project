function [ hexArray] = generateFromHex( in )
%
hexArray = gf(zeros(1,16),8,283);
for i = 1:numel(in)
    hexArray(i) = hex2dec(in(i));
end
end

