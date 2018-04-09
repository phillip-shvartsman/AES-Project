function [ hexArray] = generateFromHex( in )
%Generate a galois field array object from a list of hex strings
hexArray = gf(zeros(1,16),8,283);
for i = 1:numel(in)
    hexArray(i) = hex2dec(in(i));
end
end

