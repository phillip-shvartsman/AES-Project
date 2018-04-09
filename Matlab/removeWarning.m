function [ ] = removeWarning()
%Removes the matlab warning due to irreducable but not primitive polynomial
temp = gf(0,8,283);
warning('off','last');
end

