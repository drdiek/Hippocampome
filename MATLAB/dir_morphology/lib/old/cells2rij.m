function [cellReferenceIds, cellNotesInterpretations, areConverted] = cells2rij(cells)
% hippocampome network graphics analysis
% 200904122120 David J. Halimton
%
% adapted from R to MATLAB 20090504 Diek W. Wheeler

    fprintf(1, '\nConverting ...')

    % retrieve references data (manually stored in
    % current_references_data)
    load references.mat

    areConverted = 0;

    % initialize arrays & Rij matrix
    nEntries = size(cells,1)-1;
    nOutputCols = 39;
    Rij = zeros(nEntries, nOutputCols);
   
    cellReferenceIds(1:nEntries,1) = cells([1:nEntries]+rowSkip,referenceIdColNum)
pause
    cellNotesInterpretations(1:nEntries,1) = cells([1:nEntries]+rowSkip,notesInterpretationsColNum)
pause
    areConverted = 1;

end % cells2rij
