function numStr = num2fourDigits(num)
    
    lenNum = length(num);
    
    numStr = repmat(' ', lenNum, 4);
    
    for i = 1:lenNum
	
	strng = ' ';
	
	strng = num2str(num(i));
    
	lenStr = length(strng);
    
	switch lenStr
	 case 1,
	  numStr(i,1:4) = sprintf('000%s', strng);
	 case 2,
	  numStr(i,1:4) = sprintf('00%s', strng);
	 case 3,
	  numStr(i,1:4) = sprintf('0%s', strng);
	 otherwise
	  % do nothing
	end
    end
    
% end num2fourDigits
