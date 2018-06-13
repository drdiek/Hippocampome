function numStr = num2nDigits(num, nDigits)

    lenNum = length(num);
    
    for i = 1:lenNum
	
	numStr(i,:) = int2str(num(i));
	
	strDigits = length(numStr);
	
	if (strDigits < nDigits)
	    numStr = [repmat('0',1,nDigits-strDigits) numStr];
	end
	
    end
    
% end num2fourDigits
