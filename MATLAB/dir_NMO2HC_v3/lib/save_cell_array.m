function save_cell_array(cellArray, nBrainRegionsMaximum, nCellTypesMaximum, nPmidsMaximum, nDoisMaximum, ...
                         nBrainRegions2Save, nCellTypes2Save, nPmids2Save, nDois2Save)
    disp(' ');
    headerStr = sprintf('Writing cell array to file ...');
    disp(headerStr);
    
    nRows = size(cellArray,1);

    dataStructFileName = sprintf('./output/cellArray_%s.csv', datestr(now, 'yyyymmddHHMMSS'));

    fid = fopen(dataStructFileName, 'w');
    
%     headerStr = sprintf('Hippocampome_ID', headerStr);
%     headerStr = sprintf('%s,reason_for_exclusion', headerStr);
%     headerStr = sprintf('%s,reason_for_inclusion', headerStr);
%     headerStr = sprintf('%s,Supertype_ID', headerStr);
%     headerStr = sprintf('%s,neuron_id', headerStr);
%     headerStr = sprintf('%s,neuron_name', headerStr);
%     headerStr = sprintf('%s,archive', headerStr);
%     headerStr = sprintf('%s,note', headerStr);
%     headerStr = sprintf('%s,age_classification', headerStr);
%     for i = 1:nBrainRegionsMaximum
%         headerStr = sprintf('%s,brain_region_%d', headerStr, i);
%     end
%     headerStr = sprintf('%s,Hippocampome_name', headerStr);
%     headerStr = sprintf('%s,Hippocampome_status', headerStr);
%     headerStr = sprintf('%s,match_flag', headerStr);
%     for i = 1:nCellTypesMaximum
%         headerStr = sprintf('%s,cell_type_%d', headerStr, i);
%     end
%     headerStr = sprintf('%s,species', headerStr);
%     headerStr = sprintf('%s,strain', headerStr);
%     headerStr = sprintf('%s,scientific_name', headerStr);
%     headerStr = sprintf('%s,stain', headerStr);
%     headerStr = sprintf('%s,experiment_condition', headerStr);
%     headerStr = sprintf('%s,protocol', headerStr);
%     headerStr = sprintf('%s,slicing_direction', headerStr);
%     headerStr = sprintf('%s,reconstruction_software', headerStr);
%     headerStr = sprintf('%s,objective_type', headerStr);
%     headerStr = sprintf('%s,original_format', headerStr);
%     headerStr = sprintf('%s,domain', headerStr);
%     headerStr = sprintf('%s,attributes', headerStr);
%     headerStr = sprintf('%s,magnification', headerStr);
%     headerStr = sprintf('%s,upload_date', headerStr);
%     headerStr = sprintf('%s,deposition_date', headerStr);
%     headerStr = sprintf('%s,shrinkage_reported', headerStr);
%     headerStr = sprintf('%s,shrinkage_corrected', headerStr);
%     headerStr = sprintf('%s,reported_value', headerStr);
%     headerStr = sprintf('%s,reported_xy', headerStr);
%     headerStr = sprintf('%s,reported_z', headerStr);
%     headerStr = sprintf('%s,corrected_value', headerStr);
%     headerStr = sprintf('%s,corrected_xy', headerStr);
%     headerStr = sprintf('%s,corrected_z', headerStr);
%     headerStr = sprintf('%s,soma_surface', headerStr);
%     headerStr = sprintf('%s,surface', headerStr);
%     headerStr = sprintf('%s,volume', headerStr);
%     headerStr = sprintf('%s,slicing_thickness', headerStr);
%     headerStr = sprintf('%s,min_age', headerStr);
%     headerStr = sprintf('%s,max_age', headerStr);
%     headerStr = sprintf('%s,min_weight', headerStr);
%     headerStr = sprintf('%s,max_weight', headerStr);
%     headerStr = sprintf('%s,png_url', headerStr);
%     for i = 1:nPmidsMaximum
%         headerStr = sprintf('%s,reference_pmid_%d', headerStr, i);
%     end
%     for i = 1:nDoisMaximum
%         headerStr = sprintf('%s,reference_doi_%d', headerStr, i);
%     end
%     headerStr = sprintf('%s,physical_Integrity', headerStr);
%     headerStr = sprintf('%s,x0x5F_links', headerStr);
% 
%     fprintf(fid, '%s\n', headerStr);
    
    for i = 1:nRows
        strng = sprintf('%s', cellArray{i, 1}); % Hippocampome_ID
        strng = sprintf('%s,"%s"', strng, cellArray{i, 2}); % reason_for_exclusion
        strng = sprintf('%s,"%s"', strng, cellArray{i, 3}); % reason_for_inclusion
        strng = sprintf('%s,"%s"', strng, cellArray{i, 4}); % Supertype_ID
        if (i == 1)
            strng = sprintf('%s,"%s"', strng, cellArray{i, 5}); % neuron_id
        else
            strng = sprintf('%s,%u', strng, cellArray{i, 5}); % neuron_id
        end
        strng = sprintf('%s,"%s"', strng, cellArray{i, 6}); % neuron_name
        strng = sprintf('%s,"%s"', strng, cellArray{i, 7}); % archive
        strng = sprintf('%s,"%s"', strng, cellArray{i, 8}); % note
        strng = sprintf('%s,"%s"', strng, cellArray{i, 9}); % age_classification
        c = 9;
        for j = 1:nBrainRegionsMaximum
            strng = sprintf('%s,"%s"', strng, cellArray{i, c+j}); % brain_region_%d
        end
        c = 9 + nBrainRegions2Save + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % Hippocampome_name
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % Hippocampome_status
        c = c + 1;
        if (i == 1)
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % match_flag
        else
            strng = sprintf('%s,%d', strng, cellArray{i, c}); % match_flag
        end
        for j = 1:nCellTypesMaximum
            strng = sprintf('%s,"%s"', strng, cellArray{i, c+j}); % cell_type_%d
        end
        c = c + nCellTypes2Save + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % species
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % strain
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % scientific_name
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % stain
        c = c + 1;
        experiment_condition = char(cellArray{i, c});
        strng = sprintf('%s,"%s"', strng, experiment_condition); % experiment_condition
