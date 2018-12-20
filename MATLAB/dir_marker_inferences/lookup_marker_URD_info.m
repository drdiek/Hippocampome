function [author,title,journal,year,PMID,figureFileName] = lookup_marker_URD_info(i,urdNum,urdTxt,urdRaw)
% This function looks up information from the marker URD that will be used to populate the output attachment inferences file

    author = urdTxt{i,14};
    
    title = urdTxt{i,15};
    
    journal = urdTxt{i,16};
    
    figureFileName = urdTxt{i,19};
   
    % urdNum skips the header row of the URD file, which only contains text
    % column headers. 
    % ReferenceID is the first column that contains a number and it is in
    % column #3 of the URD file
    year = urdNum(i-1,17-2);

    PMID = urdNum(i-1,18-2);
    
end