function NMO2HC()

    addpath(genpath('lib'),'data');

    maxnum = 500;
    pageNo = 0;
    
    baseSearchURL{1} = 'http://neuromorpho.org/api/neuron/select?q=brain_region:%22entorhinal%20cortex%22';
    baseSearchURL{2} = 'http://neuromorpho.org/api/neuron/select?q=brain_region:subiculum';
    baseSearchURL{3} = 'http://neuromorpho.org/api/neuron/select?q=brain_region:hippocampus';

    nBrainRegionsMaximum = 1;
    nCellTypesMaximum = 1;
    
    for brainRegionNo = 1:3
    
        maxOpt = ['&size=',num2str(maxnum)];
        
        pageOpt = ['&page=',num2str(pageNo)];
        
        searchURL = [baseSearchURL{brainRegionNo},maxOpt,pageOpt];
        
        nmoText = urlread(searchURL);
        
        dataStruct = parse_json(nmoText);
        
        pageNoMax = dataStruct.page.totalPages - 1;
        
        for pageNo = 0:pageNoMax
            pageOpt = ['&page=',num2str(pageNo)];
            
            searchURL = [baseSearchURL{brainRegionNo},maxOpt,pageOpt]
            nmoText = urlread(searchURL);
            dataStruct = parse_json(nmoText);
            
            nNeuronResources = size(dataStruct.alpha__embedded.neuronResources,2);
            
            nBrainRegionsMax = 1;
            nCellTypesMax = 1;
            for i = 1:nNeuronResources
                nBrainRegions = size(dataStruct.alpha__embedded.neuronResources{1,i}.brain_region,2);
                if (nBrainRegions > nBrainRegionsMax)
                    nBrainRegionsMax = nBrainRegions;
                end
                
                nCellTypes = size(dataStruct.alpha__embedded.neuronResources{1,i}.cell_type,2);
                if (nCellTypes > nCellTypesMax)
                    nCellTypesMax = nCellTypes;
                end
            end % for i
            
            if (nBrainRegionsMax > nBrainRegionsMaximum)
                nBrainRegionsMaximum = nBrainRegionsMax;
            end
            if (nCellTypesMax > nCellTypesMaximum)
                nCellTypesMaximum = nCellTypesMax;
            end
        end % for pageNo
    
    end % for brainRegionNo
    
    [nBrainRegionsMaximum nCellTypesMaximum]
    
end % NMO2HC