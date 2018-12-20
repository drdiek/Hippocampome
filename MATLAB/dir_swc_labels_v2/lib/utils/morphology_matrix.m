function morphologyMatrix = morphology_matrix(swcList, inputSWCFile, morphologyMatrix)
    
    N = length(swcList);

    pointTypes = single([swcList.pointType]);

    morphologyMatrix.nRows = morphologyMatrix.nRows + 1;
    row = morphologyMatrix.nRows;
    
    for i = 1:N
        if isempty(swcList(i).pointName)
            swcList(i).pointName = {'unknown'}
        end
        col = find(strcmp(morphologyMatrix.parcels, swcList(i).pointName));
        if isempty(col)
            morphologyMatrix.nCols = morphologyMatrix.nCols + 1;
            col = morphologyMatrix.nCols;
            morphologyMatrix.parcels(col) = swcList(i).pointName;
        end
        morphologyMatrix.neuronTypes{row} = inputSWCFile;
        if (pointTypes(i) == 2) % axons
            morphologyMatrix.axonCounts(row,col) = morphologyMatrix.axonCounts(row,col) + 1;
        elseif ((pointTypes(i) == 3) || (pointTypes(i) == 4)) % dendrites
            morphologyMatrix.dendriteCounts(row,col) = morphologyMatrix.dendriteCounts(row,col) + 1;
        elseif (pointTypes(i) == 1) % somata
            morphologyMatrix.somaCounts(row,col) = morphologyMatrix.somaCounts(row,col) + 1;
        end
    end % i
    
end % morphology_matrix()