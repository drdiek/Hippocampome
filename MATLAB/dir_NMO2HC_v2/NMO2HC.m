function NMO2HC()

    addpath(genpath('lib'),'data');

    maxNo = 500;
    pageNo = 0;
    
    uploadDate = '2018-04-16';
    
    brainRegions = {'hippocampus', 'subiculum', 'entorhinal%20cortex'};
    
    cellTypes = {'interneuron', 'principal%20cell'};
    
    baseSearch = 'http://neuromorpho.org/api/neuron/';
    
    nBrainRegions2Save = 15;
    nCellTypes2Save = 30;
    nPmids2Save = 5;
    nDois2Save = 5;
    cellArray = cell_array_header(nBrainRegions2Save, nCellTypes2Save, nPmids2Save, nDois2Save);
    
    nBrainRegionsMaximum = 1;
    nCellTypesMaximum = 1;
    nPmidsMaximum = 1;
    nDoisMaximum = 1;
    
    for brainRegionNo = 1:size(brainRegions,2)
        
        for cellTypeNo = 1:size(cellTypes,2)
    
            searchURL = sprintf('%sselect?q=brain_region:%s&fq=cell_type:%s&size=%d&page=%d', ...
                baseSearch, brainRegions{1,brainRegionNo}, cellTypes{1,cellTypeNo}, maxNo, pageNo)
%             searchURL = sprintf('%sselect?q=upload_date:%s&fq=brain_region:%s&fq=cell_type:%s&size=%d&page=%d', ...
%                 baseSearch, uploadDate, brainRegions{1,brainRegionNo}, cellTypes{1,cellTypeNo}, maxNo, pageNo)
            
            [nmoText, statusIsOk] = urlread(searchURL);
            
            if statusIsOk
            
                dataStruct = parse_json(nmoText);
                
                pageNoMax = dataStruct.page.totalPages - 1;
                
                for pageNo = 0:pageNoMax
                    searchURL = sprintf('%sselect?q=brain_region:%s&fq=cell_type:%s&size=%d&page=%d', ...
                        baseSearch, brainRegions{1,brainRegionNo}, cellTypes{1,cellTypeNo}, maxNo, pageNo);
%                     searchURL = sprintf('%sselect?q=upload_date:%s&fq=brain_region:%s&fq=cell_type:%s&size=%d&page=%d', ...
%                         baseSearch, uploadDate, brainRegions{1,brainRegionNo}, cellTypes{1,cellTypeNo}, maxNo, pageNo);
                    
                    nmoText = urlread(searchURL);
                    dataStruct = parse_json(nmoText);
                    
                    nNeuronResources = size(dataStruct.alpha__embedded.neuronResources,2);
                    
                    nBrainRegionsMax = 1;
                    nCellTypesMax = 1;
                    nPmidsMax = 1;
                    nDoisMax = 1;
                    for i = 1:nNeuronResources
                        nBrainRegions = size(dataStruct.alpha__embedded.neuronResources{1,i}.brain_region,2);
                        if (nBrainRegions > nBrainRegionsMax)
                            nBrainRegionsMax = nBrainRegions;
                        end
                        
                        nCellTypes = size(dataStruct.alpha__embedded.neuronResources{1,i}.cell_type,2);
                        if (nCellTypes > nCellTypesMax)
                            nCellTypesMax = nCellTypes;
                        end
                        
                        nPmids = size(dataStruct.alpha__embedded.neuronResources{1,i}.reference_pmid,2);
                        if (nPmids > nPmidsMax)
                            nPmidsMax = nPmids;
                        end
                        
                        nDois = size(dataStruct.alpha__embedded.neuronResources{1,i}.reference_doi,2);
                        if (nDois > nDoisMax)
                            nDoisMax = nDois;
                        end
                    end % for i
                    
                    if (nBrainRegionsMax > nBrainRegionsMaximum)
                        nBrainRegionsMaximum = nBrainRegionsMax;
                    end
                    if (nCellTypesMax > nCellTypesMaximum)
                        nCellTypesMaximum = nCellTypesMax;
                    end
                    if (nPmidsMax > nPmidsMaximum)
                        nPmidsMaximum = nPmidsMax;
                    end
                    if (nDoisMax > nDoisMaximum)
                        nDoisMaximum = nDoisMax;
                    end
                    
                    cellArray = append_cell_array(cellArray, dataStruct, brainRegions{brainRegionNo}, cellTypes{cellTypeNo}, ...
                        nNeuronResources, nBrainRegions2Save, nCellTypes2Save, nPmids2Save, nDois2Save);
                    
                end % for pageNo
                
            end % if statusIsOk
            
        end % for cellTypeNo
    
    end % for brainRegionNo
    
    save_cell_array(cellArray);
    
    [nBrainRegionsMaximum nCellTypesMaximum nPmidsMaximum nDoisMaximum]
    
end % NMO2HC