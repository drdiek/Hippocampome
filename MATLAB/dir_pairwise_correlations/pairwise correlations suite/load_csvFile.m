function [cells, isFileLoaded] = load_csvFile(fileName)

% Attempts to open a connection to the specified file.  If file is not
% found, display message and allow the user to choose a different file name.
    
    fileFid = fopen(fileName, 'r');

    if (fileFid == -1)

        disp(' ');
        disp('****File not found. Please try a different file name and RELOAD****');
        isFileLoaded = 0;
        pause
        cells = [];

    else

        status = fclose(fileFid);

        cells = csv2cell(fileName,'fromfile');

        isFileLoaded = 1;

    end % if (fileFid == -1)

%end % load_csvFile


