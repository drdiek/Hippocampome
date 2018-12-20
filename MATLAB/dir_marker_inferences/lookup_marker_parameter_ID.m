function markerId = lookup_marker_parameter_ID(markerStr,markerID_lookup_table)
% This function looks up the marker Parameter ID code from lookup table
    
    % determine the number of rows in the lookup table
    nRows = size(markerID_lookup_table,1);
    
    % Initialize the Marker ID code to zero. If it remains zero then the
    % current marker was not to be found in the lookup table.
    markerId = 0;
    
    % Loop through the rows of the lookup table
    for i = 2:nRows

        % Check to see if the current marker is found in the current row of
        % the loopup table
        isMarkerFound = strfind(markerID_lookup_table{i,1},markerStr);

        % If the current marker is found in the lookup table then determine
        % the associated Marker ID code
        if isMarkerFound
            
            % Assign the Marker ID code and make sure that it is stored as
            % a number variable
            markerId = str2num(markerID_lookup_table{i,2});
    
        end % if isMarkerFound
        
    end % for i
    
end