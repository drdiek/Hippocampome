function plot_periodic_table()

    addpath('lib');
    
    axonsFile = select_file('axons');
    if strcmp(axonsFile, '!')
        return;
    end
    idx = strfind(axonsFile, 'axons');
    dendritesFile = sprintf('%sdendrites%s', axonsFile(1:idx-1), axonsFile(idx+5:end));
    
    [nNeurons, nParcels, labels, isExcitatory, axons] = process_neurites(axonsFile);

    [nNeurons, nParcels, labels, isExcitatory, dendrites] = process_neurites(dendritesFile);
    
    colors = [1 0 0; 0 0 1; 0.5 0 0.5; 0.75 0.25 0.75]; % red, blue, dark purple, light purple
%     colors = [1 0 0; 0 0 1; 0.5 0 0.5; 1 0.5 1]; % red, blue, dark purple, light purple
    
    overlapColors = [0.75 0.75 0.75; 0 0 0]; % gray, black

    figure(1);
    
    clf;
    
    plot3(0,0,0,'k'); % plot simple point to establish 3D plot
        
%     view(180-37.5,30);
    view(180-45,30);
    
%     axis equal;

    axis([0 nNeurons 0 nNeurons 0 nParcels]);
    
    pbaspect([3.75,3.75,1.5]) % uniform is [3.75,3.75,1]
    
    hold on;
    
    colormap([colors(3,:); colors(4,:)]); % dark purple, light purple
    
    for iNeuron = 1:nNeurons % loop through presynaptic neurons
    
        for jNeuron = 1:nNeurons % loop through postsynaptic neurons
        
            isOverlap = 0;
            
            for iParcel = 1:nParcels

                if (jNeuron == 1) % draw axon and dendrite patches only once
                
                    figure(1);
                    
                    gradationRed = 1.0 - axons(iNeuron, iParcel)/max(max(axons));
                    patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [1 gradationRed gradationRed]);
                                            
                    hold on;
                    
                    figure(1);
                    
                    % plot blue square
                    gradationBlue = 1.0 - dendrites(iNeuron, iParcel)/max(max(dendrites));
                    patch([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [gradationBlue gradationBlue 1]);
                    
                    hold on;
                        
                    figure(1);
                    
                    % draw black border around axon square
                    plot3([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], 'k');
                    
                    hold on;
                    
                    % draw black border around dendrite square
                    plot3([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [iParcel iParcel-1 iParcel-1 iParcel iParcel], 'k');
                    
                    hold on;
                    
                end % if (jNeuron == 1)
                                    
            end % iParcel
            
            figure(1);
            
            % plot purple square for overlap
            ADs = axons*dendrites';
            gradationGreen = 1.0 - ADs(iNeuron, jNeuron)/max(max(ADs));
            gradationPurple = 1.0 - 0.5*ADs(iNeuron, jNeuron)/max(max(ADs));
            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], [gradationPurple gradationGreen gradationPurple]);
            
            %                     % lighten shading as get farther from origin
            %                     patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], ...
            %                         overlapColors(isExcitatory(iNeuron)+1,:)*(0.25+(iNeuron*jNeuron)*0.5/(nNeurons*nNeurons)));
            
            hold on;
                    
            figure(1);
            
            % draw black border around overlap square
            plot3([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], 'k');
            
            hold on;
                
        end % jNeuron
        
    end % iNeuron
            
    figure(1);
    
    % draw black border along the top of the X-Z and Y-Z planes
    plot3([nNeurons 0 0], [0 0 nNeurons], [0 0 0], 'Color', [0 0 0], 'LineWidth', 2);
    
    % draw black border along the Z-axis
    plot3([0 0], [0 0], [0 nParcels], 'Color', [0 0 0], 'LineWidth', 2);
    
    % draw black border around X-Y plane
    plot3([nNeurons nNeurons 0 0 0 nNeurons nNeurons], [0 0 0 nNeurons nNeurons nNeurons 0], [0 nParcels nParcels nParcels 0 0 0], 'k', 'LineWidth', 2);
    
    for i = 0:64
        redColorMap(i+1,1:3) = [1.0 (1.0-(i/64.0)) (1.0-(i/64.0))];
    end
    
    for i = 0:64
        blueColorMap(i+1,1:3) = [(1.0-(i/64.0)) (1.0-(i/64.0)) 1.0];
    end
    
    for i = 0:64
        purpleColorMap(i+1,1:3) = [(1.0-0.5*(i/64.0)) (1.0-(i/64.0)) (1.0-0.5*(i/64.0))];
    end
    
    colormap([purpleColorMap; blueColorMap; redColorMap]);
    cbh = colorbar('EastOutside');
          
    set(cbh,'YTick', linspace(0, 1, 13));
    
%     set(cbh, 'YTickLabel', {0, max(max(ADs))*.25, max(max(ADs))*.5, max(max(ADs))*.75, max(max(ADs)), ...
%                                max(max(dendrites))*.25, max(max(dendrites))*.5, max(max(dendrites))*.75, max(max(dendrites)), ...
%                                max(max(axons))*.25, max(max(axons))*.5, max(max(axons))*.75, max(max(axons))});
    set(cbh, 'YTickLabel', {0, max(max(ADs))*.25, max(max(ADs))*.5, max(max(ADs))*.75, 0, ...
                               max(max(dendrites))*.25, max(max(dendrites))*.5, max(max(dendrites))*.75, 0, ...
                               max(max(axons))*.25, max(max(axons))*.5, max(max(axons))*.75, max(max(axons))});
    
    hold on;
    
%     cbh.TicksMode = 'manual';
%     cbh.Ticks = [0 1 2 3 4 5 6 7 8 9] ; %Create 8 ticks from zero to 1
%     
%     cbh.TickLabels = num2cell(1:9) ;    %Replace the labels of these 8 ticks with the numbers 1 to 8
    
    xlabel(' '); % Presyaptic
    
    ylabel(' '); % Postsynaptic
    
    zlabel(' '); % Parcels
    
    plotFileName = ['output/ADoverlap_fig1_', datestr(now, 'yyyymmdd_HHMMSS'), '.eps'];
    
    print(gcf, '-depsc', '-r800', plotFileName);

    plotFileName = ['output/ADoverlap_fig1_', datestr(now, 'yyyymmdd_HHMMSS'), '.tif'];
    
    print(gcf, '-dtiffnocompression', '-r800', plotFileName);
    
end