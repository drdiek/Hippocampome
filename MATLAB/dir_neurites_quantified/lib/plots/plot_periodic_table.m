function plot_periodic_table(nNeurons,nParcels,nCells,quantity,neuritesQuantified,overlapBinary,subregion)
    % plot periodic table %%%%%%%%%%%%%%%%%%    
    disp('Plotting periodic table ...');
    
    cla;
    
    [quantity,neuritesQuantified,overlapColors] = initialize_periodic_table_plots(nNeurons,nParcels,nCells,quantity,neuritesQuantified,overlapBinary,subregion.label);
 
    if strcmp(subregion.label,'DG')
        neuronStep = 0;
        nNeurons = nCells.DG;
    elseif strcmp(subregion.label,'CA3')
        neuronStep = nCells.DG;
        nNeurons = nCells.CA3;
    elseif strcmp(subregion.label,'CA2')
        neuronStep = nCells.DG+nCells.CA3;
        nNeurons = nCells.CA2;
    elseif strcmp(subregion.label,'CA1')
        neuronStep = nCells.DG+nCells.CA3+nCells.CA2;
        nNeurons = nCells.CA1;
    elseif strcmp(subregion.label,'Sub')
        neuronStep = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1;
        nNeurons = nCells.Sub;
    elseif strcmp(subregion.label,'EC')
        neuronStep = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub;
        nNeurons = nCells.EC;
    else
        neuronStep = 0;
        neuronEnd = nNeurons;
    end
   
    figure(1);    
    axis([0 nNeurons 0 nNeurons 0 nParcels]);
    pbaspect([3.75,3.75,1.5]) % uniform is [3.75,3.75,1]
    hold on;
    
    for iNeuron = 1:nNeurons % loop through presynaptic neurons
    
        for jNeuron = 1:nNeurons % loop through postsynaptic neurons
        
            isOverlap = 0;
            
            for kParcel = 1:nParcels

                if (jNeuron == 1) % draw axon and dendrite patches only once
                
                    if (quantity.axons(iNeuron+neuronStep,kParcel) > 0) % check for axons in current parcel
                        
                        figure(1);
                        
                        if (quantity.axons(iNeuron+neuronStep,kParcel) >= 15.0) % plot red square
                            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [kParcel kParcel-1 kParcel-1 kParcel kParcel], [1 0 0]);
                        else % plot light red square
                            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [kParcel kParcel-1 kParcel-1 kParcel kParcel], [1 0.6 0.6]);
                        end
                            
                        hold on;
                        
                    end
                    
                    if (quantity.dendrites(iNeuron+neuronStep,kParcel) > 0) % check for dendrites in current parcel
                        
                        figure(1);
                        
                        if (quantity.dendrites(iNeuron+neuronStep,kParcel) >= 15.0) % plot blue square
                            patch([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [kParcel kParcel-1 kParcel-1 kParcel kParcel], [0 0 1]);
                        else % plot light blue square
                            patch([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [kParcel kParcel-1 kParcel-1 kParcel kParcel], [0.6 0.6 1]);
                        end

                        hold on;
                        
                    end
                    
                    figure(1);
                    
                    % draw black border around axon square
                    plot3([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [kParcel kParcel-1 kParcel-1 kParcel kParcel], 'k');
                    
                    hold on;
                    
                    % draw black border around dendrite square
                    plot3([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [kParcel kParcel-1 kParcel-1 kParcel kParcel], 'k');
                    
                    hold on;
                    
                end % if (jNeuron == 1)
                                        
                % plot a "raindrop" at tensor location (i,j,k) when the connection probability is greater than zero
                if (quantity.tensor(iNeuron+neuronStep,jNeuron+neuronStep,kParcel) > 0)
                        
                    figure(2);
                    
                    [x,y,z] = ellipsoid(iNeuron-0.5,jNeuron-0.5,kParcel-0.5,0.25,0.25,0.25+0.25/1);%4);
                    
                    hs = surf(x,y,z,zeros(21),'EdgeColor','none','FaceAlpha',1.0);
                    
                    if (quantity.tensorScaled(iNeuron+neuronStep,jNeuron+neuronStep,kParcel) == 0)
                        set(hs, 'FaceColor', quantity.colormap(1,:));
                    else
                        set(hs, 'FaceColor', quantity.colormap(quantity.tensorScaled(iNeuron+neuronStep,jNeuron+neuronStep,kParcel),:));
                    end
                    
                    hold on;
                    
                    isOverlap = 1; % at least one "raindrop" is located in a parcel at vector (i,j)
                    
                end % if (connectionProbabilities.tensor(iNeuron,jNeuron,kParcel) > 0)
                    
            end % kParcel

            if isOverlap % plot black/gray square indicating potential overlap
               
                figure(1);
                
                % plot black square for excitatory overlap and gray for inhibitory overlap
                patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], overlapColors(strcmp(overlapBinary.EorI{iNeuron+neuronStep},'E')+1,:));
                
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
    
    xlabel('Presynaptic'); % Presyaptic
    
    ylabel('Postsynaptic'); % Postsynaptic
    
    zlabel('Parcels'); % Parcels
    
    figure(2);
    
    view(149,48);
    
    axis([0 nNeurons 0 nNeurons 0 nParcels]);

    xlabel(' '); % Presynaptic
    
    ylabel(' '); % Postsynaptic
    
    zlabel(' '); % Parcels
    
    pbaspect([1,1,0.4]) % uniform is [1,1,1]
    
    ax = gca;
    
    set(ax,'ZTick',[0:nParcels]);
    
end % plot_periodic_table()