function [PMIDs] = initialize_variables()
    % initialize variables for pubmed() %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Initializing variables ...');
    
    [PMIDs.numbers, PMIDs.text, PMIDs.raw] = xlsread('PMIDs.xlsx', 'PMIDs');
    
    for i = 1:length(PMIDs.numbers)
        PMIDs.string{i} = num2str(PMIDs.numbers(i));
    end
    
end % initialize_variables()