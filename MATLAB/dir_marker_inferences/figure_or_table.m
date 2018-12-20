function figureOrTable = figure_or_table(figureFileNameOutput)
% This function determines if the current figure is a figure or a table

    idx = strfind(figureFileNameOutput,'-Fig');
    
    if idx
        
        figureOrTable = 'marker_figure';
        
    else
        
        figureOrTable = 'marker_table';
        
    end

end