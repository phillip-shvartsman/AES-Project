function [ roundKey ] = keyOut( keyArray,transformed ,rcon)
%
%disp('shuffling key');
%disp(keyArray);
roundKey = gf(zeros(1,16),8,283);
rotated = rotateWord(transformed);
%for i = 1:4
%    rotated(i) = sBox(rotated(i));
%end
rotated(1) = rotated(1) + rcon;
j=1;
for i = [1 5 9 13]
    roundKey(i) = rotated(j) + keyArray(i);
    j=j+1;
end
%disp(roundKey);
for i = [1 5 9 13]
    %disp(i);
    roundKey(i+1) = roundKey(i) + keyArray(i+1);
    roundKey(i+2) = roundKey(i+1) + keyArray(i+2);
    roundKey(i+3) = roundKey(i+2) + keyArray(i+3);
    %disp(roundKey);
end

end

