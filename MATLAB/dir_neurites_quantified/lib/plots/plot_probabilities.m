function plot_probabilities(nNeurons,nCells,overlapBinary,quantity)

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
    YELLOW_Sub = [255 192 0]/255;
    
    regionColor = [BROWN_DG;
                   BROWN_CA3;
                   YELLOW_CA2;
                   ORANGE_CA1;
                   YELLOW_Sub;
                   GREEN_EC];
    
    DG = 1;
    CA3 = 2;
    CA2 = 3;
    CA1 = 4;
    Sub = 5;
    EC = 6;
               
    displayFontSize = 5;
    
    shadingLineWidths = 0.5;
    
    probabilityColormap = [ GRAY_LIGHT;  ... % -1: 
                            WHITE;       ... %  0: 
                            GRAY_DARK ]; ... % +1: 
    
              
    vStart = -2.05;
    vStartSummary = vStart - 4.5;

    hTabShift = 0;

    
    newplot
    clf('reset'); cla('reset');
    figure(1);
    
    set(gcf, 'color', 'w');

    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperSize', [13 11]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 13 11]);
 
    set(gca, 'Position', get(gca, 'OuterPosition') - get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]/3);

    hStart = nNeurons+11;
    hLineEnd = 7.0+4.25;

    vStartSummary = vStart - 4.5;

    hTabShift = 0;

    N = nNeurons+1;
    
    %% plot matrix %%

    colormap(probabilityColormap(1:3,:));
    
    probabilities = zeros(nNeurons+1, nNeurons+1);

    probabilities(1:nNeurons, 1:nNeurons) = overlapBinary.probability;
    
    pcolor(probabilities)
    
    axis ij
    axis equal
    axis off 

    axis([(vStart-35) (N+1) (-15+hTabShift) hStart+1])

    hold on
    
    displayFontSize = 0.5;
    
    for i = 1:nNeurons
        for j = 1:nNeurons
            if (quantity.probability(i,j) > 0)
                str = sprintf('%.2e', quantity.probability(i,j));
                if (overlapBinary.probability(i,j) == 0)
                    textColor = BLACK;
                    if strcmp(overlapBinary.EorI{i},'I')
                        textColor = GRAY;
                    end % strcmp
                    text(j+0.05, i+0.5, str, 'HorizontalAlignment', 'left', 'Rotation', 0, 'FontSize', displayFontSize, 'color', textColor);
                else                    
                    faceColor = BLACK;
                    if strcmp(overlapBinary.EorI{i},'I')
                        faceColor = GRAY;
                    end
                    rectangle('Position',[j+0.04, i+0.05, 0.92, 0.45], 'EdgeColor', 'None', 'FaceColor', faceColor);
                    rectangle('Position',[j+0.04, i+0.5, 0.92, 0.46], 'EdgeColor', 'None', 'FaceColor', faceColor);
                    text(j+0.05, i+0.5, str, 'HorizontalAlignment', 'left', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
                end % if ==
            end % if >
        end % j
    end % i
    
    %%% color-coded tags for the subregions
    rectangle('Position',[1, 0, nCells.DG, 1], 'EdgeColor', 'None', 'FaceColor', regionColor(DG,:));
    rectangle('Position',[nCells.DG+1, 0, nCells.CA3, 1], 'EdgeColor', 'None', 'FaceColor', regionColor(CA3,:));
    rectangle('Position',[nCells.DG+nCells.CA3+1, 0, nCells.CA2, 1], 'EdgeColor', 'None', 'FaceColor', regionColor(CA2,:));
    rectangle('Position',[nCells.DG+nCells.CA3+nCells.CA2+1, 0, nCells.CA1, 1], 'EdgeColor', 'None', 'FaceColor', regionColor(CA1,:));
    rectangle('Position',[nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+1, 0, nCells.Sub, 1], 'EdgeColor', 'None', 'FaceColor', regionColor(Sub,:));
    rectangle('Position',[nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub+1, 0, nCells.EC, 1], 'EdgeColor', 'None', 'FaceColor', regionColor(EC,:));
    
    rectangle('Position',[0, 1, 1, nCells.DG], 'EdgeColor', 'None', 'FaceColor', regionColor(DG,:));
    rectangle('Position',[0, nCells.DG+1, 1, nCells.CA3], 'EdgeColor', 'None', 'FaceColor', regionColor(CA3,:));
    rectangle('Position',[0, nCells.DG+nCells.CA3+1, 1, nCells.CA2], 'EdgeColor', 'None', 'FaceColor', regionColor(CA2,:));
    rectangle('Position',[0, nCells.DG+nCells.CA3+nCells.CA2+1, 1, nCells.CA1], 'EdgeColor', 'None', 'FaceColor', regionColor(CA1,:));
    rectangle('Position',[0, nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+1, 1, nCells.Sub], 'EdgeColor', 'None', 'FaceColor', regionColor(Sub,:));
    rectangle('Position',[0, nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub+1, 1, nCells.EC], 'EdgeColor', 'None', 'FaceColor', regionColor(EC,:));
    
    %%% parcellation subregion headers
    DGtab = 1 + nCells.DG/2;
    CA3tab = 1 + nCells.DG + nCells.CA3/2;
    CA2tab = 1 + nCells.DG + nCells.CA3 + nCells.CA2/2;
    CA1tab = 1 + nCells.DG + nCells.CA3 + nCells.CA2 + nCells.CA1/2;
    Subtab = 1 + nCells.DG + nCells.CA3 + nCells.CA2 + nCells.CA1 + nCells.Sub/2;
    ECtab = 1 + nCells.DG + nCells.CA3 + nCells.CA2 + nCells.CA1 + nCells.Sub + nCells.EC/2;

    text(DGtab, 0.5, 'DG', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize*10, 'color', WHITE);
    text(CA3tab, 0.5, 'CA3', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize*10, 'color', WHITE);
    text(CA2tab, 0.5, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize*10, 'color', BLACK);
    text(CA1tab, 0.5, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize*10, 'color', WHITE);
    text(Subtab, 0.5, 'Sub', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize*10, 'color', BLACK);
    text(ECtab, 0.5, 'EC', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize*10, 'color', WHITE);    
    
    text(0.5, DGtab, 'DG', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize*10, 'color', WHITE);
    text(0.5, CA3tab, 'CA3', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize*10, 'color', WHITE);
    text(0.5, CA2tab, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize*10, 'color', BLACK);
    text(0.5, CA1tab, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize*10, 'color', WHITE);
    text(0.5, Subtab, 'Sub', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize*10, 'color', BLACK);
    text(0.5, ECtab, 'EC', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize*10, 'color', WHITE);    
    
    for i = 1:nNeurons
        if strcmp(overlapBinary.EorI{i},'E')
            textColor = BLACK;
        else
            textColor = GRAY;
        end
        text(i+0.5, -0.25, overlapBinary.abbreviations{i}, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize*10, 'color', textColor);
    end

    for i = 1:nNeurons
        if strcmp(overlapBinary.EorI{i},'E')
            textColor = BLACK;
        else
            textColor = GRAY;
        end
        text(-0.25, i+0.5, overlapBinary.abbreviations{i}, 'HorizontalAlignment', 'right', 'Rotation', 0, 'FontSize', displayFontSize*10, 'color', textColor);
    end

    %%%% save plots

    plotFileName = sprintf('./output/probabilities');
    plotFileName = sprintf('%s_%s.eps', plotFileName, datestr(now, 'yyyymmddHHMM_SS'));
    print(gcf, '-depsc2', '-r800', plotFileName);
    
end % plot_probabilities

