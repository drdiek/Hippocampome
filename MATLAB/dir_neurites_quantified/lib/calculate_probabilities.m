function [overlapBinary,quantity] = calculate_probabilities(nNeurons,nParcels,overlapBinary,neuritesQuantified,quantity)
    
    axons = (overlapBinary.data == 1) + (overlapBinary.data == 3);
    dendrites = (overlapBinary.data == 2) + (overlapBinary.data == 3);
    
    for i = 1:nNeurons        
        for j = 1:nNeurons            
            overlapBinary.probability(i,j) = (2*(overlapBinary.EorI{i} == 'E')-1)*sign(sum(axons(i,1:nParcels).*dendrites(j,1:nParcels)));
        end % j    
    end % i
    
    axons = zeros(nNeurons,nParcels);
    dendrites = zeros(nNeurons,nParcels);

    idx = quantity.idx; % indexes corresponding to unique neurites [uniqueID:subregion:layer:A/D]
    
    for k = 1:length(quantity.means)        
        i = find(overlapBinary.uniqueIds == neuritesQuantified.uniqueIds(idx(k)));
        j = parcel_lookup(neuritesQuantified.parcels{idx(k)});
        if strcmp(neuritesQuantified.neurites(idx(k)),'A')  
            if isnan(quantity.means(k))
                axons(i,j) = 0;
            else
                axons(i,j) = isfinite(quantity.means(k))*quantity.means(k);
            end
        else % neuritesQuantified.neurites(idx(k)) == 'D'
            if isnan(quantity.means(k))
                dendrites(i,j) = 0;
            else
                dendrites(i,j) = isfinite(quantity.means(k))*quantity.means(k);
            end
        end                    
    end % k
    
    quantity.axons = axons;
    quantity.dendrites = dendrites;

    for i = 1:nNeurons
        for j = 1:nNeurons
            quantity.probability(i,j) = sum(axons(i,1:nParcels).*dendrites(j,1:nParcels));
            for k = 1:nParcels
                quantity.tensor(i,j,k) = axons(i,k)*dendrites(j,k);
            end % k
        end % j
    end % i
    
end % calculate_probabilities()