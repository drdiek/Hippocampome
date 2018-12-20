function newString = get_new_string(oldString)

newString = [];

while (isempty(newString))

    prompt = sprintf(['\nPlease enter the new string or ' ...
		      'hit <RETURN> to keep the old string: ']);

    newString = input(prompt, 's');

    if isempty(newString)

	newString = oldString;

    end % isempty(newPrefix)

end % while loop

end % get_new_string


