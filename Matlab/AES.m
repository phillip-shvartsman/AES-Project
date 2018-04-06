removeWarning();
clear; close all; clc;

key = generateFromHex({'75','6E','79','74','46','75','6D','61','20','4B','20','68','67','20','73','54'});

message = generateFromHex({'6F','65','20','20','77','6E','65','6F','54','69','6E','77','20','4E','4F','54'});


keyArray = gf(zeros(1,16),8,283);
keyComb = gf(zeros(1,16),8,283);

storeArray = gf(zeros(1,16),8,283);
storeComb = gf(zeros(1,16),8,283);

shiftArray = gf(zeros(1,3),8,283);
shiftComb = gf(zeros(1,3),8,283);

shiftController = 3;
rcon = gf(1,8,283);

for i=1:999
    
    if(i<=16)
        messageIn = message(i);
        keyComb(1) = key(i);
    else
        messageIn = storeArray(16);
        keyComb(1) = keyArray(16);
    end
    disp('NEW');
    
    keyComb(2:16) = keyArray(1:15);
    
    if(mod(i,16)==0&&i~=0)
        roundKey = keyOut(keyComb,rcon);
        keyComb(2:16) = roundKey(2:16);
    end
    
    sBoxOut = sBox(storeArray(1));
    storeComb(1) = messageIn + keyComb(1); %%%%
    %disp(dec2hex(messageIn.x));
    storeComb(2) = sBoxOut;
    storeComb(3:16) = storeArray(2:15);
    
    shiftComb(1) = sBoxOut;
    shiftComb(2:3) = shiftArray(1:2);
 
    if mod(i-1,4)==0 && i~=1
        shifted = shiftRow([sBoxOut,storeComb(3),storeComb(4),storeComb(5)],shiftController);
        shiftController = shiftController - 1;
        storeComb(2:5) = shifted;
        if shiftController == -1
            shiftController = 3;
        end
        %dispGFMatrixHex(storeComb);
    end
    
    if (mod(i+1,16)==0||mod(i,16)==0||mod(i-1,16)==0||mod(i-2,16)==0)&&i>4
        mixed = mixColumns(gf([storeComb(3),storeComb(7),storeComb(11),storeComb(15)],8,283));
       
        storeComb(3) = mixed(1);
        storeComb(7) = mixed(2);
        storeComb(11) = mixed(3);
        storeComb(15) = mixed(4);
    end
    
    shiftArray = shiftComb;
    keyArray = keyComb;
    storeArray = storeComb;
    disp(dec2hex(storeArray.x));
    if(mod(i,16)==0&&i~=0)
        keyArray(1) = roundKey(1);
    end
    if(mod(i-1,16)==0&&i~=1)
        rcon = rcon * 2;
    end
    
end