function raw = read_data_file(dataFileName, i)

    strng = sprintf('\nLoading data file #%d ...', i);
    disp(strng);
    [num, txt, raw] = xlsread(dataFileName);
    
    % fourth column is NMO ID
    [numsSorted, idx] = sort(num(:,4));
    N = length(idx);
    
    % account for header row
    raw(2:N+1,:) = raw(1+idx, :);
    
end % read_data_file()
