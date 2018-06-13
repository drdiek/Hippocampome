function plot_quantity(nNeurons,nParcels,nMeasurements,overlapBinary,neuritesQuantified,quantity)

    format long;
    
    BLACK = [0 0 0];
    BLUE = [0 0 1];
    BLUE_DARK = [0 0 0.5];
    BLUE_MEDIUM = [0 0 192]/255;
    BLUE_LIGHT = [143 172 255]/255;
    BLUE_SKY = [0 204 255]/255;
    BROWN = [153 102 51]/255;
    BROWN_DG = [91 45 10]/255;
    BROWN_CA3 = [165 131 107]/255;
    GRAY = [0.5 0.5 0.5];
    GRAY_DARK = [0.25 0.25 0.25];
    GRAY_MEDIUM = [0.375 0.375 0.375];
    GRAY_LIGHT = [0.75 0.75 0.75];
    GRAY_ULTRALIGHT = [0.90 0.90 0.90];
    GREEN = [0 0.5 0];
    GREEN_MEDIUM = [0 0.75 0];
    GREEN_BRIGHT = [0 1 0];
    GREEN_EC = [106 149 49]/255;
    GREEN_MEC = [122 187 51]/255;
    GREEN_LEC = [90 111 47]/255;
    ORANGE = [228 108 10]/255;
    ORANGE_LIGHT = [247 156 21]/255;
    ORANGE_CA1 = [217 104 13]/255;
    PURPLE = [0.5 0 0.5];
    PURPLE_LIGHT = [178 128 178]/255;
    RED = [1 0 0];
    RED_LIGHT = [255 178 178]/255;
    TEAL = [0 255 192]/255;
    WHITE = [1 1 1];
    YELLOW = [1 1 0];
    YELLOW_CA2 = [1 1 0];
    YELLOW_SUB = [255 192 0]/255;
    
    text(-11, -1, quantity.string, 'HorizontalAlignment', 'left', 'Rotation', 0, 'FontSize', 5);
    
    displayFontSize = 1;
    
    idx = quantity.idx;
    
    overlap = zeros(nNeurons,nParcels);
    
    % How to get plain white square when no A info present but D info is
    % present
    
    for i = 1:length(quantity.means)
        vTab = find(overlapBinary.uniqueIds == neuritesQuantified.uniqueIds(idx(i)));
        hTab = parcel_lookup(neuritesQuantified.parcels{idx(i)})+1;
        str = sprintf('%.2f', quantity.means(i));
        if strcmp(neuritesQuantified.neurites(idx(i)),'A')
%             if (overlapBinary.data(vTab,hTab) == 1)
% %             if (overlap(vTab,hTab) == 0)
%                 rectangle('Position',[hTab+0.04, vTab+0.05, 0.93, 0.91], 'EdgeColor', 'None', 'FaceColor', WHITE);
%             end
            if (overlapBinary.data(vTab,hTab) == 1)
                rectangle('Position',[hTab+0.04, vTab+0.05, 0.92, 0.45], 'EdgeColor', 'None', 'FaceColor', RED);