%         strng = sprintf('%s,"%s"', strng, cell2mat(cellArray(i, c))); % experiment_condition
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % protocol
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % slicing_direction
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % reconstruction_software
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % objective_type
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % original_format
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % domain
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % attributes
        c = c + 1;
        if (i == 1)
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % magnification
        else
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % magnification
        end
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % upload_date
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % deposition_date
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % shrinkage_reported
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % shrinkage_corrected
        c = c + 1;
        if (i == 1)
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % reported_value
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % reported_xy
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % reported_z
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % corrected_value
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % corrected_xy
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % corrected_z
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % soma_surface
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % surface
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % volume
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % slicing_thickness
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % min_age
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % max_age
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % min_weight
            c = c + 1;
            strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % max_weight
        else
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % reported_value
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % reported_xy
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % reported_z
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % corrected_value
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % corrected_xy
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % corrected_z
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % soma_surface
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % surface
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % volume
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % slicing_thickness
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % min_age
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % max_age
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % min_weight
            c = c + 1;
            strng = sprintf('%s,%s', strng, cellArray{i, c}); % max_weight
        end
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % png_url
        if (i == 1)
            for j = 1:nPmidsMaximum
                strng = sprintf('%s,"%s"', strng, cellArray{i, c+j}); % reference_pmid_%d
            end
        else
            for j = 1:nPmidsMaximum
                strng = sprintf('%s,%s', strng, cellArray{i, c+j}); % reference_pmid_%d
            end
        end
        c = c + nPmids2Save;
        for j = 1:nDoisMaximum
            strng = sprintf('%s,"%s"', strng, cellArray{i, c+j}); % reference_doi_%d
        end
        c = c + nDois2Save + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % physical_Integrity
        c = c + 1;
        strng = sprintf('%s,"%s"', strng, cellArray{i, c}); % x0x5F_links
        
        fprintf(fid, '%s\n', strng);
    
    end

    fclose(fid);

end % save_cell_array()