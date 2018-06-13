function save_crossover_data(fileName, header, diameters, runningAvgs, nCount, nFormula)

    N = length(diameters);

    idx = strfind(fileName, '.xlsx');
    i = length(idx);
    base = fileName(1:idx(i)-1);
    outFileName = sprintf('%s_cross-over_%s.csv', base, datestr(now, 'yyyymmddHHMM'));
    
    disp(['Saving ', outFileName, ' ...']);
    
    cd('./output');
    fid = fopen(outFileName, 'w');
    fprintf(fid, '%s,%s,%s,%s\n', header{1}, header{2}, header{3}, header{4});
    for i = 1:N
        fprintf(fid, '%f,%f,%d,%f\n', diameters(i), runningAvgs(i), nCount(i), nFormula(i));
    end
    fclose(fid);
    cd('../');

end % save_crossover_data()