function current_references_data

    % manually specifies location and type of data in cells
      
    % indicates order of subregions
    nSubregions = 6;
    DG  = 1;
    CA3 = 2;
    CA2 = 3;
    CA1 = 4;
    SUB = 5;
    EC  = 6;    
    
    % specify how many rows and columns contain header data
    rowSkip = 1; % rows to skip
    
    referenceIdColNum          = 1;
    cellTypeColNum             = 2;
    materialUsedColNum         = 3;
    notesInterpretationsColNum = 4;
    isReinterpretedColNum      = 5;
    locationInReferenceColNum  = 6;
    authorsColNum              = 7;
    titleColNum                = 8;
    journalBookColNum          = 9;
    yearColNum                 = 10;
    pmidIsbnColNum             = 11;
    
    save references.mat *

