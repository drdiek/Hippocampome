function [morphologyMatrix,subregionsMatrix,labelsMatrix,eoriMatrix,nSubGrouping] = ...
    preprocess_fuzzy_morphology_data(data,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)

    load('./lib/constants.mat');
    
    N = size(data,1);
    nParcels = length([DG_SMO:EC_LVI]);
    
    for i = 1:N
        neuritesParsed(i,:) = parse_neurites(cell2mat(data(i,SUBREGION_COL)),cell2mat(data(i,AD_PATTERN_COL)),...
                                             cell2mat(data(i,PROJECTION_PATTERN_COL)));
        neuritesExpanded(i,:) = expand_neurites(neuritesParsed(i,:));
%         neuritesExpanded(i,:) = expand_neurites(data(i,DG_A_D:EC_A_D));
    end % i
    
    if isPlotSupertypesOnly
        supertypeIds = cell2mat(data(1:N,SUPERTYPE_ID_COL));
        [supertypeIdsUniqueUnsorted,idx,jdx] = unique(supertypeIds,'rows','last');
        nSubGrouping = accumarray(jdx,1);
        idxSorted = sort(idx);
        nNeuritesUnique = length(idxSorted);
        labelsUnique = data(idxSorted,SUPERTYPE_DESCRIPTOR_COL);
        
        for i = 1:length(labelsUnique)
            jdx = strfind(labelsUnique{i}, ':');
            labelsUnique{i} = labelsUnique{i}(jdx(1)+1:end);
        end        
        
        idxStart = 1;
        for i = 1:nNeuritesUnique
            canonical = cell2mat(data(idxStart:idxSorted(i),CANONICAL_COL));
            neurites = neuritesExpanded(idxStart:idxSorted(i),:);
            [canonicalSorted,cdx] = sort(canonical,'descend');
            neuritesSorted = neurites(cdx,:);
            nSupertypes = length(cdx);
            
            for j = 1:2*nParcels
                count = 0;
                canonicalFlag = 0;
                for k = 1:nSupertypes
                    if (neuritesSorted(k,j) == 1)
                        if (canonicalSorted(k) >= 1)
                            count = count + 2;
                            canonicalFlag = 1;
                        else
                            count = count + 1;
                        end
                    end
                end % k

                if (count > nSupertypes)
                    neuritesUnique(i,j) = 2;
                elseif ((count > 0) && canonicalFlag)
                    neuritesUnique(i,j) = 1;
                elseif (count > 0)
                    neuritesUnique(i,j) = 0;
                else
                    neuritesUnique(i,j) = -1;
                end
            end % j
            
            idxStart = idxSorted(i) + 1;
        
        end % i
    elseif isPlotSuperfamiliesOnly
        supertypeIds = cell2mat(data(1:N,SUPERTYPE_ID_COL));
        [superfamilyIdsUniqueUnsorted,idx,jdx] = unique(supertypeIds(1:N,1:end-2),'rows','last');
        nSubGrouping = accumarray(jdx,1);
        idxSorted = sort(idx);
        nNeuritesUnique = length(idxSorted);
        labelsCellArray = data(idxSorted,SUPERTYPE_DESCRIPTOR_COL);
        for i = 1:nNeuritesUnique
            labelsStr = cell2mat(labelsCellArray(i,:));
            fdx = strfind(labelsStr,':');
            labelsUnique{i,:} = labelsStr(1:fdx(2)-1);
        end % i
        
        idxStart = 1;
        for i = 1:nNeuritesUnique
            canonical = cell2mat(data(idxStart:idxSorted(i),CANONICAL_COL));
            neurites = neuritesExpanded(idxStart:idxSorted(i),:);
            [canonicalSorted,cdx] = sort(canonical,'descend');
            neuritesSorted = neurites(cdx,:);
            nSupertypes = length(cdx);
            
            for j = 1:2*nParcels
                count = 0;
                canonicalFlag = 0;
                for k = 1:nSupertypes
                    if (neuritesSorted(k,j) == 1)
                        if (canonicalSorted(k) == 2)
                            count = count + 2;
                            canonicalFlag = 1;
                        else
                            count = count + 1;
                        end
                    end
                end % k

                if (count > nSupertypes)
                    neuritesUnique(i,j) = 2;
                elseif ((count > 0) && canonicalFlag)
                    neuritesUnique(i,j) = 1;
                elseif (count > 0)
                    neuritesUnique(i,j) = 0;
                else
                    neuritesUnique(i,j) = -1;
                end
            end % j
            
            idxStart = idxSorted(i) + 1;
        
        end % i
    else
        idx = 1:N;
        idxSorted = sort(idx);
        nNeuritesUnique = length(idxSorted);
        labelsUnique = data(1:N,NEURONAL_TYPE_COL);
        
        for i = 1:nNeuritesUnique
            neurites = neuritesExpanded(i,:);
            neuritesSorted = neurites(1,:);
            
            for j = 1:2*nParcels
                if (neuritesSorted(1,j) == 1)
                    neuritesUnique(i,j) = 2;
                else
                    neuritesUnique(i,j) = -1;
                end
            end % j
            
        end % i
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