function plot_periodic_table()

    cla;
    
%     fileName = 'PTE.csv';
%     fileName = 'PTE_DG.csv';
    fileName = 'PTE_graphical_abstract.csv';
%     fileName = 'PTE_CA1.csv';
%     fileName = 'PTE_DG_order.csv';
%     fileName = 'PTE_Cat.csv';
%     fileName = 'PTE_Cat_with_threshold.csv';
%     fileName = 'PTE_fly.csv';
%     fileName = 'PTE_fly_glut-GABA.csv';
%     fileName = 'PTE_fly_glut-GABA_reduced-parcels.csv';
%     fileName = 'PTE_fly_glut-GABA_by_day_reduced-parcels.csv';
%     fileName = 'PTE_fly_ACh-GABA_by_day_reduced-parcels.csv';
%     fileName = 'PTE_fly_neurotransmitter_reduced-parcels.csv';

    fileNameFull = sprintf('PT_input/%s', fileName);

    [cells, isFileLoaded] = load_csvFile(fileNameFull);
    
    nNeurons = size(cells,1)
    
    nParcels = size(cells,2) - 2;
    
    for iNeuron = 1:nNeurons
        
        label{iNeuron} = cells{iNeuron, 1};
        
        EorI = cells{iNeuron, 2};
        
        isExcitatory(iNeuron) = strcmp(EorI, 'E');
        
        for iParcel = 1:nParcels
            
            neurites(iNeuron,iParcel) = str2num(cells{iNeuron, 2 + nParcels + 1 - iParcel}); % reverses the order of the parcels for better display in the plot
            
        end
        
    end
    
    [label, isExcitatory, neurites] = sort_periodic_table2(label, isExcitatory, neurites);
    
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
    
    figure(2);
    
    clf;
    
    colormap([colors(3,:); colors(4,:)]); % dark purple, light purple
                        
    for iNeuron = 1:nNeurons % loop through presynaptic neurons
    
        for jNeuron = 1:nNeurons % loop through postsynaptic neurons
        
            isOverlap = 0;
            
            for iParcel = 1:nParcels

                if (jNeuron == 1) % draw axon and dendrite patches only once
                
                    if ((neurites(iNeuron,iParcel) == 1) || (neurites(iNeuron,iParcel) == 3)) % check for axons in current parcel
                        
                        figure(1);
                        
                        if isExcitatory(iNeuron) % plot red square
                        
                            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [1 0 0]);
%                             % lighten shading as get farther from origin
%                             patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [1 0 0]*(0.5+(iNeuron*0.5/nNeurons)));

                        else % plot light red square
                            
                            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [1 0.6 0.6]);
