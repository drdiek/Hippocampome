function cellArray = append_cell_array(cellArray, dataStruct, brainRegion, cellType, nNeuronResources, nBrainRegions2Save, ...
    nCellTypes2Save, nPmids2Save, nDois2Save)

    disp(' ');
    strng = sprintf('Appending %d %s:%s cells to cell array ...', nNeuronResources, brainRegion, cellType);
    disp(strng);
    
    nRows = size(cellArray,1);
    
    for i = 1:nNeuronResources
        cellArray{i+nRows,5} = dataStruct.alpha__embedded.neuronResources{1,i}.neuron_id;
        cellArray{i+nRows,6} = dataStruct.alpha__embedded.neuronResources{1,i}.neuron_name;
        cellArray{i+nRows,7} = dataStruct.alpha__embedded.neuronResources{1,i}.archive;
        cellArray{i+nRows,8} = dataStruct.alpha__embedded.neuronResources{1,i}.note;
        cellArray{i+nRows,9} = dataStruct.alpha__embedded.neuronResources{1,i}.age_classification;
        nBrainRegions = size(dataStruct.alpha__embedded.neuronResources{1,i}.brain_region,2);
        for j = 1:nBrainRegions
            cellArray{i+nRows,j+9} = dataStruct.alpha__embedded.neuronResources{1,i}.brain_region{1,j};
        end
        nCellTypes = size(dataStruct.alpha__embedded.neuronResources{1,i}.cell_type,2);
        for j = 1:nCellTypes
            cellArray{i+nRows,j+9+nBrainRegions2Save} = dataStruct.alpha__embedded.neuronResources{1,i}.cell_type{1,j};
        end
        c = 9+nBrainRegions2Save+nCellTypes2Save+1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.species;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.strain;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.scientific_name;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.stain;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.experiment_condition;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.protocol;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.slicing_direction;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reconstruction_software;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.objective_type;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.original_format;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.domain;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.attributes;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.magnification;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.upload_date;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.deposition_date;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.shrinkage_reported;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.shrinkage_corrected;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reported_value;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reported_xy;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reported_z;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.corrected_value;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.corrected_xy;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.corrected_z;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.soma_surface;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.surface;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.volume;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.slicing_thickness;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.min_age;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.max_age;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.min_weight;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.max_weight;
        c = c + 1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.png_url;
        nPmids = size(dataStruct.alpha__embedded.neuronResources{1,i}.reference_pmid,2);
        for j = 1:nPmids
            cellArray{i+nRows,j+c} = dataStruct.alpha__embedded.neuronResources{1,i}.reference_pmid{1,j};
        end
        nDois = size(dataStruct.alpha__embedded.neuronResources{1,i}.reference_doi,2);
        for j = 1:nDois
            cellArray{i+nRows,j+c+nPmids2Save} = dataStruct.alpha__embedded.neuronResources{1,i}.reference_doi{1,j};
        end
        c = c+nPmids2Save+nDois2Save+1;
        cellArray{i+nRows,c} = dataStruct.alpha__embedded.neuronResources{1,i}.physical_Integrity;

    end % i

end % append_cell_array()