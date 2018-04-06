function [ invGF] = gfInv( gf,m )
%gfInv Inverts a gf using Matlab code
invGF = gf^((2^m)-2);
end

