function isSaved = save_Cij_measure(measure, baseFileName, measureTxt, ...
                                    precision)

    fprintf(1, '\nSaving %s...', measureTxt)

    isSaved = 0;

    saveFileName = sprintf('./output/sporns_output/%s_%s.txt', baseFileName, measureTxt);

    if (ndims(measure) == 3)

        precisionText = sprintf('%%.%df\\t', precision);

        %        precisionText = sprintf('%%.%df\\n', precision);

        writeascii(saveFileName, measure, precisionText, 'w');

    else

        %        saveascii(measure, saveFileName, precision, '\t');

        saveascii(measure, saveFileName, precision, '\n');

    end

    isSaved = 1;
    
end % save_Cij_measure
