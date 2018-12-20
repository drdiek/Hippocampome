function figureFileNameOutput = move_and_rename(figureFileNameInput,cellIdStr,markerStr)
% This function clones a copy of the base figure and renames the clone to include the Cell ID and the marker

    % Replace forward slashes, back slashes, and spaces with underscore
    % characters for marker names to be included in the name of the output
    % figure file
    markerStr = replace_slashes_and_spaces(markerStr);
    
    % set the path to the file and folder folder containing the base figure file
	figurePathFileNameInput = sprintf('attachment_marker_figures_input/%s',figureFileNameInput);
            
    % set the path to the folder destination for the cloned base figure file
    figurePathOutput = sprintf('attachment_marker_figures_output/');
    
    % clone the base figure file
    copyfile(figurePathFileNameInput,figurePathOutput,'f');
    
    % set the path to the file and folder containing the cloned base figure file
    figurePathFileNameInput = sprintf('attachment_marker_figures_output/%s',figureFileNameInput);
    
    % set the new name of the freshly cloned figure file by appending the Cell ID and marker
    figureFileNameOutput = sprintf('%s-Cell%s-%s.jpeg',figureFileNameInput(1:end-5),cellIdStr,markerStr);
    
    % set the path to the file and folder destination for the freshly
    % cloned base figure file
    figurePathFileNameOutput = sprintf('attachment_marker_figures_output/%s',figureFileNameOutput);
    
    % rename the freshly cloned base figure file
    movefile(figurePathFileNameInput,figurePathFileNameOutput);

end