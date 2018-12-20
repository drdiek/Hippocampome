function [allCount tempAllD]=motif2struct_wei(W)   
    load newMotifLib Mot2

    % stores the instances of 16 types of disconnected dimers
    dd1 = zeros(3,1);
    dd2 = zeros(3,1);
    dd3 = zeros(3,1);
    dd4 = zeros(3,1);
    dd5 = zeros(3,1);
    dd6 = zeros(3,1);
    dd7 = zeros(3,1);
    dd8 = zeros(3,1);
    dd9 = zeros(3,1);
    dd10 = zeros(3,1);
    dd11 = zeros(3,1);
    dd12 = zeros(3,1);
    dd13 = zeros(3,1);
    dd14 = zeros(3,1);
    dd15 = zeros(3,1);
    dd16 = zeros(3,1);
    
    tempDisconnD = { dd1; dd2; dd3; dd4; dd5; dd6; dd7; dd8; dd9; dd10; dd11; dd12; dd13; dd14; dd15; dd16; };
    
    
    % stores the instances of 32 types of connected dimers
    d1 = zeros(3,1);
    d2 = zeros(3,1);
    d3 = zeros(3,1);
    d4 = zeros(3,1);
    d5 = zeros(3,1);
    d6 = zeros(3,1);
    d7 = zeros(3,1);
    d8 = zeros(3,1);
    d9 = zeros(3,1);
    d10 = zeros(3,1);
    d11 = zeros(3,1);
    d12 = zeros(3,1);
    d13 = zeros(3,1);
    d14 = zeros(3,1);
    d15 = zeros(3,1);
    d16 = zeros(3,1);
    d17 = zeros(3,1);
    d18 = zeros(3,1);
    d19 = zeros(3,1);
    d20 = zeros(3,1);
    d21 = zeros(3,1);
    d22 = zeros(3,1);
    d23 = zeros(3,1);
    d24 = zeros(3,1);
    d25 = zeros(3,1);
    d26 = zeros(3,1);
    d27 = zeros(3,1);
    d28 = zeros(3,1);
    d29 = zeros(3,1);
    d30 = zeros(3,1);
    d31 = zeros(3,1);
    d32 = zeros(3,1);    
    
    tempAllD = { d1; d2; d3; d4; d5; d6; d7; d8; d9; d10; d11; d12; d13; d14; d15; d16; d17; d18; d19; d20; d21; d22; d23; d24; d25; d26; d27; d28; d29; d30; d31; d32; };
    
    
    % stores counts
    tempDisconnCount=zeros(16,1);
    disconnCount=zeros(10,1);
    
    tempCount=zeros(32,1);
    count=zeros(26,1);
       

    
    rowSum = sum(W,2);
    selfConns = diag(W);
    W = W.*~eye(length(W));
       
    for a = 1:size(W,1)
        selfPre = selfConns(a);
        
        if (rowSum(a) > 0)
            EorIpre = 1;
        elseif (rowSum(a) < 0)
            EorIpre = -1;
        end 
        
        for b = 1:size(W,2)
            selfPost = selfConns(b);

            if (rowSum(b) > 0)
                EorIpost = 1;
            elseif (rowSum(b) < 0)
                EorIpost = -1;
            end     
                
            if (W(a,b)==0) && (W(b,a)==0) && (a<b) %count disconnected dimers        
                thisD = [selfPre selfPost EorIpre EorIpost 0;];
                dNum = all(repmat(thisD,size(Mot2,1),1)==Mot2,2);
                
                index = size(tempDisconnD{dNum},2)+1;
                tempDisconnD{dNum}(1,index) = a;
                tempDisconnD{dNum}(2,index) = b;
                tempDisconnCount(dNum) = tempDisconnCount(dNum)+1;                
                
            elseif (W(a,b)~=0) && (W(b,a)~=0) && (a<b) %count connected bi-directional dimers
                backConn = W(b,a);

                thisD = [selfPre selfPost EorIpre EorIpost backConn;];
                dNum = all(repmat(thisD,size(Mot2,1),1)==Mot2,2);

                index = size(tempAllD{dNum},2)+1;
            	tempAllD{dNum}(1,index) = a;
            	tempAllD{dNum}(2,index) = b;           
                tempCount(dNum) = tempCount(dNum)+1;                
            
            elseif ((W(a,b)~=0) && (W(b,a)==0))
                thisD = [selfPre selfPost EorIpre EorIpost 0;];
                dNum = all(repmat(thisD,size(Mot2,1),1)==Mot2,2);

            	index = size(tempAllD{dNum},2)+1;
            	tempAllD{dNum}(1,index) = a;
            	tempAllD{dNum}(2,index) = b;
                tempCount(dNum) = tempCount(dNum)+1;                
            end 
        end
    end



   
    for k=1:16
        tempDisconnD{k}(:,1) = [];
    end
    
    for L=1:32
        tempAllD{L}(:,1) = [];
    end

    
    disconnCount(1) = tempDisconnCount(1);
    disconnCount(2) = tempDisconnCount(2) + tempDisconnCount(5);
    disconnCount(3) = tempDisconnCount(3) + tempDisconnCount(9);
    disconnCount(4) = tempDisconnCount(4) + tempDisconnCount(13);
    disconnCount(5) = tempDisconnCount(6);
    disconnCount(6) = tempDisconnCount(7) + tempDisconnCount(10);
    disconnCount(7) = tempDisconnCount(8) + tempDisconnCount(14);
    disconnCount(8) = tempDisconnCount(11);
    disconnCount(9) = tempDisconnCount(12) + tempDisconnCount(15);
    disconnCount(10) = tempDisconnCount(16);
    
    for n=1:16
        count(n) = tempCount(n);
    end
    count(17) = tempCount(17);
    count(18) = tempCount(18) + tempCount(19);
    count(19) = tempCount(20) + tempCount(21);
    count(20) = tempCount(22) + tempCount(23);
    count(21) = tempCount(24);
    count(22) = tempCount(25) + tempCount(26);
    count(23) = tempCount(27) + tempCount(28);
    count(24) = tempCount(29);
    count(25) = tempCount(30) + tempCount(31);
    count(26) = tempCount(32);    
    
    allCount = cat(1,disconnCount,count);
end

