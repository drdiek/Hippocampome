function nTabs = find_single_neurite_differences(overlapMatrix, ...
                                                 nOfficialParcellations, ...
                                                 nTabs, cellLabels, ...
                                                 cellADcodes, ...
                                                 cellSubregions, ...
                                                 cellEorI, regionCode, ...
                                                 printStart, printEnd, ...
                                                 vTab, hTab);

load isInclude.mat
 
[nRows, nCols] = size(overlapMatrix);
% nRows-1 = printEnd-printStart+1

nSingleNeuriteDiffs = 0;
nSingleNeuriteDiffsTotal = 0;

isGreen = 0;

ALL = 0;
DG  = 1;
CA3 = 2;
CA2 = 3;
CA1 = 4;
SUB = 5;
EC  = 6;

diffFileName = sprintf('diffs_by_1_neurite.csv');

switch (regionCode)
  case ALL
    diffFileName = sprintf('./ALL_%s', diffFileName);
  case DG
    diffFileName = sprintf('./DG_%s', diffFileName);
  case CA3
    diffFileName = sprintf('./CA3_%s', diffFileName);
  case CA2
    diffFileName = sprintf('./CA2_%s', diffFileName);
  case CA1
    diffFileName = sprintf('./CA1_%s', diffFileName);
  case SUB
    diffFileName = sprintf('./SUB_%s', diffFileName);
  case EC
    diffFileName = sprintf('./EC_%s', diffFileName);
end

fid = fopen(diffFileName, 'w');

for iRow = 1:printEnd-printStart+1-2

    for jRow = iRow+1:printEnd-printStart+1-1

        if ( (~isIncludeAcrossEINeuriteDifferences) && ...
             (cellEorI{iRow} == cellEorI{jRow}) || ...
             isIncludeAcrossEINeuriteDifferences )
 
            diffIJ = abs(overlapMatrix(iRow,:)-overlapMatrix(jRow,:));
            
            sumDiffIJ = sum(diffIJ);
            
            nTwoDiffIJ = length(find(diffIJ == 2));
            
            % check for differences of a single axon or dendrite
            if ( (sumDiffIJ == 1) | ... % 1 axon
                 ((sumDiffIJ == 2) & (nTwoDiffIJ == 1)) ) % 1 dendrite
                
                nSingleNeuriteDiffs = nSingleNeuriteDiffs + 1;
                nSingleNeuriteDiffsTotal = nSingleNeuriteDiffsTotal + 1;
                
                if ((nSingleNeuriteDiffs == 95) & (isGreen == 0))
                    nSingleNeuriteDiffs = 1;
                    isGreen = 1;
                end
                
                if (nTabs(iRow) > nTabs(jRow))
                    nTabs(jRow) = nTabs(iRow);
                end
                if (nTabs(jRow) > nTabs(iRow))
                    nTabs(iRow) = nTabs(jRow);
                end
                
                if isGreen
                    
                    text(iRow+0.5, 0.6 - nTabs(iRow)*0.3, char(32+nSingleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'g');
                    text(jRow+0.5, 0.6 - nTabs(jRow)*0.3, char(32+nSingleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'g');
                    
                else
                    
                    text(iRow+0.5, 0.6 - nTabs(iRow)*0.3, char(32+nSingleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'b');
                    text(jRow+0.5, 0.6 - nTabs(jRow)*0.3, char(32+nSingleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'b');
                    
                end
                
                fprintf(fid, '1-neurite, %s, %s, %s\n1-neurite, %s, %s, %s\n\n', ...
                        cellSubregions{printStart+iRow-1}, ...
                        cellLabels{printStart+iRow-1}, ...
                        cellADcodes{printStart+iRow-1}, ...
                        cellSubregions{printStart+jRow-1}, ...
                        cellLabels{printStart+jRow-1}, ...
                        cellADcodes{printStart+jRow-1});

                nTabs(iRow) = nTabs(iRow) + 1;
                nTabs(jRow) = nTabs(jRow) + 1;
                
            end % diff by single neurite
            
        end % if E-E or I-I

    end % jRow

end % iRow

fclose(fid);

if isIncludeAcrossEINeuriteDifferences
    strng = sprintf('%d 1-neurite-difference (E-I)', nSingleNeuriteDiffsTotal);
else
    strng = sprintf('%d 1-neurite-difference', nSingleNeuriteDiffsTotal);
end
text(-7, nOfficialParcellations-14.0, strng, 'FontName', 'Courier', ...
     'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
     5, 'Color', 'b');
        
