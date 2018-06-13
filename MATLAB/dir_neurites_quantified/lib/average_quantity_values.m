function quantity = average_quantity_values(nMeasurements,neuritesQuantified,quantity)

    for i = 1:nMeasurements
        neurites{i} = sprintf('%d:%s:%s', neuritesQuantified.uniqueIds(i), ...
                                          cell2mat(neuritesQuantified.parcels(i)), ...
                                          cell2mat(neuritesQuantified.neurites(i)) );
    end
    
    [uniqueNeurites,quantity.idx] = unique(neurites);

    for i = 1:length(uniqueNeurites)
        [truefalse, idx] = cellfind(uniqueNeurites{i},neurites);
        quantity.factor(i) = length(idx);
        quantity.means(i) = mean(quantity.values(idx));
        quantity.uniqueIds(i) = neuritesQuantified.uniqueIds(idx(1));
    end
    
end % average_quantity_values()