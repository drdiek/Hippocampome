function outputConnToGv()

    load overlap.mat
    load parcellation.mat
    load Cij.mat Cij cellAbbrevs cellSubregions cellADcodes cellProjecting cellLabels cellEorIs cellUniqueIds
    load CijKnownClassLinks.mat
    load CijKnownNegClassLinks.mat
    load CijAxonSomaOverlap.mat
    load isInclude.mat
    
    
    %% format cell labels %%
    N = size(Cij,1);    
    printableCellLabels = cell(N,1);
        
    for i = 1:N
        cellSubregion = sprintf(deblank(cellSubregions{i}));
        cellLabel = sprintf(deblank(cellLabels{i}));
        cellADcode = sprintf(deblank(cellADcodes{i}));
        cellEorI = sprintf(deblank(cellEorIs{i}));
        cellAbbrev = sprintf(deblank(cellAbbrevs{i}));

        if (cellEorI == 'E')
            abbrev_code_cat = [cellSubregion, ':', '(+)', cellADcode];
        else %if (cellEorI == 'I')
            abbrev_code_cat = [cellSubregion, ':', '(-)', cellADcode];
        end
        
        if strcmpi(cellProjecting{i},'p')
            abbrev_code_cat = [abbrev_code_cat, 'p'];
        end        
        
        abbrev_code_cat = [abbrev_code_cat, ' ', cellAbbrev];

        printableCellLabels{i,1} = abbrev_code_cat;
      
    end % for i
    

    %% load known connectivity matrix
    %
    [num txt raw] = xlsread('known_connectivity_matrix_v1.0alpha.csv');
    uniqueIds = num(2:end,1);
    knownCij = num(2:end,2:end);
    clear num txt raw;
    
    
    %% load potential connectivity matrix
    %
    [num txt raw] = xlsread('potential_connectivity_matrix_v1.0alpha.csv');
    potnCij = num(2:end,2:end);
    clear num txt raw;
    
    
    fid = fopen('HC.gv', 'w');
    
    fprintf(fid, 'digraph hdg {\n\n');
	fprintf(fid, '\trankdir=LR;\n');
	fprintf(fid, '\tsize="10,7.5";\n\n');
    fprintf(fid, '\tnode [shape = record, color = black];\n\n');
    
    
