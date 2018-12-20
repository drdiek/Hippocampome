function netlistPartnerMatches = find_netlist_partner_marker_expressions_matches(isPreNetlistPartner, ...
    netlistPartnerNeuronTypeNameStr, markers)

    allMarkerNeuronTypeNamesStr = markers.txt(:, 2);
    
    % find the netlist partner's neuron-type name in the list of marker neuron-type names
    idxNetlistPartnerRow = find(strcmp([allMarkerNeuronTypeNamesStr], netlistPartnerNeuronTypeNameStr)) - 1; % account for header row
    
    % take note of the marker expressions associated with the partner
    netlistPartnerMarkers = markers.num(idxNetlistPartnerRow, :);
    
    allMarkers = markers.num;
    
    % find all of the rows in the full marker list that match the netlist partner markers
%     netlistPartnerMatchingMarkers = intersect(allMarkers, netlistPartnerMarkers, 'rows');
%     idxNetlistPartnerMatchingMarkersRows = find(ismember(allMarkers, netlistPartnerMatchingMarkers, 'rows'));
    idxNetlistPartnerMatchingMarkersRows = find(ismember(allMarkers, netlistPartnerMarkers, 'rows'));
    
    nNetlistPartnerMatchingMarkersRows = length(idxNetlistPartnerMatchingMarkersRows);
    if isPreNetlistPartner
        netlistPartnerStr = 'netlist prePartner';
    else
        netlistPartnerStr = 'netlist postPartner';
    end
    % check to see if at least one row of markers matches the netlist partner markers
    if (nNetlistPartnerMatchingMarkersRows > 1)
        c = 1;
        for j = 1:nNetlistPartnerMatchingMarkersRows
            % skip over marker row that is the netlist partner marker row
            if (idxNetlistPartnerMatchingMarkersRows(j) ~= idxNetlistPartnerRow)
                netlistPartnerMatches.neuronTypeNames(c) = markers.txt(idxNetlistPartnerMatchingMarkersRows(j)+1, 2); % +1 accounts for header row
                netlistPartnerMatches.markers(c, :) = markers.num(idxNetlistPartnerMatchingMarkersRows(j), 2);
                netlistPartnerNeuronTypeNameMatch = netlistPartnerMatches.neuronTypeNames{c};
                strng = sprintf('Marker expression match for %s %s = %s', netlistPartnerStr, netlistPartnerNeuronTypeNameStr, netlistPartnerNeuronTypeNameMatch);
%                 disp(strng);
                c = c + 1;
            end
        end
    else % there are no other marker expression matches to the netlist partner markers
        netlistPartnerMatches.neuronTypeNames{1} = 'No Matches';
        netlistPartnerMatches.markers(1, 1) = -1000;
        strng = sprintf('Marker expression match for %s %s = %s', netlistPartnerStr, netlistPartnerNeuronTypeNameStr, netlistPartnerMatches.neuronTypeNames{1});
%         disp(strng);
    end
    
    if ~isPreNetlistPartner
%         disp(' ');
    end
end % find_netlist_partner_marker_expressions_matches()
