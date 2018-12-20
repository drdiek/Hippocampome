function nTabs = find_double_neurite_differences(overlapMatrix, ...
                                                 nOfficialParcellations, ...
                                                 nTabs, cellLabels, ...
                                                 cellADcodes, ...
                                                 cellSubregions, ...
                                                 cellEorI, regionCode, ...
                                                 printStart, printEnd, ...
                                                 vTab, hTab)

load isInclude.mat                                             

[nRows, nCols] = size(overlapMatrix);
% nRows-1 = printEnd-printStart+1

nDoubleNeuriteDiffs = 0;
nDoubleNeuriteDiffsTotal = 0;

isMagenta = 0;
isBlack = 0;

ALL = 0;
DG  = 1;
CA3 = 2;
CA2 = 3;
CA1 = 4;
SUB = 5;
EC  = 6;

diffFileName = sprintf('diffs_by_2_neurites.csv');

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

singleTransitions = {...
                     '03'; ... % +axon +dendrite
                     '30'; ... % -axon -dendrite
                     '12'; ... % -axon +dendrite
                     '21'; ... % -dendrite +axon
                    };
                    
nSingleTransitions = length(singleTransitions);

doubleTransitions = { ...
                     '0101'; ... % +axon +axon
                     '0110'; ... % +axon -axon
                     '0123'; ... % +axon +axon
                     '0132'; ... % +axon -axon
                     '1001'; ... % -axon +axon
                     '1010'; ... % -axon -axon
                     '1023'; ... % -axon +axon
                     '1032'; ... % -axon -axon
                     '2301'; ... % +axon +axon
                     '2310'; ... % +axon -axon
                     '2323'; ... % +axon +axon
                     '2332'; ... % +axon -axon
                     '3201'; ... % -axon +axon
                     '3210'; ... % -axon -axon
                     '3223'; ... % -axon +axon
                     '3232'; ... % -axon -axon
                     '0202'; ... % +dendrite +dendrite
                     '0220'; ... % +dendrite -dendrite
                     '0213'; ... % +dendrite +dendrite
                     '0231'; ... % +dendrite -dendrite
                     '2002'; ... % -dendrite +dendrite
                     '2020'; ... % -dendrite -dendrite
                     '2013'; ... % -dendrite +dendrite
                     '2031'; ... % -dendrite -dendrite
                     '1302'; ... % +dendrite +dendrite
                     '1320'; ... % +dendrite -dendrite
                     '1313'; ... % +dendrite +dendrite
                     '1331'; ... % +dendrite -dendrite
                     '3102'; ... % -dendrite +dendrite
                     '3120'; ... % -dendrite -dendrite
                     '3113'; ... % -dendrite +dendrite
                     '3131'; ... % -dendrite -dendrite
                     '0102'; ... % +axon +dendrite
                     '0120'; ... % +axon -dendrite
                     '0113'; ... % +axon +dendrite
                     '0131'; ... % +axon -dendrite
                     '1002'; ... % -axon +dendrite
                     '1020'; ... % -axon -dendrite
                     '1013'; ... % -axon +dendrite
                     '1031'; ... % -axon -dendrite
                     '2302'; ... % +axon +dendrite
                     '2320'; ... % +axon -dendrite
                     '2313'; ... % +axon +dendrite
                     '2331'; ... % +axon -dendrite
                     '3202'; ... % -axon +dendrite
                     '3220'; ... % -axon -dendrite
                     '3213'; ... % -axon +dendrite
                     '3231'; ... % -axon -dendrite
                     '0201'; ... % +dendrite +axon
                     '0210'; ... % +dendrite -axon
                     '0223'; ... % +dendrite +axon
                     '0232'; ... % +dendrite -axon
                     '2001'; ... % -dendrite +axon
                     '2010'; ... % -dendrite -axon
                     '2023'; ... % -dendrite +axon
                     '2032'; ... % -dendrite -axon
                     '1301'; ... % +dendrite +axon
                     '1310'; ... % +dendrite -axon
                     '1323'; ... % +dendrite +axon
                     '1332'; ... % +dendrite -axon
                     '3101'; ... % -dendrite +axon
                     '3110'; ... % -dendrite -axon
                     '3123'; ... % -dendrite +axon
                     '3132'; ... % -dendrite -axon
                    };

nDoubleTransitions = length(doubleTransitions);