%     iEnd = iCellsEnd(CA3);
%     iEnd = nCells(DG);
    iEnd = N;
    
    for i = 1:iEnd
        
        if (i == iCellsStart(DG))
            
            fprintf(fid, '\tsubgraph cluster_%d {\n', DG);
            fprintf(fid, '\t\tlabel = "DG";\n');
            fprintf(fid, '\t\tpenwidth=10.0;\n');
            fprintf(fid, '\t\tcolor = chocolate4;\n\n');
            
        end
        
        if (i == iCellsStart(CA3))
                
            fprintf(fid, '\t}\n\n');
            
            fprintf(fid, '\tsubgraph cluster_%d {\n', CA3);
            fprintf(fid, '\t\tlabel = "CA3";\n');
            fprintf(fid, '\t\tpenwidth=10.0;\n');
            fprintf(fid, '\t\tcolor = peru;\n\n');
            
        end
        
        if (i == iCellsStart(CA2))
                
            fprintf(fid, '\t}\n\n');
            
            fprintf(fid, '\tsubgraph cluster_%d {\n', CA2);
            fprintf(fid, '\t\tlabel = "CA2";\n');
            fprintf(fid, '\t\tpenwidth=10.0;\n');
            fprintf(fid, '\t\tcolor = gold;\n\n');
            
        end
        
        if (i == iCellsStart(CA1))
                
            fprintf(fid, '\t}\n\n');
            
            fprintf(fid, '\tsubgraph cluster_%d {\n', CA1);
            fprintf(fid, '\t\tlabel = "CA1";\n');
            fprintf(fid, '\t\tpenwidth=10.0;\n');
            fprintf(fid, '\t\tcolor = darkorange;\n\n');
            
        end
        
        if (i == iCellsStart(SUB))
                
            fprintf(fid, '\t}\n\n');
            
            fprintf(fid, '\tsubgraph cluster_%d {\n', SUB);
            fprintf(fid, '\t\tlabel = "SUB";\n');
            fprintf(fid, '\t\tpenwidth=10.0;\n');
            fprintf(fid, '\t\tcolor = bisque;\n\n');
            
        end
        
        if (i == iCellsStart(EC))
                
            fprintf(fid, '\t}\n\n');
            
            fprintf(fid, '\tsubgraph cluster_%d {\n', EC);
            fprintf(fid, '\t\tlabel = "EC";\n');
            fprintf(fid, '\t\tpenwidth=10.0;\n');
            fprintf(fid, '\t\tcolor = darkolivegreen;\n\n');
            
        end
                   
        fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "<f0> %s"];\n\n', i, printableCellLabels{i,1});
        
    end
    
    fprintf(fid, '\t}\n\n');

    
    knownPenDescStr = {'[arrowhead=empty,arrowsize=4.0,color=red,penwidth=2.0]'; ...
                       '[arrowhead=dot,arrowsize=4.0,color=blue,penwidth=2.0]'; ...
                       '[arrowhead=box,arrowsize=4.0,color=green,penwidth=2.0]'};
    
    potnPenDescStr = {'[arrowhead=normal,arrowsize=2.0,color=red,penwidth=1.0]'; ...
                      '[arrowhead=odot,arrowsize=2.0,color=blue,penwidth=1.0]'; ...
                      '[arrowhead=obox,arrowsize=2.0,color=green,penwidth=1.0]'};
    
    signCij = zeros(N,N);
                  
    for iPre = 1:iEnd
        
        for iPost = 1:iEnd
            
            if (knownCij(iPre,iPost) == 1)
                
                if (potnCij(iPre,iPost) == 1)
                    
                    fprintf(fid, '\tnode%d -> node%d %s;\n', iPre, iPost, knownPenDescStr{1});
                    
                    signCij(iPre,iPost) = 1;
                    
                elseif (potnCij(iPre,iPost) == -1)
                    
                    fprintf(fid, '\tnode%d -> node%d %s;\n', iPre, iPost, knownPenDescStr{2});
                    
                    signCij(iPre,iPost) = 1;
                    
                elseif (potnCij(iPre,iPost) == 4)
                    
                    fprintf(fid, '\tnode%d -> node%d %s;\n', iPre, iPost, knownPenDescStr{3});
                    
                    signCij(iPre,iPost) = 1;
                    
                end
                    
            elseif (knownCij(iPre,iPost) == -1)
                
                if (potnCij(iPre,iPost) == 1)
                    
                    fprintf(fid, 'node%d -> node%d %s;\n', iPre, iPost, potnPenDescStr{1});
                    
                    signCij(iPre,iPost) = 1;
                    
                elseif (potnCij(iPre,iPost) == -1)
                    
                    fprintf(fid, 'node%d -> node%d %s;\n', iPre, iPost, potnPenDescStr{2});
                    
                    signCij(iPre,iPost) = 1;
                    
                elseif (potnCij(iPre,iPost) == 4)
                    
                    fprintf(fid, '\tnode%d -> node%d %s;\n', iPre, iPost, potnPenDescStr{3});
                    
                    signCij(iPre,iPost) = 1;
                    
                end 
                
            end
            
        end % for iPost
        
    end % for iPre
    
    fprintf(fid, '\n}');
    
    fclose(fid);
    
    copyfile('HC.gv','C:\Users\Diek\Dropbox\HC.gv','f');
 
    sumInputs = sum(signCij,1);
    sumOutputs = sum(signCij,2);
    fidi = fopen('sumInputs.txt', 'w')
    for i = 1:N
          fprintf(fidi, '%d\t%d\n', i, sumInputs(i));
    end
    fclose(fidi);
    fido = fopen('sumOutputs.txt', 'w');
    for i = 1:N
          fprintf(fido, '%d\t%d\n', i, sumOutputs(i));
    end
    fclose(fido);
    
    
end
