function [ out ] = shiftRow( in,i )
%Shifts a column around
%disp("shifting rows");
out = gf(zeros(1,4),8,283);
if i == 0
    out(1) = in(1);
    out(2) = in(2);
    out(3) = in(3);
    out(4) = in(4);
elseif i == 1
    out(1) = in(2);
    out(2) = in(3);
    out(3) = in(4);
    out(4) = in(1);
elseif i == 2
    out(1) = in(3);
    out(2) = in(4);
    out(3) = in(1);
    out(4) = in(2);
elseif i == 3
    out(1) = in(4);
    out(2) = in(1);
    out(3) = in(2);
    out(4) = in(3);
end
end

