function [ out ] = mixColumns( in )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%disp("mixing columns");
%disp(dec2hex(in.x));
mixArray = gf([2,3,1,1],8,283);
out = gf(zeros(1,4),8,283);

out(1) = mixArray(1)*in(1)+mixArray(2)*in(2)+mixArray(3)*in(3)+mixArray(4)*in(4);
out(2) = mixArray(4)*in(1)+mixArray(1)*in(2)+mixArray(2)*in(3)+mixArray(3)*in(4);
out(3) = mixArray(3)*in(1)+mixArray(4)*in(2)+mixArray(1)*in(3)+mixArray(2)*in(4);
out(4) = mixArray(2)*in(1)+mixArray(3)*in(2)+mixArray(4)*in(3)+mixArray(1)*in(4);
end

