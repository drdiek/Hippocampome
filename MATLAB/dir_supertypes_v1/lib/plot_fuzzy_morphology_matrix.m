function plot_fuzzy_morphology_matrix(morphologyMatrix,rawData,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)

    load('./lib/constants.mat');

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
    
    [morphologyMatrixUnique,idx,jdx] = unique(morphologyMatrix,'rows','first');
    morphologyMatrix = morphologyMatrix(sort(idx),:);
    subregions = rawData(sort(idx),SUBREGION_COL);
    
    nAllCells = size(morphologyMatrix,1);
    nParcels = size(morphologyMatrix,2);
    
    nParcellations = [4 5 4 4 3 6];
    
    layerNames = {'SMo'; 'SMi'; 'SG'; 'H'; ...
                  'SLM'; 'SR'; 'SL'; 'SP'; 'SO'; ...
                  'SLM'; 'SR'; 'SP'; 'SO'; ...
                  'SLM'; 'SR'; 'SP'; 'SO'; ...
                  'SM'; 'SP'; 'PL'; ...
                  'I'; 'II'; 'III'; 'IV'; 'V'; 'VI'};
               
    [TF, indices] = cellfind('DG',subregions);
    nCells(DG) = length(indices);
    [TF, indices] = cellfind('CA3',subregions);
    nCells(CA3) = length(indices);
    [TF, indices] = cellfind('CA2',subregions);
    nCells(CA2) = length(indices);
    [TF, indices] = cellfind('CA1',subregions);
    nCells(CA1) = length(indices);
    [TF, indices] = cellfind('Sub',subregions);
    nCells(Sub) = length(indices);
    [TF, indices] = cellfind('EC',subregions);
    nCells(EC) = length(indices);
        
    displayFontSize = 3;
    if (nAllCells < 100)
        displayFontSize = 8;
    end
    if (nAllCells < 50)
        displayFontSize = 10;
    end
    
    shadingLineWidths = 1.0;
    
    morphologyColormap = [ WHITE;                         ... %  0: A = -1 AND D = -1
                           BLUE_ULTRALIGHT;               ... %  1: A = -1 AND D = 0
                           BLUE_LIGHT;                    ... %  2: A = -1 AND D = 1
                           BLUE;                          ... %  3: A = -1 AND D = 2
                           RED_ULTRALIGHT;                ... %  4: A = 0 AND D = -1
                           PURPLE_ULTRALIGHT;             ... %  5: A = 0 AND D = 0
                           (RED_ULTRALIGHT+BLUE_LIGHT)/2; ... %  6: A = 0 AND D = 1
                           (RED_ULTRALIGHT+BLUE)/2;       ... %  7: A = 0 AND D = 2
                           RED_LIGHT;                     ... %  8: A = 1 AND D = -1
                           (RED_LIGHT+BLUE_ULTRALIGHT)/2; ... %  9: A = 1 AND D = 0
                           PURPLE_LIGHT;                  ... % 10: A = 1 AND D = 1
                           (RED_LIGHT+BLUE)/2;            ... % 11: A = 1 AND D = 2
                           RED;                           ... % 12: A = 2 AND D = -1
                           (RED+BLUE_ULTRALIGHT)/2;       ... % 13: A = 2 AND D = 0
                           (RED+BLUE_LIGHT)/2;            ... % 14: A = 2 AND D = 1
                           PURPLE];                       ... % 15: A = 2 AND D = 2
                  
