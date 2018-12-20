function outputCell = prep_header()
% This function prepares the cell array to hold data that will be written
% to the file at the end of the program. This loads the header columns for
% the output.

    outputCell{1,1} = 'Authors';
    
    outputCell{1,2} = 'Title';
    
    outputCell{1,3} = 'Journal/Book';
    
    outputCell{1,4} = 'Year';
    
    outputCell{1,5} = 'PMID/ISBN';
    
    outputCell{1,6} = 'Cell Identifier';
    
    outputCell{1,7} = 'Parameter';
    
    outputCell{1,8} = 'Parameter_ID';
    
    outputCell{1,9} = 'Name of file containing figure';
    
    outputCell{1,10} = 'Figure/Table';
    
    outputCell{1,11} = 'Quote reference id';
    
    outputCell{1,12} = 'Interpretation notes figures';
    
    outputCell{1,13} = 'Comments';
    
    outputCell{1,14} = 'Inference_flag';

end