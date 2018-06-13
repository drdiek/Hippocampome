function newNumber = get_new_number(oldNumber, minimum, isFloatOkay)

strng = sprintf('\nThe current value is');
if (isFloatOkay)
    strng = sprintf('%s %.10f', strng, oldNumber);
else
    strng = sprintf('%s %d.', strng, oldNumber);
end
disp(strng);
newNumber = [];
while (isempty(newNumber))
    newNumber = input('\nEnter a new value or hit <RETURN>: ', 's');
    if (isempty(newNumber))
	newNumber = oldNumber;
    else
	newNumber = str2num(newNumber);
	if isFloatOkay
	    rejected = 0;
	else
	    rejected = (newNumber ~= round(newNumber));
	end
	if (newNumber < minimum | rejected)
	    disp(' ');
	    disp('****That is not a valid number. Please try again.****');
	    newNumber = [];
	end
    end % if (isempty(newNumber))
end % while loop

% end get_new_number


