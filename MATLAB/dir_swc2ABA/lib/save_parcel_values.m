function save_parcel_values(ids, parcels, X, Y, Z, R, pids, dataFileName)

    N = length(ids);
    
    fullFileName = sprintf('./output/%s_%s.swc', dataFileName, datestr(now, 'yyyymmddHHMMSS'));
    
    fid = fopen(fullFileName, 'w');
    
    for i = 1:N
       
        fprintf(fid, '%d %d %.6f %.6f %.6f %.6f %d\n', ids(i), parcels(i), X(i), Y(i), Z(i), R(i), pids(i));
        
    end
    
    fclose(fid);

end % save_parcel_values()