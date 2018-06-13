function [PMIDs] = initialize_variables()
    % initialize variables for pubmed() %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Initializing variables ...');
    
    [articleInfo.numbers, articleInfo.text, articleInfo.raw] = xlsread('article_201610141752.xlsx', 'article_201610141752');
    [newPMIDs.numbers, newPMIDs.text, newPMIDs.raw] = xlsread('URD_new_entries.xlsx', 'URD_new_entries');
    
    PMIDs.old = articleInfo.numbers(:,1);
    PMIDs.new = newPMIDs.numbers(:,1);

    j = 1;
    for i = 1:length(PMIDs.new)
        idx = find(PMIDs.old == PMIDs.new(i));
        if isempty(idx)
            PMIDs.uniqueStr{j} = num2str(PMIDs.new(i));
            j = j + 1;
        end 
    end
    
end % initialize_variables()