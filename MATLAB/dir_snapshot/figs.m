function figs()

    zipFileName = sprintf('figs_%s.zip', datestr(now, 'yyyymmdd'));

    if (exist(zipFileName, 'file') == 2)
        delete(zipFileName);
    end
    
    if (exist('figs.txt', 'file') == 2)
        delete('figs.txt');
    end
    
    diary figs.txt;
    
    status = system(['zip -r ', zipFileName, ' "C:\Users\Diek\Dropbox\v2.0_figs"'])

    diary off;
    
    status = system(['move ', zipFileName, ' C:\Users\Diek\Dropbox\Hippocampome_Snapshot\', zipFileName])
    
end % snapshot