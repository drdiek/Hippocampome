function plot_fuzzy_markers_matrix(markersMatrix,rawData)

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
    
    nAllCells = size(markersMatrix,1); % account for header row
    nMarkers = size(markersMatrix,2);
    
    displayFontSize = 5;
    
    shadingLineWidths = 0.5;
    
    markersColormap = [  BLUE;         ... % -1: 
                         ORANGE;       ... %  0: 
                         GREEN_BRIGHT];... %  1: 
                  
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

    N = nMarkers+1;
    
    %% plot matrix %%

    colormap(markersColormap(1:3,:));
    
    markersExpression = zeros(nAllCells+1,nMarkers+1);

    markersExpression(1:nAllCells,1:nMarkers) = markersMatrix(1:nAllCells,:);
    
    pcolor(markersExpression)
    
    axis ij
    axis equal
    axis off 

    axis([(vStart-30) (N+1) (-6+hTabShift) hStart+1])

    hold on
    
    vTab = vStart + 3.0;
    
    % add pattern labels across horizontal axis
%     for j = 1:nMarkers
%         text(j+0.5, vTab, patternLabels{j}, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize, 'color', BLACK);
%     end
%     
%     [TF, idx] = cellfind('DG', subregions);
%     nDGcells = length(idx);
%     [TF, idx] = cellfind('CA3', subregions);
%     nCA3cells = length(idx);
%     [TF, idx] = cellfind('CA2', subregions);
%     nCA2cells = length(idx);
%     [TF, idx] = cellfind('CA1', subregions);
%     nCA1cells = length(idx);
%     [TF, idx] = cellfind('SUB', subregions);
%     nSUBcells = length(idx);
%     [TF, idx] = cellfind('EC', subregions);
%     nECcells = length(idx);
    
%     %%%% thick horizontal lines on cell class axis
%     line_width = 1;
%     
%     DGline = 1+ nDGcells;
%     CA3line = DGline + nCA3cells;
%     CA2line = CA3line + nCA2cells;
%     CA1line = CA2line + nCA1cells;
%     SUBline = CA1line + nSUBcells;
%     
% %     line([0,0], [1, nMarkers], 'linewidth', line_width, 'color', [0 0 0])
%     line([-10, nMarkers+vStart+3.5], [DGline,  DGline],  'linewidth', line_width, 'color', BLACK)
%     line([-10, nMarkers+vStart+3.5], [CA3line, CA3line], 'linewidth', line_width, 'color', BLACK)
%     line([-10, nMarkers+vStart+3.5], [CA2line, CA2line], 'linewidth', line_width, 'color', BLACK)
%     line([-10, nMarkers+vStart+3.5], [CA1line, CA1line], 'linewidth', line_width, 'color', BLACK)
%     line([-10, nMarkers+vStart+3.5], [SUBline, SUBline], 'linewidth', line_width, 'color', BLACK)
%     
%     hTab = hStart+3.5; % *****
%     hCorrection = 7.5;%1.5;
%     hCorrectionShift = 1; %-1.25; % 100 cell types %-2.75;%-1.75;%-0.75;%-2.0;%-6.5;
%     
%     %%% cell class subregion headers
%     DGstart = 1 + nDGcells/2;
%     
%     strng = sprintf('DG');
%     vCorrection = +0.0;
%     hCorrection = hCorrectionShift;
%     
%     text(-11,  DGstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     CA3start = 1 + nDGcells + nCA3cells/2;
%     
%     strng = sprintf('CA3');
%     vCorrection = 0.0;
%     hCorrection = hCorrectionShift;
%     
%     text(-11,  CA3start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     CA2start = 1 + nDGcells + nCA3cells + nCA2cells/2;
%     
%     strng = sprintf('CA2');
%     vCorrection = 0.0;
%     hCorrection = hCorrectionShift;
%     
%     text(-11,  CA2start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     CA1start = 1 + nDGcells + nCA3cells + nCA2cells + nCA1cells/2;
%     
%     vCorrection = 0;
%     
%     strng = sprintf('CA1');
%     vCorrection = -1.0; % 0.0 % 100 cell types
%     hCorrection = hCorrectionShift;
%     
%     text(-11,  CA1start+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     SUBstart = 1 + nDGcells + nCA3cells + nCA2cells + nCA1cells + nSUBcells/2;
%     
%     strng = sprintf('SUB');
%     vCorrection = 0.0;
%     hCorrection = hCorrectionShift;
%     
%     text(-11,  SUBstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
%     
%     ECstart = 1 + nDGcells + nCA3cells + nCA2cells + nCA1cells + nSUBcells + nECcells/2;
%     
%     strng = sprintf('EC');
%     vCorrection = -1.0;
%     hCorrection = hCorrectionShift;
%     
%     text(-11,  ECstart+vCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold');
% 
%         
%     vTab = 1.0;
%     hTab = nMarkers + hTabShift + 3;
%     
%     hold on;
    
    % plot labels
%     for i = 1:nAllCells
%         
%         hTab = 0; %nMarkers+3;
%         
%         cellLabel = deblank(cellLabels{i});
%         
%         label_code_cat = [cellLabel];
%         
%         FontNameStr = 'Helvetica';
%         
%         if strcmp(cellEorIs{i},'E')
%             labelColor = BLACK;
%         else
%             labelColor = GRAY;
%         end
%         
%         text(hTab, i+0.5, label_code_cat, 'color', labelColor, ...
%             'HorizontalAlignment', 'right', 'Rotation', 0, 'FontSize', displayFontSize, 'Interpreter', 'none');
%         
%     end % for i
    

    %%%% save plots

    plotFileName = sprintf('./output/markers_matrix');

    plotFileName = sprintf('%s_%s.eps', plotFileName, datestr(now, 'yyyymmddHHMMSS'));

    print(gcf, '-depsc2', '-r800', plotFileName);

end % plot_axon_dendrite_overlap