%                             % lighten shading as get farther from origin
%                             patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [1 0.6 0.6]*(0.5+(iNeuron*0.5/nNeurons)));

                        end
                            
                        hold on;
                        
                    end
                    
                    if ((neurites(iNeuron,iParcel) == 2) || (neurites(iNeuron,iParcel) == 3)) % check for dendrites in current parcel
                        
                        figure(1);
                        
                        % plot blue square
                        patch([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [0 0 1]);
%                         % lighten shading as get farther from origin
%                         patch([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [0 0 1]*(0.5+(iNeuron*0.5/nNeurons)));
                        
                        hold on;
                        
                    end
                    
                    figure(1);
                    
                    % draw black border around axon square
                    plot3([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], 'k');
                    
                    hold on;
                    
                    % draw black border around dendrite square
                    plot3([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [iParcel iParcel-1 iParcel-1 iParcel iParcel], 'k');
                    
                    hold on;
                    
                end % if (jNeuron == 1)
                    
                % check for overlap between presynaptic axons and postsynaptic dendrites
                pixelColor = 0;
                    
                % check if presynaptic axon
                if ((neurites(iNeuron,iParcel) == 1) || (neurites(iNeuron,iParcel) == 3))
                        
                    pixelColor = pixelColor + 1;
                
                end
                    
                % check if postsynaptic dendrite
                if ((neurites(jNeuron,iParcel) == 2) || (neurites(jNeuron,iParcel) == 3))
                    
                    pixelColor = pixelColor + 2;
                    
                end
                
                if (pixelColor == 3) % presynaptic axon overlaps a postsynaptic dendrite
                
                    figure(2);
                    
                    if isExcitatory(iNeuron) % plot dark purple dot
                    
%                         plotcube([1 1 1],[iNeuron-1 jNeuron-1 iParcel-1],.15,colors(pixelColor,:));
%                         scatter3(iNeuron,jNeuron,iParcel,100,colors(pixelColor,:),'filled')
                    
                        % plot an elongated ovoid marker
                        [x,y,z] = ellipsoid(iNeuron-0.5,jNeuron-0.5,iParcel-0.5,0.25,0.25,0.25+0.25/4);
                        
                        % get rid of mesh lines and color the surface uniformly
                        
                        if (iNeuron  == 5 && jNeuron == 8 && iParcel == 1) % DG
                        
                            surf(x,y,z,zeros(21),'EdgeColor','none','FaceAlpha',1.0);
                        
                        else
                            
                            surf(x,y,z,zeros(21),'EdgeColor','none','FaceAlpha',1.0);
                        
                        end
                        
%                         colormap([colors(pixelColor,:); colors(pixelColor+1,:)]);
                        
                    else % plot light purple dot
                        
%                         plotcube([1 1 1],[iNeuron-1 jNeuron-1 iParcel-1],.15,colors(pixelColor+1,:));
%                         scatter3(iNeuron,jNeuron,iParcel,100,colors(pixelColor+1,:),'filled')
                    
                        % plot an elongated ovoid marker
                        [x,y,z] = ellipsoid(iNeuron-0.5,jNeuron-0.5,iParcel-0.5,0.25,0.25,0.25+0.25/4);
                        
                        % get rid of mesh lines and color the surface uniformly
                        if (iNeuron  == 8 && jNeuron == 5 && iParcel == 4) % DG
                        
                            surf(x,y,z,ones(21),'EdgeColor','none','FaceAlpha',1.0);
                        
                        else
                            
                            surf(x,y,z,ones(21),'EdgeColor','none','FaceAlpha',1.0);
                        
                        end

                    end
                        
                    hold on;
                    
                    isOverlap = 1;
                    
                end
                
            end % iParcel
            
            if isOverlap % plot black/gray square indicating potential overlap
               
                    figure(1);
                    
                    % plot black square for excitatory overlap and gray for inhibitory overlap
                    patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], overlapColors(isExcitatory(iNeuron)+1,:));

%                     % lighten shading as get farther from origin
%                     patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], ...
%                         overlapColors(isExcitatory(iNeuron)+1,:)*(0.25+(iNeuron*jNeuron)*0.5/(nNeurons*nNeurons)));

                    hold on;
                    
            end
                    
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
    
    xlabel(' '); % Presyaptic
    
    ylabel(' '); % Postsynaptic
    
    zlabel(' '); % Parcels
    
    plotFileName = ['PT_output/', fileName(1:end-4), '_fig1_', datestr(now, 'yyyymmdd_HHMMSS'), '.eps'];
    
    print(gcf, '-depsc', '-r800', plotFileName);

    plotFileName = ['PT_output/', fileName(1:end-4), '_fig1_', datestr(now, 'yyyymmdd_HHMMSS'), '.tif'];
    
    print(gcf, '-dtiffnocompression', '-r800', plotFileName);
    
    figure(2);
    
%     h_circle=circle_3D(0.5, [5 8 1], [1 1 1], [0 0 0]); % DG
%     h_circle=circle_3D(0.5, [8 5 4], [1 1 1], [0 0 0]); % DG
    %example:
    %>> h_circle=circle_3D(3, [0 0 0], [1 1 1]);
    %plots a circle of radius 3, perpendicular to the vector (1, 1, 1)
    %around the origin of the coordinates system%
    
%     view(180-37.5,30);
    view(180-45,30);
    
    axis([0 nNeurons 0 nNeurons 0 nParcels]);

    xlabel(' '); % Presynaptic
    
    ylabel(' '); % Postsynaptic
    
    zlabel(' '); % Parcels
    
    pbaspect([1,1,0.4]) % uniform is [1,1,1]
    
    ax = gca;
    
    set(ax,'ZTick',[0:nParcels]);
    
    plotFileName = ['PT_output/', fileName(1:end-4), '_fig2.eps'];
    
    print(gcf, '-depsc', '-r800', plotFileName);
    
    plotFileName = ['PT_output/', fileName(1:end-4), '_fig2.tif'];

    print(gcf, '-dtiffnocompression', '-r600', plotFileName);
    
   ll= label

end