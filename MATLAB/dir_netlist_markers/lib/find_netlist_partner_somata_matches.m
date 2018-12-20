function netlistPartnerMarkerAndSomataMatches = find_netlist_partner_somata_matches(netlistPartnerNeuronTypeNameStr, ...
    netlistPartnerMarkerMatches, somata)

    allSomataNeuronTypeNamesStr = somata.txt(:, 1);
    
    % find the netlist partner's neuron-type name in the list of all somata neuron-type names
    idxNetlistPartnerRow = find(strcmp([allSomataNeuronTypeNamesStr], netlistPartnerNeuronTypeNameStr)) - 1; % account for header row
    
    % take note of the somata associated with the netlist partner
    netlistPartnerSomata = somata.num(idxNetlistPartnerRow, :);
    
    c = 1;
    nNeuronTypeNames = length(netlistPartnerMarkerMatches.neuronTypeNames);
    for i = 1:nNeuronTypeNames
        % find the netlist partner's matches of neuron-type names in the list of all somata neuron-type names
        idxNetlistPartnerMatchRow = find(strcmp([allSomataNeuronTypeNamesStr], ...
            netlistPartnerMarkerMatches.neuronTypeNames{i})) - 1; % account for header row
    
        % take note of the somata associated with the netlist partner's match
        netlistPartnerMatchSomata = somata.num(idxNetlistPartnerMatchRow, :);
    
        % take the dot product of the netlist partner somata locations and the partner's match's
        % somata locations to determine if there is any overlap of somata locations
        dotProduct = netlistPartnerSomata .* netlistPartnerMatchSomata;
        if (sum(dotProduct) > 0) % at least one soma overlap location
            netlistPartnerMarkerAndSomataMatches.neuronTypeNames(c) = netlistPartnerMarkerMatches.neuronTypeNames(i);
            netlistPartnerMarkerAndSomataMatches.somata(c, :) = netlistPartnerMatchSomata;
            c = c + 1;
        end
    end % i

    if (c == 1) % no soma overlaps found
        netlistPartnerMarkerAndSomataMatches.neuronTypeNames{1} = 'No Matches';
        netlistPartnerMarkerAndSomataMatches.somata(1) = -1000;
    end
    
end % find_netlist_partner_somata_matches()
