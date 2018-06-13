function plot_overlap_binary(nParcels,nCells,nLayers,overlapBinary,quantity,subregion)

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
               
    nNeuronsDisplayed = subregion.end-(subregion.start-1);
    
    if strcmp(subregion.label,'All')
        displayFontSize = 5;
    else
        displayFontSize = 10;
    end
    
    shadingLineWidths = 0.5;
    
    overlapColormap = [ WHITE;          ... % 0: 
                        RED_LIGHT;      ... % 1: 
                        BLUE_LIGHT;     ... % 2: 
                        PURPLE_LIGHT ]; ... % 3: 
                  
    newplot
    clf('reset'); cla('reset');
    figure(1);
    
    set(gcf, 'color', 'w');

    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperSize', [13 11]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 13 11]);
 
    set(gca, 'Position', get(gca, 'OuterPosition') - get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]/3);

    vStart = -2.05;
%     hStart = nNeurons+11;
    hStart = subregion.end-(subregion.start-1)+11;
    hLineEnd = 7.0+4.25;

    vStartSummary = vStart - 4.5;

    hTabShift = 0;

    N = nParcels+1;
    
    %% plot matrix %%

    colormap(overlapColormap(1:4,:));
    
%     CijOverlap = zeros(nNeurons+1, nParcels+1);
    CijOverlap = zeros(subregion.end-(subregion.start-1)+1, nParcels+1);

    CijOverlap(1:nNeuronsDisplayed, 1:nParcels) = overlapBinary.data(subregion.start:subregion.end,1:nParcels);
    
    pcolor(CijOverlap)
    
    axis ij
    axis equal
    axis off 

    axis([(vStart-30) (N+1) (-6+hTabShift) hStart+1])

    hold on

    % Add hatch lines to the colored squares
    shadingLineWidths = 1.0;
    for i = 1:nNeuronsDisplayed
        for j = 1:nParcels
            if ((CijOverlap(i,j) == 1) || (CijOverlap(i,j) == 3)) % axons
                line ([j+0.5, j+0.5], [i+0.1, i+0.9], 'color', WHITE, 'linewidth', shadingLineWidths)
                hold on
            end
            if ((CijOverlap(i,j) == 2) || (CijOverlap(i,j) == 3)) % dendrites
                line ([j+0.1, j+0.9], [i+0.5, i+0.5], 'color', WHITE, 'linewidth', shadingLineWidths)
                hold on
            end
        end % j
    end % i
    
    % parcellation subregion headers
    DGtab = 1 + nLayers.DG/2;
    CA3tab = 1 + nLayers.DG + nLayers.CA3/2;
    CA2tab = 1 + nLayers.DG + nLayers.CA3 + nLayers.CA2/2;
    CA1tab = 1 + nLayers.DG + nLayers.CA3 + nLayers.CA2 + nLayers.CA1/2;
    Subtab = 1 + nLayers.DG + nLayers.CA3 + nLayers.CA2 + nLayers.CA1 + nLayers.Sub/2;
    ECtab = 1 + nLayers.DG + nLayers.CA3 + nLayers.CA2 + nLayers.CA1 + nLayers.Sub + nLayers.EC/2;

    hTab = 1;
    vTab = vStart + 1.0;
    
    %%% color-coded tags for the subregions
    rectangle('Position',[1, vStart+0.5, nLayers.DG, 2.5], 'EdgeColor', 'None', 'FaceColor', regionColor(DG,:));
    rectangle('Position',[1+nLayers.DG, vStart+0.5, nLayers.CA3, 2.5], 'EdgeColor', 'None', 'FaceColor', regionColor(CA3,:));
    rectangle('Position',[1+nLayers.DG+nLayers.CA3, vStart+0.5, nLayers.CA2, 2.5], 'EdgeColor', 'None', 'FaceColor', regionColor(CA2,:));
    rectangle('Position',[1+nLayers.DG+nLayers.CA3+nLayers.CA2, vStart+0.5, nLayers.CA1, 2.5], 'EdgeColor', 'None', 'FaceColor', regionColor(CA1,:));
    rectangle('Position',[1+nLayers.DG+nLayers.CA3+nLayers.CA2+nLayers.CA1, vStart+0.5, nLayers.Sub, 2.5], 'EdgeColor', 'None', 'FaceColor', regionColor(Sub,:));
    rectangle('Position',[1+nLayers.DG+nLayers.CA3+nLayers.CA2+nLayers.CA1+nLayers.Sub, vStart+0.5, nLayers.EC, 2.5], 'EdgeColor', 'None', 'FaceColor', regionColor(EC,:));
    
    text(DGtab, vTab, 'DG', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(CA3tab, vTab, 'CA3', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(CA2tab, vTab, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
    text(CA1tab, vTab, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);
    text(Subtab, vTab, 'Sub', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', BLACK);
    text(ECtab, vTab, 'EC', 'HorizontalAlignment', 'center', 'Rotation', 0, 'FontSize', displayFontSize, 'color', WHITE);    
    
    vTab = vStart + 3.0;
    
    for j = 1:nLayers.DG
        text(j+0.5, vTab, overlapBinary.layers{1,j}, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
    end
    for j = 1+nLayers.DG:nLayers.DG+nLayers.CA3
        text(j+0.5, vTab, overlapBinary.layers{1,j}, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
    end
    for j = 1+nLayers.DG+nLayers.CA3:nLayers.DG+nLayers.CA3+nLayers.CA2
        text(j+0.5, vTab, overlapBinary.layers{1,j}, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize, 'color', BLACK);
    end
    for j = 1+nLayers.DG+nLayers.CA3+nLayers.CA2:nLayers.DG+nLayers.CA3+nLayers.CA2+nLayers.CA1
        text(j+0.5, vTab, overlapBinary.layers{1,j}, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
    end
    for j = 1+nLayers.DG+nLayers.CA3+nLayers.CA2+nLayers.CA1:nLayers.DG+nLayers.CA3+nLayers.CA2+nLayers.CA1+nLayers.Sub
        text(j+0.5, vTab, overlapBinary.layers{1,j}, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize, 'color', BLACK);
    end
    for j = 1+nLayers.DG+nLayers.CA3+nLayers.CA2+nLayers.CA1+nLayers.Sub:nParcels
        text(j+0.5, vTab, overlapBinary.layers{1,j}, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
    end
    
    hTab = hStart+3.5; % *****
    hCorrection = 7.5;%1.5;
    hCorrectionShift = 1; %-1.25; % 100 cell types %-2.75;%-1.75;%-0.75;%-2.0;%-6.5;
    
    hold on;
    
    % plot labels
    for i = subregion.start:subregion.end
        
        hTab = 0.9; %nParcels+3;
        
        typeLabel = deblank(overlapBinary.names{i});
        
        label_code_cat = [typeLabel, ' (', num2str(quantity.factor(i)), ')'];
        
        FontNameStr = 'Helvetica';
        
        labelColor = BLACK;
        if (overlapBinary.EorI{i} == 'I')
            labelColor = GRAY_MEDIUM;
        end
        text(hTab, i-(subregion.start-1)+0.5, label_code_cat, 'color', labelColor, ...
            'HorizontalAlignment', 'right', 'Rotation', 0, 'FontSize', displayFontSize, 'Interpreter', 'none');
        
    end % for i
    
    % add title label to plot
    if strcmp(subregion.label,'All')
        hTab = -12;
        displayFontSize = 5;
    else
        hTab = -8;
        displayFontSize = 10;
    end
    text(hTab, -1.5, quantity.string, 'HorizontalAlignment', 'left', 'Rotation', 0, 'FontSize', displayFontSize);
    
    %%% cell class subregion headers    
    strng = sprintf('DG');
    vCorrection = +0.0;
    
    if (strcmp(subregion.label,'DG') || strcmp(subregion.label,'All'))
        DGstart = 1 + nCells.DG/2;
        text(hTab,  DGstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
        
    strng = sprintf('CA3');
    vCorrection = 0.0;
    
    if strcmp(subregion.label,'CA3')
        CA3start = 1 + nCells.CA3/2;
        text(hTab,  CA3start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    elseif strcmp(subregion.label,'All')
        CA3start = 1 + nCells.DG + nCells.CA3/2;
        text(hTab,  CA3start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
        
    strng = sprintf('CA2');
    vCorrection = 0.0;
    
    if strcmp(subregion.label,'CA2')
        CA2start = 1 + nCells.CA2/2;
        text(hTab,  CA2start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    elseif strcmp(subregion.label,'All')
        CA2start = 1 + nCells.DG + nCells.CA3 + nCells.CA2/2;
        text(hTab,  CA2start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
        
    strng = sprintf('CA1');
    vCorrection = -0.0; % 0.0 % 100 cell types
    
    if strcmp(subregion.label,'CA1')
        CA1start = 1 + nCells.CA1/2;
        text(hTab,  CA1start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    elseif strcmp(subregion.label,'All')
        CA1start = 1 + nCells.DG + nCells.CA3 + nCells.CA2 + nCells.CA1/2;
        text(hTab,  CA1start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
        
    strng = sprintf('Sub');
    vCorrection = 0.0;
    
    if strcmp(subregion.label,'Sub')
        SUBstart = 1 + nCells.Sub/2;
        text(hTab,  SUBstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    elseif strcmp(subregion.label,'All')
        SUBstart = 1 + nCells.DG + nCells.CA3 + nCells.CA2 + nCells.CA1 + nCells.Sub/2;
        text(hTab,  SUBstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
        
    strng = sprintf('EC');
    vCorrection = 0.0;
    
    if strcmp(subregion.label,'EC')
        ECstart = 1 + nCells.EC/2;
        text(hTab,  ECstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    elseif strcmp(subregion.label,'All')
        ECstart = 1 + nCells.DG + nCells.CA3 + nCells.CA2 + nCells.CA1 + nCells.Sub + nCells.EC/2;
        text(hTab,  ECstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
    
    %%%% thick horizontal lines on cell class axis
    if strcmp(subregion.label,'All')
        line_width = 1;
        
        DGline = 1 + nCells.DG;
        CA3line = DGline + nCells.CA3;
        CA2line = CA3line + nCells.CA2;
        CA1line = CA2line + nCells.CA1;
        SUBline = CA1line + nCells.Sub;
        
        line([-10, nParcels+1], [DGline,  DGline],  'linewidth', line_width, 'color', BLACK);
        line([-10, nParcels+1], [CA3line, CA3line], 'linewidth', line_width, 'color', BLACK);
        line([-10, nParcels+1], [CA2line, CA2line], 'linewidth', line_width, 'color', BLACK);
        line([-10, nParcels+1], [CA1line, CA1line], 'linewidth', line_width, 'color', BLACK);
        line([-10, nParcels+1], [SUBline, SUBline], 'linewidth', line_width, 'color', BLACK);
    end
    
    hold on;
    
end % plot_axon_dendrite_overlap

