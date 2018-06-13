function PT_neurites()

    addpath data lib

    [fileName, reply] = get_file_name_PT_neurites();
    if strcmp(reply,'!')
        disp(' ');
        return
    else
        disp(' ');
    end
    
    [nNeurons,nParcels,percentOfPresence,density] = initialize_variables(fileName);
    
    [percentOfPresence] = load_percent_of_presence_data(nNeurons,nParcels,percentOfPresence);
    
    [density] = load_density_data(nNeurons,nParcels,density);
    
    [neuronTypeNames,nCellsRecorded,is] = load_misc_variables(nNeurons,nParcels,percentOfPresence);
 
    [connectionProbabilities] = calculate_connection_probabilities(nNeurons,nParcels,density,is);
    
    plot_periodic_table(nNeurons,nParcels,percentOfPresence,connectionProbabilities,is);

    save_connection_probabilities(nNeurons,nParcels,neuronTypeNames,connectionProbabilities);

%     plotFileName = ['PT_output/', fileName(1:end-4), '_fig2.eps'];
%     
%     print(gcf, '-depsc', '-r800', plotFileName);
%     
%     plotFileName = ['PT_output/', fileName(1:end-4), '_fig2.tif'];
% 
%     print(gcf, '-dtiffnocompression', '-r600', plotFileName);
    
end % neurites()