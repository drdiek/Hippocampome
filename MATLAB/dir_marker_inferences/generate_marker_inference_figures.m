function generate_marker_inference_figures()
% This function clones copies of a base figure based on the marker
% inferences that are currently being displayed in the marker matrix

    % Read in information from the URd file
    [urdNum,urdTxt,urdRaw] = xlsread('URD_marker_inf-sample_20151105.csv');
    
    % Read in information from the marker Parameter-Parameter ID lookup table
    [markerID_lookup_table, isFileLoaded] = load_csvFile('attachment_marker_ID_lookup_table.csv');
    
    % Read in information from the marker inference log that is generated
    % when the inferences are being computed for the marker matrix
    [marker_inference_log, isFileLoaded] = load_csvFile('Inference_Applications_Log.csv');
    
    % The prgram will be loopingthrough all of the rows of the marker
    % inference log file to determine which figures to clone
    nLogRows = size(marker_inference_log,1);

    % prepare cell array to hold data that will be written to file at the
    % end of the program. This loads the header columns for the output.
    outputCell = prep_header();
    
    % track the rows of output cell array that will be sent to the file.
    % Row 1 contains the header information for the columns, so the counter
    % starts at Row 2.
    iRow = 2;
    
    % Loop through all of the orws of the marker inference log file
    for iLog = 2:nLogRows
       
        cellIdStr = marker_inference_log{iLog,4};       % Cell_ID column in the marker inference log file
        
        markerStr = marker_inference_log{iLog,5};       % Marker column in the marker inference log file
        
        referenceIdStr = marker_inference_log{iLog,10}; % Reference_ID column in the marker inference log file
        
        % convert the Reference ID string to a number
        referenceId = str2num(referenceIdStr);
        
        % Find the location in the URD file that contains the current
        % Reference ID being examined
        idx = find(urdNum==referenceId);
    
        % Check if the current Reference ID was found in the URD file. If
        % so then procedd with the rest of the program. Else proceed to the
        % next row of the marker inference log file.
        if ~isempty(idx)
        
            % Look up information from the marker URD that will be used to
            % populate the output attachment inferences file. Since urdNum
            % skips the header row, the index is incremented by one before
            % being passed to the function.
            [author,title,journal,year,PMID,figureFileNameInput] = lookup_marker_URD_info(idx+1,urdNum,urdTxt,urdRaw);
            
            % Check if there was a base figure file name listed in the
            % marker URD. If so, then proceed with the rest of the program.
            % Else proceed to the next row fo the marker inference log file.
            if ~isempty(figureFileNameInput)
                
                % Look up marker Parameter ID code from lookup table
                markerId = lookup_marker_parameter_ID(markerStr,markerID_lookup_table);
        
                % Clone a copy of the base figure and rename the clone to
                % include the Cell ID and the marker
                figureFileNameOutput = move_and_rename(figureFileNameInput,cellIdStr,markerStr);
                
                % Determine if the current figure is a figure or a table
                figureOrTable = figure_or_table(figureFileNameOutput);
                
                % set the flag that indicated that these entries for the
                % attachment_marker file are related to inferences
                inferenceFlag = 1;
                
                % Assign the values for the current row of the output attachment_marker file 
                %%%%
                outputCell{iRow,1} = author;
                
                outputCell{iRow,2} = title;
                
                outputCell{iRow,3} = journal;
                
                outputCell{iRow,4} = year;
                
                outputCell{iRow,5} = PMID;
                
                outputCell{iRow,6} = cellIdStr;
                
                outputCell{iRow,7} = markerStr;
                
                outputCell{iRow,8} = markerId;
                
                outputCell{iRow,9} = figureFileNameOutput;
                
                outputCell{iRow,10} = figureOrTable;
                
                outputCell{iRow,11} = referenceId;
                
                outputCell{iRow,12} = ''; % Interpretation notes figures
                
                outputCell{iRow,13} = ''; % Comments
                
                outputCell{iRow,14} = inferenceFlag;
                %%%%
                
                % Increase the counter of the current row of the output
                % attachement_marker inferences file
                iRow = iRow + 1;
                
            end % if ~isempty(figureFileNameInput)
           
        end % if ~isempty(idx)
        
    end % for iLog

    % Write contents of the cell array to the output attachment_marker file
    xlswrite('outputCell.xlsx',outputCell);
    
end % function generate_marker_inference_figures
    
    