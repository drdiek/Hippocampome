function [diameters, runningAvgs, nCount, nFormula, N, header] = load_data_file(fileName)

    disp(' ');
    disp(['Loading ', fileName, ' ...']);
    
    cd('./inputs');
    [num, header, raw] = xlsread(fileName);
    cd('../');
    
    diameters = num(:,1);
    runningAvgs = num(:,2);
    nCount = num(:,3);
    nFormula = num(:,4);
    N = size(diameters,1);

end % load_data_file()