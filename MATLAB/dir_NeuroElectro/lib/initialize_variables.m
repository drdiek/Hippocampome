function [header, data2Save] = initialize_variables(fileName)
    % initialize variables for NeuroElectro() %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Initializing variables ...');
    
    % data file has already been preprocessed
    % 1) Full database download of csv file from NeuroElectro.org
    % 2) csv file is retagged as a txt file
    % 3) txt file is read into Excel as tab delimited and text qualifier: {none}
    % 4) all " characters are removed from the first column
    % 5) file is saved as an xlsx file
    
    fileNameFull = sprintf('./data/%s', fileName);
    
    [nos, txt, raw] = xlsread(fileNameFull);

    % Load data from file from columns "Index" through to "PrepType"
    header = [txt(1,1:7) 'HippocampomeID' 'ExclusionReason' txt(1,8:17)];
    data = raw(2:end,1:17);
    
    % Remove spurious rows of data by checking for TRUE/FALSE value for "MetadataCurated" column
    N = size(data,1);
    i = 1;
    while (i <= N)
        if (~isempty(cell2mat(data(i,14))) && (sum(cell2mat(data(i,13))) ~= 1) && (sum(cell2mat(data(i,13))) ~= 0))
            data(i:N-1,:) = data(i+1:N,:);
            N = N - 1;
        else
            i = i + 1;
        end
    end % i

    size(data(1:N,1:7))
    size(repmat(' ',N,1))
    size(data(1:N,8:17))
    data2Save = [data(1:N,1:7) repmat(' ',N,1) repmat(' ',N,1) data(1:N,8:17)];

%     for i = 1:N
%         data2Save(i,:) = [data(i,1:7) ' ' ' ' data(i,8:17)];
%     end
    
end % initialize_variables()