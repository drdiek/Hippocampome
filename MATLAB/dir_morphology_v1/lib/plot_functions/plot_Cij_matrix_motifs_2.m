function plot_Cij_matrix_motifs_2()

    load Cij.mat Cij cellAbbrevs cellADcodes

    clf; cla;
    figure(1);
    
    % properties for figure 1
    scrsz = get(0,'ScreenSize');
    set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');
    
    
    sigToggle = 0;
    sigDs = [...
        2 2 0;...
        2 4 0;...
        4 2 0;...
        4 4 0;...
        1 2 0;...
        1 4 0;...
        3 2 0;...
        3 4 0;...
        2 2 1;...
        4 4 1;...
        2 4 1;...
        4 2 1;...
        1 2 1;...
        2 1 1;...
        1 4 1;...
        4 1 1;...
        2 3 1;...
        3 2 1;...
        3 4 1;...
        4 3 1;...
    ];
    
    N = size(Cij,1);
             
    load parcellation.mat
    load CijKnownClassLinks.mat
    load CijKnownNegClassLinks.mat
    load CijAxonSomaOverlap.mat
    load isInclude.mat

    clf; cla;
    figure(1);
    
    axis ij
    axis square
    hold on
    axis off

    
    filledSquares = 0;
        
    rowsums = sum(Cij,2);
    selfCons = diag(Cij);
    
    for i=0:N-1
        %horiz lines
        line([0, 100*N], [100*i, 100*i], 'color', [0 0 0]);
        %vert lines
        line([100*i, 100*i], [0, 100*N], 'color', [0 0 0]);
        
        for j=0:N-1
            % color self-connections
            if (Cij(i+1,j+1)~=0 && i==j)
                x0 = [j*100, (j+1)*100, (j+1)*100, j*100];
                y0 = [i*100, i*100, (i+1)*100, (i+1)*100];
                coloring0 = [0.6 0.6 0.6]; 
                fill (x0, y0, coloring0);
            end
            
            if (Cij(i+1,j+1)~=0 && i~=j)
                %draw pre-syn triangle
                %blue
                if (selfCons(i+1)==0 && rowsums(i+1)>0)
                    x1 = [j*100, j*100, (j+1)*100];
                    y1 = [i*100, (i+1)*100, (i+1)*100];
                    coloring1 = [0 0 1];
                    textCol = [0 0 0];
                    code1 = 1;
                end
                %red
                if (selfCons(i+1)==0 && rowsums(i+1)<0)
                    x1 = [j*100, j*100, (j+1)*100];
                    y1 = [i*100, (i+1)*100, (i+1)*100];
                    coloring1 = [1 0 0];
                    textCol = [0.6 0.6 0.6];
                    code1 = 2;
                end
                %green
                if (selfCons(i+1)==1 && rowsums(i+1)>0)
                    x1 = [j*100, j*100, (j+1)*100];
                    y1 = [i*100, (i+1)*100, (i+1)*100];
                    coloring1 = [0 1 0];
                    textCol = [0 0 0];
                    code1 = 3;
                end
                %yellow
                if (selfCons(i+1)==-1 && rowsums(i+1)<0)
                    x1 = [j*100, j*100, (j+1)*100];
                    y1 = [i*100, (i+1)*100, (i+1)*100];
                    coloring1 = [1 1 0];
                    textCol = [0.6 0.6 0.6];
                    code1 = 4;
                end

                
                %draw post-syn triange
                %blue
                if (selfCons(j+1)==0 && rowsums(j+1)>0)
                    x2 = [j*100, (j+1)*100, (j+1)*100];
                    y2 = [i*100, i*100, (i+1)*100];
                    coloring2 = [0 0 1];
                    code2 = 1;
                end
                %red
                if (selfCons(j+1)==0 && rowsums(j+1)<0)
                    x2 = [j*100, (j+1)*100, (j+1)*100];
                    y2 = [i*100, i*100, (i+1)*100];
                    coloring2 = [1 0 0];
                    code2 = 2;
                end
                %green
                if (selfCons(j+1)==1 && rowsums(j+1)>0)
                    x2 = [j*100, (j+1)*100, (j+1)*100];
                    y2 = [i*100, i*100, (i+1)*100];
                    coloring2 = [0 1 0];
                    code2 = 3;
                end
                %yellow
                if (selfCons(j+1)==-1 && rowsums(j+1)<0)
                    x2 = [j*100, (j+1)*100, (j+1)*100];
                    y2 = [i*100, i*100, (i+1)*100];
                    coloring2 = [1 1 0];
                    code2 = 4;
                end

                if (Cij(j+1,i+1)~=0)
                    coloring1 = coloring1 * 0.6;
                    coloring2 = coloring2 * 0.6;
                    code3 = 1;
                else
                    code3 = 0;
                end
                
                if (sigToggle == 0)
                    fill (x1, y1, coloring1);
                    fill (x2, y2, coloring2);
                    filledSquares = filledSquares+1;
                else
                    if (ismember([code1 code2 code3],sigDs,'rows') == 1)
                        fill (x1, y1, coloring1);
                        fill (x2, y2, coloring2);
                        filledSquares = filledSquares+1;
                    end
                end
                
                %draw box if bi-directional dimer
                %if (Cij(j+1,i+1)~=0)
                %    line([(j*100)+20, (j+1)*100-20], [(i*100)+20, (i*100)+20], 'linewidth', 0.5, ...
                %        'color', [0 0 0]);
                %    line([(j*100)+20, (j+1)*100-20], [(i+1)*100-20, (i+1)*100-20], 'linewidth', 0.5, ...
                %         'color', [0 0 0]);
                %    line([(j*100)+20, (j*100)+20], [(i*100)+20, (i+1)*100-20], 'linewidth', 0.5, ...
                %         'color', [0 0 0]);
                %    line([(j+1)*100-20, (j+1)*100-20], [(i*100)+20, (i+1)*100-20], 'linewidth', 0.5, ...
                %         'color', [0 0 0]);
                %end
            end
        end
        
        cellAbbrev = deblank(cellAbbrevs{i+1});
        cellADcode = deblank(cellADcodes{i+1});
        abbrev_code_cat = [cellAbbrev, ' ', cellADcode];
        
        text(-50, i*100+50, abbrev_code_cat, 'HorizontalAlignment', 'right', 'FontSize', 2, 'color', textCol, 'Interpreter', 'none')
        text(i*100+50, -50, abbrev_code_cat, 'rotation', 90, 'FontSize', 2, 'color', textCol, 'Interpreter', 'none')
    end
    
    CijFilledPercentage = filledSquares/(N*N)*100;
    
    %horiz lines
    line([0, 100*N], [100*N, 100*N], 'color', [0 0 0]);
    %vert lines
    line([100*N, 100*N], [0, 100*N], 'color', [0 0 0]);

    strng = sprintf('%s\n(%.1f%% filled)', hippocampomeVersion, CijFilledPercentage);
    text(-900, -900, strng, 'HorizontalAlignment', 'left', 'FontSize', 4);
    text(-900, -600, 'Black = excitatory', ...
         'HorizontalAlignment', 'left', 'FontSize', 3, ...
         'Color', 'k'); % black
    text(-900, -500, 'Gray = inhibitory', ...
        'HorizontalAlignment', 'left', 'FontSize', 3, ...
        'Color', [0.7 0.7 0.7]); % gray
    
    DGstart = nCells(DG)/2;
    CA3start = nCells(DG) + nCells(CA3)/2;
    CA2start = nCells(DG) + nCells(CA3) + nCells(CA2)/2;
    CA1start = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2;
    SUBstart = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB)/2;
    ECstart = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB) + nCells(EC)/2;
    %legendStart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB) + nCells(EC) + 1;
    
    text(-900, 100*DGstart, 'DG', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 3);
    text(-900, 100*CA3start, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 3);
    text(-900, 100*CA2start, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 3);
    text(-900, 100*CA1start, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 3);
    text(-900, 100*SUBstart, 'SUB', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 3);
    text(-900, 100*ECstart, 'EC', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 3);

    text(100*DGstart, -900, 'DG', 'HorizontalAlignment', 'center', 'FontSize', 3);
    text(100*CA3start, -900, 'CA3', 'HorizontalAlignment', 'center', 'FontSize', 3);
    text(100*CA2start, -900, 'CA2', 'HorizontalAlignment', 'center', 'FontSize', 3);
    text(100*CA1start, -900, 'CA1', 'HorizontalAlignment', 'center', 'FontSize', 3);
    text(100*SUBstart, -900, 'SUB', 'HorizontalAlignment', 'center', 'FontSize', 3);
    text(100*ECstart, -900, 'EC', 'HorizontalAlignment', 'center', 'FontSize', 3);
   
    DGline = 100*length(DGcells);
    CA3line = DGline + 100*length(CA3cells);
    CA2line = CA3line + 100*length(CA2cells);
    CA1line = CA2line + 100*length(CA1cells);
    SUBline = CA1line + 100*length(SUBcells);
    %ECline = SUBline + 100*length(ECcells);
    
    line([-650, 100*N], [DGline, DGline], 'linewidth', 2, 'color', 'k');
    line([DGline, DGline], [-650, 100*N], 'linewidth', 2, 'color', 'k');
    line([-650, 100*N], [CA3line, CA3line], 'linewidth', 2, 'color', 'k');
    line([CA3line, CA3line], [-650, 100*N], 'linewidth', 2, 'color', 'k');
    line([-650, 100*N], [CA2line, CA2line], 'linewidth', 2, 'color', 'k');
    line([CA2line, CA2line], [-650, 100*N], 'linewidth', 2, 'color', 'k');
    line([-650, 100*N], [CA1line, CA1line], 'linewidth', 2, 'color', 'k');
    line([CA1line, CA1line], [-650, 100*N], 'linewidth', 2, 'color', 'k');
    line([-650, 100*N], [SUBline, SUBline], 'linewidth', 2, 'color', 'k');
    line([SUBline, SUBline], [-650, 100*N], 'linewidth', 2, 'color', 'k');
    %line([-650, 100*N], [ECline, ECline], 'linewidth', 2);
    %line([ECline, ECline], [-650, 100*N], 'linewidth', 2);
      	
end