function newInteger = get_new_integer(oldInteger, minimum)

strng = sprintf('\nThe current value is %d.', oldInteger);
disp(strng);
newInteger = [];
while (isempty(newInteger))
    newInteger = input('\nEnter a new value or hit <RETURN>: ', 's');
    if (isempty(newInteger))
	newInteger = oldInteger;
    else
	newInteger = str2num(newInteger);
	rejected = (newInteger ~= round(newInteger));
	if (newInteger < minimum | rejected)
	    disp(' ');
	    disp('****That is not a valid number. Please try again.****');
	    newInteger = [];
	end
    end % if (isempty(newInteger))
end % while loop

% end get_new_integer


