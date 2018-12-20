function SWC2ABA_plots()

    clear all;    

    addpath(genpath('lib'));
    
    csvFileName = select_file_csv();
    if strcmp(csvFileName, '!')
        return;
    end
    
    if strfind(csvFileName, 'ARA')
        plotLabel = 'ARA\_Old';
    else
        plotLabel = 'Atlas\_V3';
    end
    
    [cells, isFileLoaded] = load_csv_file(csvFileName);
    
    if isFileLoaded
       
        [nRows, nColumns] = size(cells);

        nSkipRows = 1;        
        nSkipColumns = 1;
        
        neuronColumnNo = 1;
        parcelRowNo = 1;
    
        nNeurons  = nRows - nSkipRows;
        nParcels = nColumns - nSkipColumns;
        
        neuronLabels = cells(nSkipRows+[1:nNeurons], neuronColumnNo);
        parcelLabels = cells(parcelRowNo, nSkipColumns+[1:nParcels]);
        
        morphologyMatrix = cell2mat(cells(nSkipRows+[1:nNeurons], nSkipColumns+[1:nParcels]));

        plot_morphology_matrix(morphologyMatrix, neuronLabels, parcelLabels, plotLabel);
        
    end

end % SWC2ABA_plots()