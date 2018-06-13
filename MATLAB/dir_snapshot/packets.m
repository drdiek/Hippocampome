function packets()

    zipFileName = sprintf('packets_%s.zip', datestr(now, 'yyyymmdd'));

    if (exist(zipFileName, 'file') == 2)
        delete(zipFileName);
    end
    
    if (exist('packets.txt', 'file') == 2)
        delete('packets.txt');
    end
    
    diary packets.txt;
    
    status = system(['zip -r ', zipFileName, ' "C:\Users\Diek\Dropbox\HC database"'])
    
    diary off;
    
    status = system(['move ', zipFileName, ' C:\Users\Diek\Dropbox\Hippocampome_Snapshot\', zipFileName])
    
end % snapshot