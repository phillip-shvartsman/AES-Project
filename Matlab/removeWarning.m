function [ ] = removeWarning()
%Removes the warning do to irreducable but not primitive polynomial
temp = gf(0,8,283);
warning('off','last');
end

