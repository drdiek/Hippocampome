function fly_neuropil_load()

    cla;
        
    [neuropilNames, isFileLoaded] = load_csvFile('fly_neuropil_listing.csv');
   
%     fileName = 'fly_neuropil_octopamine.csv';
%     fileName = 'fly_neuropil_acetylcholine.csv';
%     fileName = 'fly_neuropil_dopamine.csv';
%     fileName = 'fly_neuropil_GABA.csv';
%     fileName = 'fly_neuropil_glutamate.csv';
    fileName = 'fly_neuropil_serotonin.csv';

    [cells, isFileLoaded] = load_csvFile(fileName);
   
    nNeurons = size(cells,1)
    
    nParcels = 58;
    
    neurites = zeros(1,nParcels);
    
    label = cells{1,1};
    
    for iNeuron = 1:nNeurons
        
       dendriteStr = cells{iNeuron,3};
       
       dendrites(iNeuron,:) = fly_neuropil_parser(dendriteStr, neuropilNames);
       
       axonStr = cells{iNeuron,4};
       
       axons(iNeuron,:) = fly_neuropil_parser(axonStr, neuropilNames);
       
    end
    
    dendritesAll = sum(dendrites,1)
    
    axonsAll = sum(axons,1)
    
    for iParcel = 1:nParcels
        
        if (axonsAll(iParcel) > 0)
        
            neurites(iParcel) = neurites(iParcel) + 1;
            
        end
    
        if (dendritesAll(iParcel) > 0)
        
            neurites(iParcel) = neurites(iParcel) + 2;
            
        end
    
    end
    
    fid = fopen('fly_neuropil_output.csv', 'w');
    
    fprintf(fid, '%s, E, ', label);
    
    for iParcel = 1:nParcels
        
        fprintf(fid, '%d', neurites(iParcel));
        
        if (iParcel < nParcels)
            
            fprintf(fid, ', ');
            
        else
            
            fprintf(fid, '\n');
            
        end
        
    end
       
end


function neurites = fly_neuropil_parser(neuriteStr, neuropilNames)

    lenNeuriteStr = length(neuriteStr);
    
    nParcels = size(neuropilNames,1);
    
    neurites = zeros(1,nParcels);
    
    parensIdx = strfind(neuriteStr,'(');
    
    percentIdx = strfind(neuriteStr,'%');
    
    iStart = 1;
    
    percentThreshold = 75;
    
    for i = 1:length(parensIdx)
        
        iStop = parensIdx(i) - 1;
        
        nameStr = neuriteStr(iStart:iStop);
        
        iStart = iStop + 2;
        
        iStop = percentIdx(i) - 1;
        
        percentStr = neuriteStr(iStart:iStop);
        
        percent = str2num(percentStr);
        
        iStart = iStop + 4;
        
        for j = 1:nParcels
            
            neuropilNameStr = neuropilNames{j};
            
            if (strcmp(nameStr,neuropilNameStr) && (percent >= percentThreshold))
                
                neurites(1,j) = neurites(1,j) + 1;
                
            end
            
        end % for j
        
    end % for i
        
end