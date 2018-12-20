function [ids, X, Y, Z, R, pids] = read_data_file(dataFileName)

    strng = sprintf('\nLoading data file ...');
    disp(strng);
    
    fileId = fopen(dataFileName);
    C = textscan(fileId,'%d %d %f %f %f %f %d','CommentStyle','#');
    fclose(fileId);

    % id,type,x,y,z,r,pid
    
    ids = C{1};
    types = C{2};
    X = C{3};
    Y = C{4};
    Z = C{5};
    R = C{6};
    pids = C{7};
    
end % read_data_file()
