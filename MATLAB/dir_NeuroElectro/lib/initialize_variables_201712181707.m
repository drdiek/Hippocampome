function [header, firstColumn] = initialize_variables()
    % initialize variables for NeuroElectro() %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Initializing variables ...');
    
    [nos, txt, raw] = xlsread('article_ephys_metadata_curated_1st_column.csv');

    header = txt(1,1);
    
    firstColumn = txt(:,1);

end % initialize_variables()