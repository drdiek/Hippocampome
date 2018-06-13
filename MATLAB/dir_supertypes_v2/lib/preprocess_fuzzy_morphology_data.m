function [morphologyMatrix,subregionsMatrix,labelsMatrix,eoriMatrix] = preprocess_fuzzy_morphology_data(data,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)

    load('./lib/constants.mat');
    
    N = size(data,1);
    nParcels = length([ST_A_DG_SMO_COL:ST_A_EC_LVI_COL]);
    
    if isPlotSupertypesOnly
        dataSubset = cell2mat(data(1:N,ST_A_DG_SMO_COL:ST_D_EC_LVI_COL));
        [neuritesUniqueUnsorted,idx,jdx] = unique(dataSubset,'rows');
        idxSorted = sort(idx);
        neuritesUnique = dataSubset(idxSorted,:);
        labelsUnique = data(idxSorted,SUPERTYPE_DESCRIPTOR_COL);
    elseif isPlotSuperfamiliesOnly
        dataSubset = cell2mat(data(1:N,SF_A_DG_SMO_COL:SF_D_EC_LVI_COL));
        [neuritesUniqueUnsorted,idx,jdx] = unique(dataSubset,'rows');
        idxSorted = sort(idx);
        neuritesUnique = dataSubset(idxSorted,:);
        labelsSorted = data(idxSorted,SUPERTYPE_DESCRIPTOR_COL);
        for i = 1:length(labelsSorted)
            colonsIdx = find(cell2mat(labelsSorted(i,:)) == ':')
            labelsSortedArray = cell2mat(labelsSorted(i,:));
            labelsUnique{i,:} = labelsSortedArray(1:colonsIdx(2)-1);
        end
    else
        neuritesUnique = cell2mat(data(1:N,ST_A_DG_SMO_COL:ST_D_EC_LVI_COL));
        idxSorted = 1:N;
        labelsUnique = data(1:N,NEURONAL_TYPE_COL);
    end
    subregionsUnique = data(idxSorted,SUBREGION_COL);
    eoriUnique = data(idxSorted,EI_COL);
    
    N = length(idx);
    morphologyMatrix = zeros(2*N,nParcels);
    
    for i = 0:N-1
        morphologyMatrix(2*i+1,1:nParcels) = neuritesUnique(i+1,1:nParcels)+1;
        morphologyMatrix(2*i+2,1:nParcels) = neuritesUnique(i+1,nParcels+1:2*nParcels)+1+4;
        
        subregionsMatrix(2*i+1) = subregionsUnique(i+1);
        subregionsMatrix(2*i+2) = subregionsUnique(i+1);
        
        labelsMatrix(2*i+1) = labelsUnique(i+1);
        labelsMatrix(2*i+2) = labelsUnique(i+1);
        
        eoriMatrix(2*i+1) = eoriUnique(i+1);
        eoriMatrix(2*i+2) = eoriUnique(i+1);
    end % i
end % preprocess_fuzzy_morphology_data()