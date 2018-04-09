function [ roundKey ] = keyOut( keyArray,transformed ,rcon)
%Generates a new round key from an old one based on an rcon value

roundKey = gf(zeros(1,16),8,283);
rotated = rotateWord(transformed);

rotated(1) = rotated(1) + rcon;
j=1;
for i = [1 5 9 13]
    roundKey(i) = rotated(j) + keyArray(i);
    j=j+1;
end

for i = [1 5 9 13]
    roundKey(i+1) = roundKey(i) + keyArray(i+1);
    roundKey(i+2) = roundKey(i+1) + keyArray(i+2);
    roundKey(i+3) = roundKey(i+2) + keyArray(i+3);
end

end

