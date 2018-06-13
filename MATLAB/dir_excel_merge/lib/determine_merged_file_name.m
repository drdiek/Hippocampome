function fileNameMerged = determine_merged_file_name(fileName1, fileName2)

    i = 1;
    while strcmp(fileName1(i), fileName2(i))
        i = i + 1;
    end
    if strcmp(fileName1(i-1), '_')
        i = i - 1;
    end
    fileNameMerged = fileName1(1:i-1);
    
    fileNameMerged = sprintf('./output/%s_merged_%s.xlsx', fileNameMerged, datestr(now, 'yyyymmddHHMMSS'));

end % determine_merged_file_name