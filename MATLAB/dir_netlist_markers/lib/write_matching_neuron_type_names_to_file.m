function write_matching_neuron_type_names_to_file(fid, netlistPartnerMatchingNeuronTypeNames, endStr)

    nNeuronTypeNames = length(netlistPartnerMatchingNeuronTypeNames);
    for j = 1:nNeuronTypeNames
        fprintf(fid, '%s', netlistPartnerMatchingNeuronTypeNames{j});
        if ((nNeuronTypeNames > 1) && (j < nNeuronTypeNames))
            fprintf(fid, '; ');
        end
    end
    fprintf(fid, endStr);
    
end % write_matching_neuron_type_names_to_file()