function plot_morphology_matrix(morphologyMatrix, neuronLabels, parcelLabels, plotLabel)

    DG = 1;
    CA3 = 2;
    CA2 = 3;
    CA1 = 4;
    SUB = 5;
    EC = 6;

    BLACK = [0 0 0];
    BLUE = [0 0 1];
    BLUE_DARK = [0 0 0.5];
    BLUE_MEDIUM = [0 0 192]/255;
    BLUE_LIGHT = [143 172 255]/255;
    BLUE_SKY = [0 204 255]/255;
    BLUE_UBERLIGHT = [227 233 255]/255;
    BLUE_ULTRALIGHT = [199 214 255]/255;
    BROWN = [153 102 51]/255;
    BROWN_DG = [91 45 10]/255;
    BROWN_DG_MEDIUM = [124 61 14]/255;
    BROWN_DG_LIGHT = [154 74 17]/255;
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
    PURPLE_DARK = [0.25 0 0.25];
    PURPLE_LIGHT = [178 128 178]/255;
    PURPLE_UBERLIGHT = [236 224 236]/255;
    PURPLE_ULTRALIGHT = [217 192 217]/255;
    RED = [1 0 0];
    RED_DARK = [255 128 128]/255;
    RED_LIGHT = [255 178 178]/255;
    RED_UBERLIGHT = [255 236 236]/255;
    RED_ULTRALIGHT = [255 216 216]/255;
    TEAL = [0 255 192]/255;
    WHITE = [1 1 1];
    YELLOW = [1 1 0];
    YELLOW_CA2 = [1 1 0];
    YELLOW_SUB = [255 192 0]/255;
    
    nNeurons = length(neuronLabels);
    nParcels = length(parcelLabels);
    
    if strcmp(plotLabel, 'ARA\_Old')
        nParcellations = [3 5 4 4 2];
        
        layerNames = {'SM'; 'SG'; 'H'; ...
                      'SLM'; 'SR'; 'SL'; 'SP'; 'SO'; ...
                      'SLM'; 'SR'; 'SP'; 'SO'; ...
                      'SLM'; 'SR'; 'SP'; 'SO'; ...
                      'SM'; 'SR'};
    else
        nParcellations = [3 1 1 1 1];
        
        layerNames = {'SM'; 'SG'; 'H'; ...
                      ' '; ...
                      ' '; ...
                      ' '; ...
                      ' '};
    end
               
    displayFontSize = 3;
    if (nNeurons < 100)
        displayFontSize = 6;
    end
%     if (nNeurons/2 < 50)
%         displayFontSize = 10;
%     end
    
    shadingLineWidths = 1.0;
    
    morphologyColormap = [WHITE;   ... %  0
                          RED;     ... %  1
                          BLUE;    ... %  2
                          PURPLE]; ... %  3
                  
    regionColor = [BROWN_DG;
                   BROWN_CA3;
                   YELLOW_CA2;
                   ORANGE_CA1;
                   YELLOW_SUB];
               
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

    vStart = -2.5;

    hTabShift = 0;

    N = nParcels+1;
    
    %% plot matrix %%

    colormap(morphologyColormap(1:size(morphologyColormap,1),:));
    
    morphologyInvasion = zeros(nNeurons+1,nParcels+1);

    morphologyInvasion(1:nNeurons,1:nParcels) = morphologyMatrix(1:nNeurons,1:nParcels) - 48;
    
    h = pcolor(morphologyInvasion);
    set(h, 'EdgeColor', 'none');
    
    daspect([0.5 1 1])
    
    axis ij
