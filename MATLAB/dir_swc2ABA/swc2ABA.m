function swc2ABA()

    clear all;    

    addpath(genpath('lib'),'data');

    %%%% code borrowed from ABA
    %
    % Download and unzip the atlasVolume and annotation zip files
 
    strng = sprintf('\nLoading annotation labels file ...');
    disp(strng);
    
    % 25 micron volume size
    size = [528 320 456];
    % ANO = 3-D matrix of annotation labels
    fid = fopen('annotation.raw', 'r', 'l' );
    ANO = fread( fid, prod(size), 'uint32' );
    fclose( fid );
    ANO = reshape(ANO,size);
    
    max(max(max(ANO)))
    ANO(263:265,221:223,331:333)
    pause
    
    %
    %%%% code borrowed from ABA
 
%    % Display one coronal section
%    figure;imagesc(squeeze(ANO(264,:,:)));colormap(lines);
% 
%    % Display one sagittal section
%    figure;imagesc(squeeze(ANO(:,:,220)));colormap(lines);
    
    dataFileName = select_data_file();
    if strcmp(dataFileName, '!')
        return;
    end

    [ids, X, Y, Z, R, pids] = read_data_file(dataFileName);
    
    reply = select_processing_option(ids, X, Y, Z, R, pids, ANO, dataFileName);
    if strcmp(reply, '!')
        return;
    end
    
end % swc2ABA()

