function [num, rawData] = read_data_file(dataFileName)

    strng = sprintf('\nLoading data file ...');
    disp(strng);
    [num, txt, raw] = xlsread(dataFileName, 'Summary');%, 'A24:BJ169');
    
    [nDataRows,nDataCols] = size(raw);
    
    rawData = raw(24:nDataRows,1:nDataCols);
    
end % read_data_file()
