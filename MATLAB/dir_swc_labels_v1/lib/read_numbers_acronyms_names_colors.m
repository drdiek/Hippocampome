function pNANC = read_numbers_acronyms_names_colors(isARA)

%     fid = fopen('./data/Ontology_v3.csv');
%     data = textscan(fid, '%u%s%s%s','Delimiter',',')
%     pause
%     fclose(fid);
    
%     fid = fopen('./data/parcelNumbersAcronymsNamesColors.csv', 'r');
%     data = fscanf(fid, '%u,"%s","%s","%s"', [4 inf])
%     pause
    
%     data = readtable('./data/parcelNumbersAcronymsNamesColors.xls','ReadVariableNames',false);

    if isARA
        data = readtable('./data/Ontology_v2.xls','ReadVariableNames',true);
        pNANC.numbers = data{:,1};
        pNANC.acronyms = data{:,3};
        pNANC.names = data{:,2};
        size(data,1)
        pause
        for i = 1:size(data,1)
            colors{i} = sprintf('#%s%s%s', dec2hex(data{i,4}), dec2hex(data{i,5}), dec2hex(data{i,6}));
%             pNANC.colors{i} = {['#', dec2hex(data{i,4}), dec2hex(data{i,5}), dec2hex(data{i,6})]};
        end
        pNANC.colors = cellstr(colors);
    else
        data = readtable('./data/Ontology_v3.xls','ReadVariableNames',false);
        pNANC.numbers = data{:,1};
        pNANC.acronyms = data{:,2};
        pNANC.names = data{:,3};
        pNANC.colors = data{:,4};
    end
    
end % read_numbers_acronyms_names_colors()