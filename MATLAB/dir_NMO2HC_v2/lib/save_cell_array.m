function save_cell_array(cellArray)
    disp(' ');
    strng = sprintf('Writing cell array to file ...');
    disp(strng);
    
    dataStructFileName = sprintf('./output/cellArray_%s.xlsx', datestr(now, 'yyyymmddHHMMSS'));

    xlswrite(dataStructFileName, cellArray);

end % save_cell_array()