function [] = dispGFIndexHEX( gf,index )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
gfx = gf.x;

disp(dec2hex(gfx(index)));
end

