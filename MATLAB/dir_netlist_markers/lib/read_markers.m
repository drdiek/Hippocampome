function [num, txt, raw] = read_markers(markersFileName)

    strng = sprintf('\nLoading markers file ...');
    disp(strng);
    [num, txt, raw] = xlsread(markersFileName, 'markers');
    
end % read_markers()