%    axis equal
    axis off 

    axis([(vStart-30) (nParcels+30) (-6+hTabShift) hStart+1])

    hold on
    
    for i = 1:nNeurons
        for j = 1:nParcels
            %%% add horizontal white lines to neurite locations with axons
            if ((morphologyInvasion(i,j) == 1) || (morphologyInvasion(i,j) == 3))
                line([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            end
            
            %%% add vertical white lines to neurite locations with dendrites
            if ((morphologyInvasion(i,j) == 2) || (morphologyInvasion(i,j) == 3))
                line([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
            end            
        end % j
    end %i
    
    %%% color-coded tags for the subregions
    DGtab  = 1 + nParcellations(DG)/2;
    CA3tab = 1 + nParcellations(DG) + nParcellations(CA3)/2;
    CA2tab = 1 + nParcellations(DG) + nParcellations(CA3) + nParcellations(CA2)/2;
    CA1tab = 1 + nParcellations(DG) + nParcellations(CA3) + nParcellations(CA2) + nParcellations(CA1)/2;
    Subtab = 1 + nParcellations(DG) + nParcellations(CA3) + nParcellations(CA2) + nParcellations(CA1) + nParcellations(SUB)/2;
%     ECtab  = 1 + nParcellations(DG) + nParcellations(CA3) + nParcellations(CA2) + nParcellations(CA1) + nParcellations(SUB) + nParcellations(EC)/2;

    rectangle('Position',[1, vStart-0.25, nParcellations(DG), 3.80], 'EdgeColor', 'None', 'FaceColor', regionColor(DG,:));
    rectangle('Position',[1+sum(nParcellations(DG:DG)), vStart-0.25, nParcellations(CA3), 3.80], 'EdgeColor', 'None', 'FaceColor', regionColor(CA3,:));
    rectangle('Position',[1+sum(nParcellations(DG:CA3)), vStart-0.25, nParcellations(CA2), 3.80], 'EdgeColor', 'None', 'FaceColor', regionColor(CA2,:));
    rectangle('Position',[1+sum(nParcellations(DG:CA2)), vStart-0.25, nParcellations(CA1), 3.80], 'EdgeColor', 'None', 'FaceColor', regionColor(CA1,:));
    rectangle('Position',[1+sum(nParcellations(DG:CA1)), vStart-0.25, nParcellations(SUB), 3.80], 'EdgeColor', 'None', 'FaceColor', regionColor(SUB,:));
%     rectangle('Position',[1+sum(nParcellations(DG:SUB)), vStart-0.25, nParcellations(EC), 3.80], 'EdgeColor', 'None', 'FaceColor', regionColor(EC,:));
    
    vTab = -2.25;
    
    text(DGtab, vTab, 'DG', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(CA3tab, vTab, 'CA3', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(CA2tab, vTab, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
    text(CA1tab, vTab, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(Subtab, vTab, 'Sub', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
    
    for j = 1:nParcels    
        %%% column labels
        if strcmp(plotLabel, 'ARA\_Old')
            if (sum([1 2 3 4 5 6 7 8 13 14 15 16] == j))
                text(j+0.5, 1, layerNames{j}, 'rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
            else
                text(j+0.5, 1, layerNames{j}, 'rotation', 90, 'FontSize', displayFontSize, 'color', BLACK);
            end
        else
            if (sum([1 2 3 4 6] == j))
                text(j+0.5, 1, layerNames{j}, 'rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
            else
                text(j+0.5, 1, layerNames{j}, 'rotation', 90, 'FontSize', displayFontSize, 'color', BLACK);
            end
        end
    end
    
    %%% thin and thick vertical lines on parcellation axis
    for j = 1:nParcels+1
        line([j,j], [1,nNeurons+1], 'linewidth', 0.5, 'color', BLACK);
    end
    
    line_width = 1.5;

    vLine = [-2.75, nNeurons+1];
    line([1+sum(nParcellations(DG:DG)),  1+sum(nParcellations(DG:DG))],  vLine, 'linewidth', line_width, 'color', BLACK);
    line([1+sum(nParcellations(DG:CA3)), 1+sum(nParcellations(DG:CA3))], vLine, 'linewidth', line_width, 'color', BLACK);
    line([1+sum(nParcellations(DG:CA2)), 1+sum(nParcellations(DG:CA2))], vLine, 'linewidth', line_width, 'color', BLACK);
    line([1+sum(nParcellations(DG:CA1)), 1+sum(nParcellations(DG:CA1))], vLine, 'linewidth', line_width, 'color', BLACK);
%     line([1+sum(nParcellations(DG:SUB)), 1+sum(nParcellations(DG:SUB))], vLine, 'linewidth', line_width, 'color', BLACK);
    
    %%%% thin and thick horizontal lines on cell class axis
    for i = 1:nNeurons+1
        line([1,nParcels+1], [i,i], 'linewidth', 0.5, 'color', BLACK);
    end
    
%     DGline = 1 + nCells(DG);
%     CA3line = DGline + nCells(CA3);
%     CA2line = CA3line + nCells(CA2);
%     CA1line = CA2line + nCells(CA1);
%     Subline = CA1line + nCells(SUB);
% 
%     hLine = [-5, nParcels+1];
%     line(hLine, [DGline,  DGline],  'linewidth', line_width, 'color', BLACK)
%     line(hLine, [CA3line, CA3line], 'linewidth', line_width, 'color', BLACK)
%     line(hLine, [CA2line, CA2line], 'linewidth', line_width, 'color', BLACK)
%     line(hLine, [CA1line, CA1line], 'linewidth', line_width, 'color', BLACK)
%     line(hLine, [Subline, Subline], 'linewidth', line_width, 'color', BLACK)
    
    %%% Legend
%     if isPlotSupertypesOnly
%         typeStr = 'supertype';
%     elseif isPlotSuperfamiliesOnly
%         typeStr = 'superfamily';
%     else
%         typeStr = 'type';
%     end
%     N = nParcels + 2;
%     vTab = 1.0;
%     rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', 'None', 'FaceColor', RED);
%     strng = sprintf('canonical axonal location present for all members of the %s', typeStr);
%     text(N+1.5, vTab+0.5, strng, 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
%     vTab = 2.5;
%     rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', 'None', 'FaceColor', RED);
%     rectangle('Position',[N+0.25, vTab+0.375, 0.5, 0.25], 'EdgeColor', WHITE, 'FaceColor', WHITE);
%     strng = sprintf('canonical axonal location not present for all members of the %s', typeStr);
%     text(N+1.5, vTab+0.5, strng, 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
%     vTab = 4.0;
%     rectangle('Position',[N+0.25, vTab+0.375, 0.5, 0.25], 'EdgeColor', RED_LIGHT, 'FaceColor', RED_LIGHT);
%     strng = sprintf('non-canonical axonal location');
%     text(N+1.5, vTab+0.5, strng, 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
%     vTab = 5.5;
%     rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', 'None', 'FaceColor', BLUE);
%     strng = sprintf('canonical dendritic location present for all members of the %s', typeStr);
%     text(N+1.5, vTab+0.5, strng, 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
%     vTab = 7.0;
%     rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', 'None', 'FaceColor', BLUE);
%     rectangle('Position',[N+0.25, vTab+0.375, 0.5, 0.25], 'EdgeColor', WHITE, 'FaceColor', WHITE);
%     strng = sprintf('canonical dendritic location not present for all members of the %s', typeStr);
%     text(N+1.5, vTab+0.5, strng, 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
%     vTab = 8.5;
%     rectangle('Position',[N+0.25, vTab+0.375, 0.5, 0.25], 'EdgeColor', BLUE_LIGHT, 'FaceColor', BLUE_LIGHT);
%     strng = sprintf('non-canonical dendritic location');
%     text(N+1.5, vTab+0.5, strng, 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    
    vTab = vStart + 3.0;
    
    hTab = -4.5;
    
    %%% title
    strng = sprintf('%s %s', plotLabel, datestr(now, 'yyyymmdd'));
    text(hTab, -2, strng, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', displayFontSize, 'FontWeight', 'bold');
    
    %%% cell class subregion headers
%     DGstart = 1 + nCells(DG)/2;
%     strng = sprintf('DG (%d)', nCells(DG)/2);
%     vCorrection = +0.0;    
%     text(hTab,  DGstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     CA3start = 1 + nCells(DG) + nCells(CA3)/2;
%     strng = sprintf('CA3 (%d)', nCells(CA3)/2);
%     vCorrection = 0.0;
%     text(hTab,  CA3start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/2;
%     strng = sprintf('CA2 (%d)', nCells(CA2)/2);
%     vCorrection = 0.0;
%     text(hTab,  CA2start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2;    
%     strng = sprintf('CA1 (%d)', nCells(CA1)/2);
%     vCorrection = 0.0; % 0.0 % 100 cell types
%     text(hTab,  CA1start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     SUBstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB)/2;    
%     strng = sprintf('Sub (%d)', nCells(SUB)/2);
%     vCorrection = 0.0;
%     text(hTab,  SUBstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB) + nCells(EC)/2;    
%     strng = sprintf('EC (%d)', nCells(EC)/2);
%     vCorrection = 0.0;
%     text(hTab,  ECstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');

        
    vTab = 1.0;
    hTab = nParcels + hTabShift + 3;
    
    hold on;
    
    %%% plot labels
    vTab = 0.5;
    
    c = 1;
    for i = 1:nNeurons
        
        hTab = 0;
        
        label_code_cat = [neuronLabels{i}];

%         label_code_cat = sprintf('%s {%d}', label_code_cat, nSubGrouping(c));
        c = c + 1;
        
        labelColor = BLACK;
%         if strcmp(eoriMatrix{i},'I')
%             labelColor = GRAY;
%         end
        
        text(hTab, i+vTab, label_code_cat, 'color', labelColor, ...
            'HorizontalAlignment', 'right', 'Rotation', 0, 'FontSize', displayFontSize, 'Interpreter', 'none');
        
    end % for i
    

    %%%% save plots
    plotFileName = sprintf('./output/SWC2ABA_morphology_matrix');
    plotFileName = sprintf('%s_%s.eps', plotFileName, datestr(now, 'yyyymmddHHMMSS'));

    print(gcf, '-depsc2', '-r800', plotFileName);

end % plot_axon_dendrite_overlap

