function isSaved = save_network_measure(measure, baseFileName, measureTxt)

    fprintf(1, '\nSaving ...')

    isSaved = 0;

    saveFileName = sprintf('./output/sporns_output/%s_%s.txt', baseFileName, measureTxt);

    saveascii(measure, saveFileName, 0, '\t');

    isSaved = 1;
    
end % save_network_measure
