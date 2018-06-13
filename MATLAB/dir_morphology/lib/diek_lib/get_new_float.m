function newFloat = get_new_float(oldFloat, minimum)

strng = sprintf('\nThe current value is %.10f', oldFloat);
disp(strng);
newFloat = [];
while (isempty(newFloat))
    newFloat = input('\nEnter a new value or hit <RETURN>: ', 's');
    if (isempty(newFloat))
	newFloat = oldFloat;
    else
	newFloat = str2num(newFloat);
	if (newFloat < minimum)
	    disp(' ');
	    disp('****That is not a valid number. Please try again.****');
	    newFloat = [];
	end
    end % if (isempty(newFloat))
end % while loop

% end get_new_float


