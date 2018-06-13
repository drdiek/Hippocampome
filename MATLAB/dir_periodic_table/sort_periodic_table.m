function [tags, isExcit, AandDs] = sort_periodic_table(label, isExcitatory, neurites)

    nNeurons = size(neurites,1);
    
    nParcels = size(neurites,2);
    
    target = 3*ones(1,nParcels);
    
    for iNeuron = 1:nNeurons
        
        distance(iNeuron) = 0;
    
        for iParcel = 1:nParcels
    
            distance(iNeuron) = distance(iNeuron) + (target(iParcel)-neurites(iNeuron,iParcel))^2;
            
        end
        
        distance(iNeuron) = sqrt(distance(iNeuron));
        
    end
    
    [sorted,idx] = sort(distance)
    
    for iNeuron = 1:nNeurons
        
        tags{iNeuron} = label{idx(iNeuron)};
        
        isExcit(iNeuron) = isExcitatory(idx(iNeuron));
        
        AandDs(iNeuron,:) = neurites(idx(iNeuron),:);
        
    end
    
end