for iRow = 1:nRows-2

    for jRow = iRow+1:nRows-1

        if ( (~isIncludeAcrossEINeuriteDifferences) && ...
             (cellEorI{iRow} == cellEorI{jRow}) || ...
             isIncludeAcrossEINeuriteDifferences )
 
            isMarkRows = 0;
            
            idxDiffIJ = find(overlapMatrix(iRow,:) ~= overlapMatrix(jRow,:));
            
            nIdxDiffIJ = length(idxDiffIJ);
            
            if (nIdxDiffIJ == 1)
                
                diffI = overlapMatrix(iRow,idxDiffIJ);
                
                diffJ = overlapMatrix(jRow,idxDiffIJ);
                
                diffIJ = [num2str(diffI) num2str(diffJ)];
                
                for ii = 1:nSingleTransitions
                    
                    isTransitionFound = strcmp(diffIJ, singleTransitions(ii));
                    
                    if isTransitionFound
                        
                        isMarkRows = 1;
                        
                    end
                    
                end % ii
                
            elseif (nIdxDiffIJ == 2)
                
                for ii = 1:2
                    
                    diffI(ii) = overlapMatrix(iRow,idxDiffIJ(ii));
                    
                    diffJ(ii) = overlapMatrix(jRow,idxDiffIJ(ii));
                    
                end 
                
                diffIJ = [num2str(diffI(1)) num2str(diffJ(1)) ...
                          num2str(diffI(2)) num2str(diffJ(2))];
                
                for ii = 1:nDoubleTransitions
                    
                    isTransitionFound = strcmp(diffIJ, doubleTransitions(ii));
                    
                    if isTransitionFound
                        
                        isMarkRows = 1;
                        
                    end
                    
                end % ii
                
            end % if (nIdxDiffIJ == 1)
            
            
            if isMarkRows
                
                nDoubleNeuriteDiffs = nDoubleNeuriteDiffs + 1;
                nDoubleNeuriteDiffsTotal = nDoubleNeuriteDiffsTotal + 1;
                if ((nDoubleNeuriteDiffs == 95) & (isMagenta == 0))
                    nDoubleNeuriteDiffs = 1;
                    isMagenta = 1;
                end
                if ((nDoubleNeuriteDiffs == 95) & (isMagenta == 1))
                    nDoubleNeuriteDiffs = 1;
                    isMagenta = 0;
                    isBlack = 1;
                end
                
                if (nTabs(iRow) > nTabs(jRow))
                    nTabs(jRow) = nTabs(iRow);
                end
                if (nTabs(jRow) > nTabs(iRow))
                    nTabs(iRow) = nTabs(jRow);
                end
                
                if isMagenta
                    
                    text(iRow+0.5, 0.6 - nTabs(iRow)*0.6, char(32+nDoubleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'm');
                    text(jRow+0.5, 0.6 - nTabs(jRow)*0.6, char(32+nDoubleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'm');
                    
                elseif isBlack
                    
                    text(iRow+0.5, 0.6 - nTabs(iRow)*0.6, char(32+nDoubleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'k');
                    text(jRow+0.5, 0.6 - nTabs(jRow)*0.6, char(32+nDoubleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'k');
                    
                else
                    
                    text(iRow+0.5, 0.6 - nTabs(iRow)*0.6, char(32+nDoubleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'r');
                    text(jRow+0.5, 0.6 - nTabs(jRow)*0.6, char(32+nDoubleNeuriteDiffs), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'r');
                    
                end
                
                fprintf(fid, '2-neurite, %s, %s, %s\n2-neurite, %s, %s, %s\n\n', ...
                        cellSubregions{printStart+iRow-1}, ...
                        cellLabels{printStart+iRow-1}, ...
                        cellADcodes{printStart+iRow-1}, ...
                        cellSubregions{printStart+jRow-1}, ...
                        cellLabels{printStart+jRow-1}, ...
                        cellADcodes{printStart+jRow-1});

                nTabs(iRow) = nTabs(iRow) + 1;
                nTabs(jRow) = nTabs(jRow) + 1;
                
            end % diff by two neurites

        end % if E-E or I-I

    end % jRow

end % iRow

fclose(fid);

if isIncludeAcrossEINeuriteDifferences
    strng = sprintf('%d 2-neurite-differences (E-I)', nDoubleNeuriteDiffsTotal);
else
    strng = sprintf('%d 2-neurite-differences', nDoubleNeuriteDiffsTotal);
end
%text(-6, nOfficialParcellations-14.0, strng, 'FontName', 'Courier', ...
text(vTab, hTab, strng, 'FontName', 'Courier', ...
     'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
     5, 'Color', 'r');

        
