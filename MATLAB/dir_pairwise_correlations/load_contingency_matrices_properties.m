function [properties, typeIds, nTypeIds, typeNames, propertyNames] = load_contingency_matrices_properties(nTypeIds, nProperties)

%     load pairwise_correlations_defs.mat
% 
    [typeIds, isFileLoaded] = load_csvFile('HC_type_IDs_sorted.csv'); % load the unique ID assigned to each Hippocampome neuronal type
    
%    nTypeIds = length(typeIds);
    
    [type_property_matrix, isFileLoaded] = load_csvFile('type_property_vectors.csv');
    
    % properties = randi([0,1], nTypeIds, nProperties);
    
    for i = 1:nTypeIds
        
        for j = 1:nProperties
            
            properties(i,j) = type_property_matrix{i+1,j+1};
            
            if (i == 1)
                
                propertyNames{j} = type_property_matrix{1,j+1};
                
            end
            
        end % for j
        
        typeNames{i} = type_property_matrix{i+1,1};
        
    end % for i
    
end % load_contingency_matrices_properties()