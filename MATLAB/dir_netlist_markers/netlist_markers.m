function netlist_markers()

    clear all;
    
    addpath('lib');
    
    netlistFileName = './data/netlist_markers.xlsx';
    [netlist.txt, netlist.raw] = read_netlist(netlistFileName);
    
    markersFileName = './data/netlist_markers.xlsx';
    [markers.num, markers.txt, markers.raw] = read_markers(markersFileName);
    
    somataFileName = './data/netlist_markers.xlsx';
    [somata.num, somata.txt, somata.raw] = read_somata(somataFileName);

    outputFileName = sprintf('./output/netlist_marker_matches_%s.csv', datestr(now, 'yyyymmddHHMMSS'));
    fid1 = fopen(outputFileName, 'w');
    fprintf(fid1, '%s,%s,prePartner Matches,postPartner Matches\n', netlist.txt{1, 1}, netlist.txt{1, 2});
    
    outputFileName = sprintf('./output/netlist_marker_and_somata_matches_%s.csv', datestr(now, 'yyyymmddHHMMSS'));
    fid2 = fopen(outputFileName, 'w');
    fprintf(fid2, '%s,%s,prePartner Matches,postPartner Matches\n', netlist.txt{1, 1}, netlist.txt{1, 2});
    
    pairsHistogram = zeros(1,50);
    
    disp(' ');
    disp('Finding and writing matches ...');
    % scan through netlist one line at a time
    for i = 2:length(netlist.txt) % skip header row
        clear netlistPrePartnerMarkerMatches netlistPostPartnerMarkerMatches netlistPrePartnerMarkerAndSomataMatches ...
            netlistPostPartnerMarkerAndSomataMatches
        
        netlistPrePartnerNeuronTypeNameStr = netlist.txt{i, 1};    
        isPreNetlistPartner = 1;
        netlistPrePartnerMarkerMatches = find_netlist_partner_marker_expressions_matches(isPreNetlistPartner, ...
            netlistPrePartnerNeuronTypeNameStr, markers);
        
        netlistPostPartnerNeuronTypeNameStr = netlist.txt{i, 2};        
        isPreNetlistPartner = 0;
        netlistPostPartnerMarkerMatches = find_netlist_partner_marker_expressions_matches(isPreNetlistPartner, ...
            netlistPostPartnerNeuronTypeNameStr, markers);        
    
        fprintf(fid1, '%s,', netlistPrePartnerNeuronTypeNameStr);
        write_matching_neuron_type_names_to_file(fid1, netlistPrePartnerMarkerMatches.neuronTypeNames, ',');
        fprintf(fid1, '%s,', netlistPostPartnerNeuronTypeNameStr);
        write_matching_neuron_type_names_to_file(fid1, netlistPostPartnerMarkerMatches.neuronTypeNames, '\n');  
        
        if (netlistPrePartnerMarkerMatches.markers == -1000)
            netlistPrePartnerMarkerAndSomataMatches.neuronTypeNames{1} = 'No Matches';
        else
            netlistPrePartnerMarkerAndSomataMatches = find_netlist_partner_somata_matches(netlistPrePartnerNeuronTypeNameStr, ...
                netlistPrePartnerMarkerMatches, somata);
        end
        
        if (netlistPostPartnerMarkerMatches.markers == -1000)
            netlistPostPartnerMarkerAndSomataMatches.neuronTypeNames{1} = 'No Matches';
        else
            netlistPostPartnerMarkerAndSomataMatches = find_netlist_partner_somata_matches(netlistPostPartnerNeuronTypeNameStr, ...
                netlistPostPartnerMarkerMatches, somata);
        end
        
        fprintf(fid2, '%s,', netlistPrePartnerNeuronTypeNameStr);
        write_matching_neuron_type_names_to_file(fid2, netlistPrePartnerMarkerAndSomataMatches.neuronTypeNames, ',');
        fprintf(fid2, '%s,', netlistPostPartnerNeuronTypeNameStr);
        write_matching_neuron_type_names_to_file(fid2, netlistPostPartnerMarkerAndSomataMatches.neuronTypeNames, '\n');  
        
        nPreMatchesNeuronTypeNames = length(netlistPrePartnerMarkerAndSomataMatches.neuronTypeNames);
        nPostMatchesNeuronTypeNames = length(netlistPostPartnerMarkerAndSomataMatches.neuronTypeNames);
        
        nPairs = nPreMatchesNeuronTypeNames * nPostMatchesNeuronTypeNames;
        pairsHistogram(1, nPairs) = pairsHistogram(1, nPairs) + 1;
    end % i
    
    fclose(fid1);
    fclose(fid2);
   
    figure(1);
    bar(pairsHistogram);
    set(gca, 'YScale', 'log');
    
    histogramFileName = sprintf('./output/pairs_histogram_%s.csv', datestr(now, 'yyyymmddHHMMSS'));
    fid = fopen(histogramFileName, 'w');
    fprintf(fid, '# of Pairs,Counts\n');
    for i = 1:50
        fprintf(fid, '%d,%d\n', i, pairsHistogram(i));
    end
    fclose(fid);
    
end % netlist_markers()

