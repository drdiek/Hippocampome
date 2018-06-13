function PMID_lookup()
    
    addpath data lib output

    [PMIDs] = initialize_variables();
    
    fileName = sprintf('output/pubmed_citation_%s.csv', datestr(now, 'yyyymmddHHMMSS'));
    fid = fopen(fileName,'w');
    fprintf(fid, 'Authors,Title,Journal/Book,Year,PMID/ISBN\n');
        
    for i = 1:length(PMIDs.string)
        pmstruct = get_pubmed_info(PMIDs.string{i});
%         pmstruct.Authors = 'Martinez A, Lubke J, Del Rio JA, Soriano E, Frotscher M';
%         pmstruct.Title = 'Regional variability and postsynaptic targets of chandelier cells, in the hippocampal formation of the rat.';
%         pmstruct.Publication = 'A regional variability and postsynaptic targets of a chandelier cells, in the hippocampal formation of the rat for.';
% %         pmstruct.Publication = 'Journal of comparative neurology';
%         pmstruct.Year = '1996';
%         pmstruct.PMID = '8946282';
        pmstruct.Publication = correct_capitalization(pmstruct.Publication);
        fprintf(fid,'"%s","%s","%s",%s,%s\n',...
            pmstruct.Authors,...
            pmstruct.Title,...
            pmstruct.Publication,...
            pmstruct.Year,...
            pmstruct.PMID);
    end
    fclose(fid);
    
end % PMID_lookup()