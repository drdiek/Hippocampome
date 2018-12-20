function [num, txt, raw] = read_somata(somataFileName)

    strng = sprintf('\nLoading somata file ...');
    disp(strng);
    [num, txt, raw] = xlsread(somataFileName, 'somata');
    
end % read_somata()