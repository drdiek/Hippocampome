function cellArray = append_data_structure(dataStruct, brainRegion, cellType, nNeuronResources, nBrainRegions2Save, ...
    nCellTypes2Save, cellArray)

    disp(' ');
    strng = sprintf('Appending %s:%s to data structure ...', brainRegion, cellType);
    disp(strng);
    
    dataStructFileName = sprintf('./output/%s_%s_%s.xlsx', brainRegion, cellType, datestr(now, 'yyyymmddHHMMSS'));

    cellArray{1,1} = 'Hippocampome_ID';
    cellArray{1,2} = 'reason_for_exclusion';
    cellArray{1,3} = 'Supertype_ID';
    cellArray{1,4} = 'neuron_id';
    cellArray{1,5} = 'neuron_name';
    cellArray{1,6} = 'archive';
    cellArray{1,7} = 'note';
    cellArray{1,8} = 'age_classification';
    for i = 1:nBrainRegions2Save
        cellArray{1,i+8} = sprintf('brain_region_%d', i);
    end
    for i = 1:nCellTypes2Save
        cellArray{1,i+8+nBrainRegions2Save} = sprintf('cell_type_%d', i);
    end
    i = 8+nBrainRegions2Save+nCellTypes2Save+1;
    cellArray{1,i} = 'species';
    i = i + 1;
    cellArray{1,i} = 'strain';
    i = i + 1;
    cellArray{1,i} = 'scientific_name';
    i = i + 1;
    cellArray{1,i} = 'stain';
    i = i + 1;
    cellArray{1,i} = 'experiment_condition';
    i = i + 1;
    cellArray{1,i} = 'protocol';
    i = i + 1;
    cellArray{1,i} = 'slicing_direction';
    i = i + 1;
    cellArray{1,i} = 'reconstruction_software';
    i = i + 1;
    cellArray{1,i} = 'objective_type';
    i = i + 1;
    cellArray{1,i} = 'original_format';
    i = i + 1;
    cellArray{1,i} = 'domain';
    i = i + 1;
    cellArray{1,i} = 'attributes';
    i = i + 1;
    cellArray{1,i} = 'magnification';
    i = i + 1;
    cellArray{1,i} = 'upload_date';
    i = i + 1;
    cellArray{1,i} = 'deposition_date';
    i = i + 1;
    cellArray{1,i} = 'shrinkage_reported';
    i = i + 1;
    cellArray{1,i} = 'shrinkage_corrected';
    i = i + 1;
    cellArray{1,i} = 'reported_value';
    i = i + 1;
    cellArray{1,i} = 'reported_xy';
    i = i + 1;
    cellArray{1,i} = 'reported_z';
    i = i + 1;
    cellArray{1,i} = 'corrected_value';
    i = i + 1;
    cellArray{1,i} = 'corrected_xy';
    i = i + 1;
    cellArray{1,i} = 'corrected_z';
    i = i + 1;
    cellArray{1,i} = 'soma_surface';
    i = i + 1;
    cellArray{1,i} = 'surface';
    i = i + 1;
    cellArray{1,i} = 'volume';
    i = i + 1;
    cellArray{1,i} = 'slicing_thickness';
    i = i + 1;
    cellArray{1,i} = 'min_age';
    i = i + 1;
    cellArray{1,i} = 'max_age';
    i = i + 1;
    cellArray{1,i} = 'min_weight';
    i = i + 1;
    cellArray{1,i} = 'max_weight';
    i = i + 1;
    cellArray{1,i} = 'png_url';
    i = i + 1;
    cellArray{1,i} = 'reference_pmid';
    i = i + 1;
    cellArray{1,i} = 'reference_doi';
    i = i + 1;
    cellArray{1,i} = 'physical_Integrity';
    i = i + 1;
    cellArray{1,i} = 'x0x5F_links';
    nColumns = i;
    
    for i = 1:nNeuronResources
        cellArray{i+1,4} = dataStruct.alpha__embedded.neuronResources{1,i}.neuron_id;
        cellArray{i+1,5} = dataStruct.alpha__embedded.neuronResources{1,i}.neuron_name;
        cellArray{i+1,6} = dataStruct.alpha__embedded.neuronResources{1,i}.archive;
        cellArray{i+1,7} = dataStruct.alpha__embedded.neuronResources{1,i}.note;
        cellArray{i+1,8} = dataStruct.alpha__embedded.neuronResources{1,i}.age_classification;
        nBrainRegions = size(dataStruct.alpha__embedded.neuronResources{1,i}.brain_region,2);
        for j = 1:nBrainRegions
            cellArray{i+1,j+8} = dataStruct.alpha__embedded.neuronResources{1,i}.brain_region{1,j};
        end
        nCellTypes = size(dataStruct.alpha__embedded.neuronResources{1,i}.cell_type,2);
        for j = 1:nCellTypes
            cellArray{i+1,j+8+nBrainRegions2Save} = dataStruct.alpha__embedded.neuronResources{1,i}.cell_type{1,j};
        end
        c = 8+nBrainRegions2Save+nCellTypes2Save+1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.species;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.strain;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.scientific_name;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.stain;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.experiment_condition;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.protocol;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.slicing_direction;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reconstruction_software;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.objective_type;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.original_format;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.domain;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.attributes;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.magnification;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.upload_date;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.deposition_date;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.shrinkage_reported;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.shrinkage_corrected;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reported_value;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reported_xy;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reported_z;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.corrected_value;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.corrected_xy;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.corrected_z;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.soma_surface;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.surface;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.volume;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.slicing_thickness;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.min_age;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.max_age;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.min_weight;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.max_weight;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.png_url;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reference_pmid;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.reference_doi;
        c = c + 1;
        cellArray{i+1,c} = dataStruct.alpha__embedded.neuronResources{1,i}.physical_Integrity;

    end % i

    xlswrite(dataStructFileName, cellArray);

end % save_data_structure()