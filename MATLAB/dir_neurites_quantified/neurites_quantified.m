function neurites_quantified()

    addpath(genpath('lib'),'data')

    [nNeurons,nParcels,nMeasurements,nCells,nLayers,overlapBinary,neuritesQuantified] = initialize_variables();
    
    quantity = menu_plot(neuritesQuantified);
    if (strcmp(quantity,'!'))
        disp(' ');
        return;
    end
    
    if (quantity.selection ~= 6)
        subregion = menu_subregion(nCells);
        if (strcmp(subregion,'!'))
            disp(' ');
            return;
        end
    end
    
    quantity = average_quantity_values(nMeasurements,neuritesQuantified,quantity);
    
    if (quantity.selection > 5)
        
        [overlapBinary,quantity] = calculate_probabilities(nNeurons,nParcels,overlapBinary,neuritesQuantified,quantity);
        
        if (quantity.selection == 6) % Probabilities
            plot_probabilities(nNeurons,nCells,overlapBinary,quantity);
            
        else % quantity.selection == 7; Periodic table
            plot_periodic_table(nNeurons,nParcels,nCells,quantity,neuritesQuantified,overlapBinary,subregion);
        end
    else
    
        plot_overlap_binary(nParcels,nCells,nLayers,overlapBinary,quantity,subregion);
        
        plot_quantity(nNeurons,nParcels,overlapBinary,neuritesQuantified,quantity,subregion);
    
    end
    
end % neurites_quantified()