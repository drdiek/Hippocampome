function fly_neuropil_load()

    cla;
        
    [neuropilNames, isFileLoaded] = load_csvFile('PT_input/fly_neuropil_listing.csv');
   
%     fileName = 'fly_neuropil_octopamine.csv';
%     fileName = 'fly_neuropil_acetylcholine.csv';
%     fileName = 'fly_neuropil_acetylcholine_embryo.csv';
%     fileName = 'fly_neuropil_acetylcholine_day1.csv';
%     fileName = 'fly_neuropil_acetylcholine_day2.csv';
%     fileName = 'fly_neuropil_acetylcholine_day3.csv';
%     fileName = 'fly_neuropil_acetylcholine_day4.csv';
%     fileName = 'fly_neuropil_acetylcholine_day5.csv';
%     fileName = 'fly_neuropil_acetylcholine_day6.csv';
%     fileName = 'fly_neuropil_acetylcholine_day7.csv';
%     fileName = 'fly_neuropil_acetylcholine_day8.csv';
%     fileName = 'fly_neuropil_acetylcholine_day9.csv';
%     fileName = 'fly_neuropil_dopamine.csv';
    fileName = 'fly_neuropil_GABA.csv';
%     fileName = 'fly_neuropil_GABA_embryo.csv';
%     fileName = 'fly_neuropil_GABA_day1.csv';
%     fileName = 'fly_neuropil_GABA_day2.csv';
%     fileName = 'fly_neuropil_GABA_day3.csv';
%     fileName = 'fly_neuropil_GABA_day4.csv';
%     fileName = 'fly_neuropil_GABA_day5.csv';
%     fileName = 'fly_neuropil_GABA_day6.csv';
%     fileName = 'fly_neuropil_GABA_day7.csv';
%     fileName = 'fly_neuropil_GABA_day8.csv';
%     fileName = 'fly_neuropil_GABA_day9.csv';
%     fileName = 'fly_neuropil_glutamate.csv';
%     fileName = 'fly_neuropil_glutamate_embryo.csv';
%     fileName = 'fly_neuropil_glutamate_day1.csv';
%     fileName = 'fly_neuropil_glutamate_day2.csv';
%     fileName = 'fly_neuropil_glutamate_day3.csv';
%     fileName = 'fly_neuropil_glutamate_day4.csv';
%     fileName = 'fly_neuropil_glutamate_day5.csv';
%     fileName = 'fly_neuropil_glutamate_day6.csv';
%     fileName = 'fly_neuropil_glutamate_day7.csv';
%     fileName = 'fly_neuropil_glutamate_day8.csv';
%     fileName = 'fly_neuropil_glutamate_day9.csv';
%     fileName = 'fly_neuropil_serotonin.csv';
%     fileName = 'fly_neuropil_All.csv';

    fileNameFull = sprintf('PT_input/%s', fileName);

    [cells, isFileLoaded] = load_csvFile(fileNameFull);
   
    nNeurons = size(cells,1)
    
    nParcels = size(neuropilNames,1);
    
    neurites = zeros(nNeurons,nParcels);
    
    label = cells{1,1};
    
    disp('parsing csv entries ...');
    
    for iNeuron = 1:nNeurons
        
       dendriteStr = cells{iNeuron,3};
       
       dendrites(iNeuron,:) = fly_neuropil_parser(dendriteStr, neuropilNames);
       
       axonStr = cells{iNeuron,4};
       
       axons(iNeuron,:) = fly_neuropil_parser(axonStr, neuropilNames);
       
       for iParcel = 1:nParcels
           
           if (axons(iNeuron,iParcel) > 0)
               
               neurites(iNeuron,iParcel) = neurites(iNeuron,iParcel) + 1;
               
           end
           
           if (dendrites(iNeuron,iParcel) > 0)
               
               neurites(iNeuron,iParcel) = neurites(iNeuron,iParcel) + 2;
               
           end
           
       end % for iParcel
    
    end % for iNeuron
    
    disp('finding neuron types ...');
    
    neuritePatterns = zeros(nNeurons,nParcels);
    
    for iNeuron = 1:nNeurons
        
        % check if current neuron's pattern is found among other neurons
        neuritePatternIdx = ismember(neurites,neurites(iNeuron,:),'rows');
        
        % count how many times the current pattern is found among other neurons
        nNeuritePatterns(iNeuron) = sum(neuritePatternIdx);
        
        % save current pattern
        neuritePatterns(iNeuron,:) = neurites(iNeuron,:);
        
        % generate random numbers to be added to current patterns
        randNums = randi(100000,nNeurons,1);
        
        % apply random numbers to row locations of current patterns
        randConstants = neuritePatternIdx .* randNums;

        % add random number to current patterns
        % this guarantees that these neurons will not have matching patterns ever again
        neurites = neurites + repmat(randConstants,1,nParcels);
        
    end % for iNeuron
    
    disp('sorting neurite patterns ...');

    % find the neurite patterns that occur most frequently
    [nNeuritePatternsSorted, nNeuritePatternsIdx] = sort(nNeuritePatterns,'descend');
    
    fid = fopen('PT_output/fly_neuropil_output.csv', 'w');
    
    for iNeuron = 1:100%20%100
        
        neuritePatterns(nNeuritePatternsIdx(iNeuron),:)
        
        nNeuritePatternsSorted(iNeuron)
        
        fprintf(fid, '%d,E,', nNeuritePatternsSorted(iNeuron));
        
        for iParcel = 1:nParcels
            
            fprintf(fid, '%d', neuritePatterns(nNeuritePatternsIdx(iNeuron),iParcel));
            
            if (iParcel < nParcels)
                
                fprintf(fid, ',');
                
            else
                
                fprintf(fid, '\n');
                
            end
            
        end % for iParcel
       
    end % for iNeuron
    
end


function neurites = fly_neuropil_parser(neuriteStr, neuropilNames)

    lenNeuriteStr = length(neuriteStr);
    
    nParcels = size(neuropilNames,1);
    
    neurites = zeros(1,nParcels);
    
    parensIdx = strfind(neuriteStr,'(');
    
    percentIdx = strfind(neuriteStr,'%');
    
    iStart = 1;
    
    percentThreshold = 0;
    
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
            
            if (strcmpi(nameStr,neuropilNameStr) && (percent >= percentThreshold))
                
                neurites(1,j) = 1;
                
            end
            
        end % for j
        
    end % for i
        
end