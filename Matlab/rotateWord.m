function [ out ] = rotateWord( in )
%Rotate a word for key expansion
out = gf(zeros(1,4),8,283);
out(4) = in(1);
out(3) = in(4);
out(2) = in(3);
out(1) = in(2);
end

