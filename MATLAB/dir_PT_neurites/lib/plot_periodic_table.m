function plot_periodic_table(nNeurons,nParcels,percentOfPresence,connectionProbabilities,is)
    % plot periodic table %%%%%%%%%%%%%%%%%%    
    disp('Plotting periodic table ...');
    
    cla;
    
    [percentOfPresence,connectionProbabilities,overlapColors] = initialize_periodic_table_plots(nNeurons,nParcels,percentOfPresence,connectionProbabilities);
    
    for iNeuron = 1:nNeurons % loop through presynaptic neurons
    
        for jNeuron = 1:nNeurons % loop through postsynaptic neurons
        
            isOverlap = 0;
            
            for kParcel = 1:nParcels

                if (jNeuron == 1) % draw axon and dendrite patches only once
                
                    if (percentOfPresence.axons(iNeuron,kParcel) > 0) % check for axons in current parcel
                        
                        figure(1);
                        
                        if (percentOfPresence.axons(iNeuron,kParcel) >= 15.0) % plot red square
                            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [kParcel kParcel-1 kParcel-1 kParcel kParcel], [1 0 0]);
                        else % plot light red square
                            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [kParcel kParcel-1 kParcel-1 kParcel kParcel], [1 0.6 0.6]);
                        end
                            
                        hold on;
                        
                    end
                    
                    if (percentOfPresence.dendrites(iNeuron,kParcel) > 0) % check for dendrites in current parcel
                        
                        figure(1);
                        
                        if (percentOfPresence.dendrites(iNeuron,kParcel) >= 15.0) % plot blue square
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
                if (connectionProbabilities.tensor(iNeuron,jNeuron,kParcel) > 0)
                        
                    figure(2);
                    
                    [x,y,z] = ellipsoid(iNeuron-0.5,jNeuron-0.5,kParcel-0.5,0.25,0.25,0.25+0.25/1);%4);
                    
                    hs = surf(x,y,z,zeros(21),'EdgeColor','none','FaceAlpha',1.0);
                    
                    if (connectionProbabilities.tensorScaled(iNeuron,jNeuron,kParcel) == 0)
                        set(hs, 'FaceColor', connectionProbabilities.colormap(1,:));
                    else
                        set(hs, 'FaceColor', connectionProbabilities.colormap(connectionProbabilities.tensorScaled(iNeuron,jNeuron,kParcel),:));
                    end
                    
                    hold on;
                    
                    isOverlap = 1; % at least one "raindrop" is located in a parcel at vector (i,j)
                    
                end % if (connectionProbabilities.tensor(iNeuron,jNeuron,kParcel) > 0)
                    
            end % kParcel

            outputData(iNeuron,jNeuron) = sum(connectionProbabilities.tensor(iNeuron,jNeuron,1:nParcels));
            
            if isOverlap % plot black/gray square indicating potential overlap
               
                figure(1);
                
                % plot black square for excitatory overlap and gray for inhibitory overlap
                patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], overlapColors(is.excitatory(iNeuron)+1,:));
                
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