function save_morphology_matrix(morphologyMatrix, nrrdFileStr)

    fileName = sprintf('./output/matrices/morphologyMatrix_%s_%s_%s_rawcounts.txt', ...
        morphologyMatrix.subregion, nrrdFileStr, datestr(now, 'yyyymmddHHMMSS'));
    fileNameHC = sprintf('./output/matrices/morphologyMatrix_%s_%s_%s_HC.txt', ...
        morphologyMatrix.subregion, nrrdFileStr, datestr(now, 'yyyymmddHHMMSS'));
    fileNameSoma = sprintf('./output/matrices/morphologyMatrix_%s_%s_%s_soma.txt', ...
        morphologyMatrix.subregion, nrrdFileStr, datestr(now, 'yyyymmddHHMMSS'));
    fileNamePercentages = sprintf('./output/matrices/morphologyMatrix_%s_%s_%s_percentages.txt', ...
        morphologyMatrix.subregion, nrrdFileStr, datestr(now, 'yyyymmddHHMMSS'));
    fileName15Percent = sprintf('./output/matrices/morphologyMatrix_%s_%s_%s_15percent.txt', ...
        morphologyMatrix.subregion, nrrdFileStr, datestr(now, 'yyyymmddHHMMSS'));
    
    fid = fopen(fileName, 'w'); % raw counts of points per parcel
    fid2 = fopen(fileNameHC, 'w'); % Hippocampome 0, 1, 2, 3 indicators for neurites
    fid3 = fopen(fileNameSoma, 'w'); % soma locations
    fid4 = fopen(fileNamePercentages, 'w'); % raw counts converted to percentages per parcel
    fid5 = fopen(fileName15Percent, 'w'); % percentages per parcel thresholded at 15% into 0, 1, 2, 3 neurites
        
    for col = 1:morphologyMatrix.nCols
        fprintf(fid, ';%s', cell2mat(morphologyMatrix.parcels(col)));
        fprintf(fid2, ';%s', cell2mat(morphologyMatrix.parcels(col)));
        fprintf(fid3, ';%s', cell2mat(morphologyMatrix.parcels(col)));
        fprintf(fid4, ';%s', cell2mat(morphologyMatrix.parcels(col)));
        fprintf(fid5, ';%s', cell2mat(morphologyMatrix.parcels(col)));
    end % col
    fprintf(fid, '\n');
    fprintf(fid2, '\n');
    fprintf(fid3, '\n');
    fprintf(fid4, '\n');
    fprintf(fid5, '\n');
    
    for row = 1:morphologyMatrix.nRows
        
        fprintf(fid, '%s [A]', cell2mat(morphologyMatrix.neuronTypes(row)));
        for col = 1:morphologyMatrix.nCols
            fprintf(fid, ';%d', morphologyMatrix.axonCounts(row, col));
        end % col
        fprintf(fid, '\n');
        fprintf(fid, '%s [D]', cell2mat(morphologyMatrix.neuronTypes(row)));
        for col = 1:morphologyMatrix.nCols
            fprintf(fid, ';%d', morphologyMatrix.dendriteCounts(row, col));
        end % col
        fprintf(fid, '\n');
        
        fprintf(fid2, '%s', cell2mat(morphologyMatrix.neuronTypes(row)));
        for col = 1:morphologyMatrix.nCols
            if ((morphologyMatrix.axonCounts(row, col) > 1) && (morphologyMatrix.dendriteCounts(row, col) > 1))
                fprintf(fid2, ';3');
            elseif (morphologyMatrix.axonCounts(row, col) > 1)
                fprintf(fid2, ';1');
            elseif (morphologyMatrix.dendriteCounts(row, col) > 1)
                fprintf(fid2, ';2');
            else
                fprintf(fid2, ';0');
            end
        end % col
        fprintf(fid2, '\n');
        
        fprintf(fid3, '%s', cell2mat(morphologyMatrix.neuronTypes(row)));
        for col = 1:morphologyMatrix.nCols
            if (morphologyMatrix.somaCounts(row, col) > 1)
                fprintf(fid3, ';1');
            end
        end % col
        fprintf(fid3, '\n');
        
        fprintf(fid4, '%s [A]', cell2mat(morphologyMatrix.neuronTypes(row)));
        for col = 1:morphologyMatrix.nCols
            axonalPercentages(row, col) = 100*morphologyMatrix.axonCounts(row, col)/sum(morphologyMatrix.axonCounts(row, :));
            fprintf(fid4, ';%.2f', axonalPercentages(row, col));
        end % col
        fprintf(fid4, '\n');
        fprintf(fid4, '%s [D]', cell2mat(morphologyMatrix.neuronTypes(row)));
        for col = 1:morphologyMatrix.nCols
            dendriticPercentages(row, col) = 100*morphologyMatrix.dendriteCounts(row, col)/sum(morphologyMatrix.dendriteCounts(row, :));
            fprintf(fid4, ';%.2f', dendriticPercentages(row, col));
        end % col
        fprintf(fid4, '\n');
        
        fprintf(fid5, '%s', cell2mat(morphologyMatrix.neuronTypes(row)));
        for col = 1:morphologyMatrix.nCols
            if ((axonalPercentages(row, col) >= 15) && (dendriticPercentages(row, col) >= 15))
                fprintf(fid5, ';3');
            elseif (axonalPercentages(row, col) >= 15)
                fprintf(fid5, ';1');
            elseif (dendriticPercentages(row, col) >= 15)
                fprintf(fid5, ';2');
            else
                fprintf(fid5, ';0');
            end
        end % col
        fprintf(fid5, '\n');
        
    end % row
    
    fclose(fid);
    fclose(fid2);
    fclose(fid3);
    fclose(fid4);
    fclose(fid5);

end % save_morphology_matrix()