%     morphologyColormap = [ WHITE;                         ... %  0: A = -1 AND D = -1
%                            BLUE_UBERLIGHT;               ... %  1: A = -1 AND D = 0
%                            BLUE_ULTRALIGHT;                    ... %  2: A = -1 AND D = 1
%                            BLUE;                          ... %  3: A = -1 AND D = 2
%                            RED_UBERLIGHT;                ... %  4: A = 0 AND D = -1
%                            PURPLE_UBERLIGHT;             ... %  5: A = 0 AND D = 0
%                            (RED_UBERLIGHT+BLUE_ULTRALIGHT)/2; ... %  6: A = 0 AND D = 1
%                            (RED_UBERLIGHT+BLUE_LIGHT)/2;       ... %  7: A = 0 AND D = 2
%                            RED_ULTRALIGHT;                     ... %  8: A = 1 AND D = -1
%                            (RED_ULTRALIGHT+BLUE_UBERLIGHT)/2; ... %  9: A = 1 AND D = 0
%                            PURPLE_ULTRALIGHT;                  ... % 10: A = 1 AND D = 1
%                            (RED_ULTRALIGHT+BLUE_LIGHT)/2;            ... % 11: A = 1 AND D = 2
%                            RED;                           ... % 12: A = 2 AND D = -1
%                            (RED_LIGHT+BLUE_UBERLIGHT)/2;       ... % 13: A = 2 AND D = 0
%                            (RED_LIGHT+BLUE_ULTRALIGHT)/2;            ... % 14: A = 2 AND D = 1
%                            PURPLE];                       ... % 15: A = 2 AND D = 2
                  
    regionColor = [BROWN_DG;
                   BROWN_CA3;
                   YELLOW_CA2;
                   ORANGE_CA1;
                   YELLOW_SUB;
                   GREEN_EC];
               
    newplot
    clf('reset'); cla('reset');
    figure(1);
    
    set(gcf, 'color', 'w');

    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperSize', [13 11]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 13 11]);
 
    set(gca, 'Position', get(gca, 'OuterPosition') - get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]/3);

    hStart = nAllCells+11;

    vStart = -2.5;

    hTabShift = 0;

    N = nParcels+1;
    
    %% plot matrix %%

    colormap(morphologyColormap(1:size(morphologyColormap,1),:));
    
    morphologyInvasion = zeros(nAllCells+1,nParcels+1);

    morphologyInvasion(1:nAllCells,1:nParcels) = morphologyMatrix(1:nAllCells,1:nParcels);
    
    pcolor(morphologyInvasion)
    
    axis ij
    axis equal
    axis off 

    axis([(vStart-30) (nParcels+20) (-6+hTabShift) hStart+1])

    hold on
    
    for i = 1:nAllCells
        for j = 1:nParcels            
            if (morphologyInvasion(i,j) == 15) % A = 2 & D = 2
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 14) % A = 2 & D = 1
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', GREEN_BRIGHT, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', GREEN_BRIGHT, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 13) % A = 2 & D = 0
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', YELLOW, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', YELLOW, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 12) % A = 2 & D = -1
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 11) % A = 1 & D = 2
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', GREEN_BRIGHT, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', GREEN_BRIGHT, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 10) % A = 1 & D = 1
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 9) % A = 1 & D = 0
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 8) % A = 1 & D = -1
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 7) % A = 0 & D = 2
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', YELLOW, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', YELLOW, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 6) % A = 0 & D = 1
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 5) % A = 0 & D = 0
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 4) % A = 0 & D = -1
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 3) % A = -1 & D = 2
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 2) % A = -1 & D = 1
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            elseif (morphologyInvasion(i,j) == 1) % A = -1 & D = 0
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
            end
        end % j
    end % i
    
    %%% color-coded tags for the subregions
    DGtab  = 1 + nParcellations(DG)/2;
    CA3tab = 1 + nParcellations(DG) + nParcellations(CA3)/2;
    CA2tab = 1 + nParcellations(DG) + nParcellations(CA3) + nParcellations(CA2)/2;
    CA1tab = 1 + nParcellations(DG) + nParcellations(CA3) + nParcellations(CA2) + nParcellations(CA1)/2;
    Subtab = 1 + nParcellations(DG) + nParcellations(CA3) + nParcellations(CA2) + nParcellations(CA1) + nParcellations(Sub)/2;
    ECtab  = 1 + nParcellations(DG) + nParcellations(CA3) + nParcellations(CA2) + nParcellations(CA1) + nParcellations(Sub) + nParcellations(EC)/2;

    rectangle('Position',[1, vStart+0.5, nParcellations(DG), 2.98], 'EdgeColor', 'None', 'FaceColor', regionColor(DG,:));
    rectangle('Position',[1+sum(nParcellations(DG:DG)), vStart+0.5, nParcellations(CA3), 2.98], 'EdgeColor', 'None', 'FaceColor', regionColor(CA3,:));
    rectangle('Position',[1+sum(nParcellations(DG:CA3)), vStart+0.5, nParcellations(CA2), 2.98], 'EdgeColor', 'None', 'FaceColor', regionColor(CA2,:));
    rectangle('Position',[1+sum(nParcellations(DG:CA2)), vStart+0.5, nParcellations(CA1), 2.98], 'EdgeColor', 'None', 'FaceColor', regionColor(CA1,:));
    rectangle('Position',[1+sum(nParcellations(DG:CA1)), vStart+0.5, nParcellations(Sub), 2.98], 'EdgeColor', 'None', 'FaceColor', regionColor(Sub,:));
    rectangle('Position',[1+sum(nParcellations(DG:Sub)), vStart+0.5, nParcellations(EC), 2.98], 'EdgeColor', 'None', 'FaceColor', regionColor(EC,:));
    
    vTab = -1.5;
    
    text(DGtab, vTab, 'DG', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(CA3tab, vTab, 'CA3', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(CA2tab, vTab, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
    text(CA1tab, vTab, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(Subtab, vTab, 'Sub', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
    text(ECtab, vTab, 'EC', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);    
    
    for j = 1:nParcels    
        %%% column labels
        if (sum([1 2 3 4 5 6 7 8 9 14 15 16 17 21 22 23 24 25 26] == j))
            text(j+0.5, 1, layerNames{j}, 'rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
        else
            text(j+0.5, 1, layerNames{j}, 'rotation', 90, 'FontSize', displayFontSize, 'color', BLACK);
        end
    end
    
    %%% thick vertical lines on parcellation axis
    line_width = 1.5;

    vLine = [-2, nAllCells+1];
    line([1+sum(nParcellations(DG:DG)),  1+sum(nParcellations(DG:DG))],  vLine, 'linewidth', line_width, 'color', BLACK);
    line([1+sum(nParcellations(DG:CA3)), 1+sum(nParcellations(DG:CA3))], vLine, 'linewidth', line_width, 'color', BLACK);
    line([1+sum(nParcellations(DG:CA2)), 1+sum(nParcellations(DG:CA2))], vLine, 'linewidth', line_width, 'color', BLACK);
    line([1+sum(nParcellations(DG:CA1)), 1+sum(nParcellations(DG:CA1))], vLine, 'linewidth', line_width, 'color', BLACK);
    line([1+sum(nParcellations(DG:Sub)), 1+sum(nParcellations(DG:Sub))], vLine, 'linewidth', line_width, 'color', BLACK);
    
    %%%% thick horizontal lines on cell class axis
    DGline = 1 + nCells(DG);
    CA3line = DGline + nCells(CA3);
    CA2line = CA3line + nCells(CA2);
    CA1line = CA2line + nCells(CA1);
    Subline = CA1line + nCells(Sub);

    hLine = [-5, nParcels+1];
    line(hLine, [DGline,  DGline],  'linewidth', line_width, 'color', BLACK)
    line(hLine, [CA3line, CA3line], 'linewidth', line_width, 'color', BLACK)
    line(hLine, [CA2line, CA2line], 'linewidth', line_width, 'color', BLACK)
    line(hLine, [CA1line, CA1line], 'linewidth', line_width, 'color', BLACK)
    line(hLine, [Subline, Subline], 'linewidth', line_width, 'color', BLACK)
    
    %%% Legend
    N = nParcels + 2;
    vTab = 1.0;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', PURPLE);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=2 & D=2 (canonical)', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 2.5;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', (RED+BLUE_LIGHT)/2);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', GREEN_BRIGHT, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', GREEN_BRIGHT, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=2 & D=1', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 4.0;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', (RED+BLUE_ULTRALIGHT)/2);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', YELLOW, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', YELLOW, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=2 & D=0', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 5.5;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', RED);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=2 & D=-1 (canonical)', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 7.0;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', (RED_LIGHT+BLUE)/2);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', GREEN_BRIGHT, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', GREEN_BRIGHT, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=1 & D=2', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 8.5;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', PURPLE_LIGHT);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=1 & D=1', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 10.0;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', (RED_LIGHT+BLUE_ULTRALIGHT)/2);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=1 & D=0', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 11.5;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', RED_LIGHT);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=1 & D=-1', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 13.0;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', (RED_ULTRALIGHT+BLUE)/2);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', YELLOW, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', YELLOW, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=0 & D=2', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 14.5;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', (RED_ULTRALIGHT+BLUE_LIGHT)/2);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=0 & D=1', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 16.0;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', PURPLE_ULTRALIGHT);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=0 & D=0', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 17.5;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', RED_ULTRALIGHT);
    line([N+0.5, N+0.5], [vTab+0.1, vTab+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=0 & D=-1', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 19.0;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', BLUE);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=-1 & D=2 (canonical)', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 20.5;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', BLUE_LIGHT);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=-1 & D=1', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 22.0;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', BLUE_ULTRALIGHT);
    line([N+0.1, N+0.9], [vTab+0.5, vTab+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
    text(N+1.5, vTab+0.5, 'A=-1 & D=0', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    vTab = 23.5;
    rectangle('Position',[N, vTab, 1.0, 1.0], 'EdgeColor', BLACK, 'FaceColor', WHITE);
    text(N+1.5, vTab+0.5, 'A=-1 & D=-1', 'HorizontalAlignment', 'left', 'FontSize', displayFontSize, 'color', BLACK);
    
    vTab = vStart + 3.0;
    
%     if isPlotSupertypesOnly
        hTab = -15;
%     else
%         hTab = -9;
%     end
    
    %%% title
    if isPlotSupertypesOnly
        strng = sprintf('Supertypes %s', datestr(now, 'yyyymmdd'));
    else
        strng = sprintf('Superfamilies %s', datestr(now, 'yyyymmdd'));
    end
    text(hTab, -2, strng, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', displayFontSize, 'FontWeight', 'bold');
    
    %%% cell class subregion headers
    DGstart = 1 + nCells(DG)/2;
    strng = sprintf('DG');
    vCorrection = +0.0;    
    text(hTab,  DGstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    
    CA3start = 1 + nCells(DG) + nCells(CA3)/2;
    strng = sprintf('CA3');
    vCorrection = 0.0;
    text(hTab,  CA3start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    
    CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/2;
    strng = sprintf('CA2');
    vCorrection = 0.0;
    text(hTab,  CA2start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    
    CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2;    
    strng = sprintf('CA1');
    vCorrection = 0.0; % 0.0 % 100 cell types
    text(hTab,  CA1start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    
    SUBstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(Sub)/2;    
    strng = sprintf('Sub');
    vCorrection = 0.0;
    text(hTab,  SUBstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    
    ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(Sub) + nCells(EC)/2;    
    strng = sprintf('EC');
    vCorrection = 0.0;
    text(hTab,  ECstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');

        
    vTab = 1.0;
    hTab = nParcels + hTabShift + 3;
    
    hold on;
    
    %%% plot labels
%     if isPlotSupertypesOnly
        cellLabels = deblank(rawData(sort(idx),SUPERTYPE_DESCRIPTOR_COL));
        labelColors = rawData(sort(idx),EI_COL);
%     else
%         cellLabels = deblank(rawData(:,NEURONAL_TYPE_COL));
%         labelColors = rawData(:,EI_COL);
%     end
    for i = 1:nAllCells
        
        hTab = 0;
        
        label_code_cat = [cellLabels{i}];
        if isPlotSuperfamiliesOnly
            jdx = strfind(label_code_cat,':');
            label_code_cat = label_code_cat(1:jdx(2)-1);
        end
        
        FontNameStr = 'Helvetica';
        
        labelColor = BLACK;
        if strcmp(labelColors{i},'I')
            labelColor = GRAY;
        end
        
        text(hTab, i+0.5, label_code_cat, 'color', labelColor, ...
            'HorizontalAlignment', 'right', 'Rotation', 0, 'FontSize', displayFontSize, 'Interpreter', 'none');
        
    end % for i
    

    %%%% save plots

    if isPlotSupertypesOnly
        plotFileName = sprintf('./output/morphology_matrix_supertypes');
    else
        plotFileName = sprintf('./output/morphology_matrix_superfamilies');
    end
    plotFileName = sprintf('%s_%s.eps', plotFileName, datestr(now, 'yyyymmddHHMMSS'));

    print(gcf, '-depsc2', '-r800', plotFileName);

end % plot_axon_dendrite_overlap

