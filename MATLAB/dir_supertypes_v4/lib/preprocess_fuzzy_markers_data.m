function markersMatrix = preprocess_fuzzy_markers_data(data)

    load('./lib/constants.mat');
    
    N = size(data,1);
    
    markersMatrix = data(1:N,CCKPOS_COL:SOMPOS_COL);

end % preprocess_fuzzy_markers_data()