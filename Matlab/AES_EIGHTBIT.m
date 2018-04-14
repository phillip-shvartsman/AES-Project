removeWarning();

clear; close all; clc;

%Generate a Key from Hex Values
key = generateFromHex({'75','6E','79','74','46','75','6D','61','20','4B','20','68','67','20','73','54'});

%Generate a Message from Hex Values
message = generateFromHex({'6F','65','20','20','77','6E','65','6F','54','69','6E','77','20','4E','4F','54'});
disp("Message")
disp(dec2hex(message.x));

%The Output Combinational Logic and DFF Array for the Output
outComb = gf(zeros(1,16),8,283);
outStore = gf(zeros(1,16),8,283);

%The combinational Logic and DFF Array for the Key 
keyArray = gf(zeros(1,16),8,283);
keyComb = gf(zeros(1,16),8,283);

%The combinational Logic and DFF Array for the State
storeArray = gf(zeros(1,16),8,283);
storeComb = gf(zeros(1,16),8,283);

%The combinational Logic and DFF Array for the S-Boxed Key
shiftKeys = gf(zeros(1,15),8,283);
shiftComb = gf(zeros(1,15),8,283);

%Shift Controller
shiftController = 3;

%Starting RCON
rcon = gf(1,8,283);

%The clock cycles needed
for i=1:176
    
    %Read in message and key for the first 16 clk cycles the 
    if(i<=16)
        messageIn = message(i);
        keyComb(1) = key(i);
    else
        messageIn = storeArray(16);
        keyComb(1) = keyArray(16);
    end
    
    %Combinational Key Logic is from Previous DFF
    keyComb(2:16) = keyArray(1:15);
    
    %Output of subBytes Operation
    storeComb(1) = sBox(messageIn + keyComb(1)); 
    
    %Combinational State Logic is from Previous DFF
    storeComb(2:16) = storeArray(1:15);
    
    %S-Box Output for Key Input and Combinational Logic
    shiftComb(1) = sBox(keyComb(1));
    shiftComb(2:15) = shiftKeys(1:14);
    
    %Shift the four registers around every 4 clock cycles
    if mod(i-1,4)==0 && i ~=1
        shifted = shiftRow([storeComb(2),storeComb(3),storeComb(4),storeComb(5)],shiftController);
        %New shift controller output after every shift
        shiftController = shiftController - 1;
        storeComb(2:5) = shifted;
        if shiftController == -1
            shiftController = 3;
        end
    end
    
    %Generate New Round Key Every 16 clock cycles
    if(mod(i,16)==0&&i~=0)
        roundKey = keyOut(keyComb,shiftKeys([3 7 11 15]),rcon);
        keyComb(2:16) = roundKey(2:16);
    end
    
    %Mix Columns at Designated Times
    if (mod(i+2,16)==0||mod(i+1,16)==0||mod(i,16)==0||mod(i-1,16)==0)&&i>4&&i<150
        mixed = mixColumns(gf([storeComb(2),storeComb(6),storeComb(10),storeComb(14)],8,283));
       
        storeComb(2) = mixed(1);
        storeComb(6) = mixed(2);
        storeComb(10) = mixed(3);
        storeComb(14) = mixed(4);
    end
     %Start Loading into Output after 160 clk cycles
    if i > 160
        outComb(1) = messageIn + keyComb(1);
        outComb(2:16) = outStore(1:15);
    end
    
    %Load DFFs with Combinational Logic
    shiftKeys = shiftComb;
    keyArray = keyComb;
    storeArray = storeComb;
    outStore = outComb;
    
    %Manually set the first key DFF from the new generated round key
    if(mod(i,16)==0&&i~=0)
        keyArray(1) = roundKey(1);
    end
    
    %Increment rcon every 160 clk cycles
    if(mod(i,16)==0&&i~=1)
        rcon = rcon * 2;
    end
end
%Display output
disp("Encrypted");
disp(dec2hex(outStore.x));