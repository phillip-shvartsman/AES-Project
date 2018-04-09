removeWarning();

clear; close all; clc;

key = generateFromHex({'75','6E','79','74','46','75','6D','61','20','4B','20','68','67','20','73','54'});
message = generateFromHex({'6F','65','20','20','77','6E','65','6F','54','69','6E','77','20','4E','4F','54'});

outComb = gf(zeros(1,16),8,283);
outStore = gf(zeros(1,16),8,283);

keyArray = gf(zeros(1,16),8,283);
keyComb = gf(zeros(1,16),8,283);

storeArray = gf(zeros(1,16),8,283);
storeComb = gf(zeros(1,16),8,283);

shiftKeys = gf(zeros(1,4),8,283);
shiftComb = gf(zeros(1,4),8,283);

shiftController = 3;
rcon = gf(1,8,283);

for i=1:176
    
    if(i<=16)
        messageIn = message(i);
        keyComb(1) = key(i);
    else
        messageIn = storeArray(16);
        keyComb(1) = keyArray(16);
    end
    
    keyComb(2:16) = keyArray(1:15);
    sBoxOut = sBox(storeArray(1));
    storeComb(1) = sBox(messageIn + keyComb(1)); 
    storeComb(2:16) = storeArray(1:15);
    
    
    if mod(1+i,4)==0
        shiftComb(1) = sBox(keyComb(3));
        shiftComb(2:4) = shiftKeys(1:3);
    end
    if mod(i,4)==0 && i~=1
        shifted = shiftRow([storeComb(1),storeComb(2),storeComb(3),storeComb(4)],shiftController);
        shiftController = shiftController - 1;
        storeComb(1:4) = shifted;
        if shiftController == -1
            shiftController = 3;
        end
        
    end
    %Generate New Round Key
    if(mod(i,16)==0&&i~=0)
        roundKey = keyOut(keyComb,shiftKeys,rcon);
        keyComb(2:16) = roundKey(2:16);
    end
    %Mix Columns
    if (mod(i+2,16)==0||mod(i+1,16)==0||mod(i,16)==0||mod(i-1,16)==0)&&i>4&&i<150
        mixed = mixColumns(gf([storeComb(2),storeComb(6),storeComb(10),storeComb(14)],8,283));
       
        storeComb(2) = mixed(1);
        storeComb(6) = mixed(2);
        storeComb(10) = mixed(3);
        storeComb(14) = mixed(4);
    end
    
    shiftArray = shiftComb;
    keyArray = keyComb;
    storeArray = storeComb;
    if i > 160
        outComb(1) = messageIn + keyComb(1);
        outComb(2:16) = outStore(1:15);
    end
    if(mod(i,16)==0&&i~=0)
        keyArray(1) = roundKey(1);
    end
    if(mod(1+i,4)==0)
        shiftKeys = shiftComb;
    end
    if(mod(i,16)==0&&i~=1)
        rcon = rcon * 2;
    end
    outStore = outComb;
end
disp(dec2hex(outStore.x));