%                 rectangle('Position',[hTab+0.04, vTab+0.5, 0.92, 0.46], 'EdgeColor', 'None', 'FaceColor', WHITE);
                if ((quantity.selection == 2) && (quantity.means(i) >= 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                elseif ((quantity.selection == 2) && (quantity.means(i) < 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', YELLOW);
                else
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                end
            elseif (overlapBinary.data(vTab,hTab) == 3)
                rectangle('Position',[hTab+0.04, vTab+0.05, 0.92, 0.45], 'EdgeColor', 'None', 'FaceColor', RED);
                if ((quantity.selection == 2) && (quantity.means(i) >= 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                elseif ((quantity.selection == 2) && (quantity.means(i) < 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', YELLOW);
                else
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                end
            elseif (overlapBinary.data(vTab,hTab) == 2)
                rectangle('Position',[hTab+0.04, vTab+0.05, 0.92, 0.45], 'EdgeColor', 'None', 'FaceColor', WHITE);
                if ((quantity.selection == 2) && (quantity.means(i) >= 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
                elseif ((quantity.selection == 2) && (quantity.means(i) < 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', GREEN);
                else
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
                end
            else
                if ((quantity.selection == 2) && (quantity.means(i) >= 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
                elseif ((quantity.selection == 2) && (quantity.means(i) < 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', GREEN);
                else
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                end                
            end
            overlap(vTab,hTab) = overlap(vTab,hTab) + 1;
        end
        if strcmp(neuritesQuantified.neurites(idx(i)),'D')
%             if (overlapBinary.data(vTab,hTab) == 2)
% %             if (overlap(vTab,hTab) == 0)
%                 rectangle('Position',[hTab+0.04, vTab+0.05, 0.93, 0.91], 'EdgeColor', 'None', 'FaceColor', WHITE);
%             end
            if (overlapBinary.data(vTab,hTab) == 2)
                rectangle('Position',[hTab+0.04, vTab+0.5, 0.92, 0.46], 'EdgeColor', 'None', 'FaceColor', BLUE);
%                 rectangle('Position',[hTab+0.04, vTab+0.05, 0.92, 0.45], 'EdgeColor', 'None', 'FaceColor', WHITE);
                if ((quantity.selection == 2) && (quantity.means(i) >= 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.75, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                elseif ((quantity.selection == 2) && (quantity.means(i) < 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.75, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', YELLOW);
                else
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                end
            elseif (overlapBinary.data(vTab,hTab) == 3)
                rectangle('Position',[hTab+0.04, vTab+0.5, 0.92, 0.46], 'EdgeColor', 'None', 'FaceColor', BLUE);
                if ((quantity.selection == 2) && (quantity.means(i) >= 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.75, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                elseif ((quantity.selection == 2) && (quantity.means(i) < 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.75, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', YELLOW);
                else
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                end
            elseif (overlapBinary.data(vTab,hTab) == 1)
                rectangle('Position',[hTab+0.04, vTab+0.5, 0.92, 0.46], 'EdgeColor', 'None', 'FaceColor', WHITE);
                if ((quantity.selection == 2) && (quantity.means(i) >= 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
                elseif ((quantity.selection == 2) && (quantity.means(i) < 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', GREEN);
                else
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
                end
            else
                if ((quantity.selection == 2) && (quantity.means(i) >= 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.75, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
                elseif ((quantity.selection == 2) && (quantity.means(i) < 15)) % percent of neurite tree
                    text(hTab+0.5, vTab+0.75, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', GREEN);
                else
                    text(hTab+0.5, vTab+0.25, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                end                
            end
%             rectangle('Position',[hTab+0.04, vTab+0.5, 0.93, 0.46], 'EdgeColor', 'None', 'FaceColor', BLUE);
%             text(hTab+0.5, vTab+0.75, str, 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', YELLOW);
            overlap(vTab,hTab) = overlap(vTab,hTab) + 1;
        end
        if (~strcmp(neuritesQuantified.neurites(idx(i)),'A') && ~strcmp(neuritesQuantified.neurites(idx(i)),'D'))
            if (overlapBinary.data(vTab,hTab) == 1)
                rectangle('Position',[hTab+0.04, vTab+0.05, 0.92, 0.45], 'EdgeColor', 'None', 'FaceColor', WHITE);
            end
            if (overlapBinary.data(vTab,hTab) == 2)
                rectangle('Position',[hTab+0.04, vTab+0.5, 0.92, 0.46], 'EdgeColor', 'None', 'FaceColor', WHITE);
            end
        end
    end % i
    
    %%%% save plots

    plotFileName = sprintf('./output/output');

    plotFileName = sprintf('%s_%s.eps', plotFileName, datestr(now, 'yyyymmdd_HHMMSS'));

    print(gcf, '-depsc', '-r800', plotFileName);


end % plot_quantity()
