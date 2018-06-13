function [connectionProbabilities] = calculate_connection_probabilities(nNeurons,nParcels,density,is)
    % calculate cross-multiplied densities %%%%%%%%%%%%%%%%%%%%%
    disp('Multiplying densities ...');
    for iNeuron = 1:nNeurons
        for jNeuron = 1:nNeurons
            if is.targeting.axonalDendritic(iNeuron)
                connectionProbabilities.tensor(iNeuron,jNeuron,1:nParcels) = density.axons(iNeuron,1:nParcels) .* density.dendrites(jNeuron,1:nParcels);
                
            elseif is.targeting.axonInitialSegment(iNeuron)
                if is.principalCell(jNeuron)
                    for kParcel = 1:nParcels
                        if is.principalCellLayer(kParcel)
                            connectionProbabilities.tensor(iNeuron,jNeuron,kParcel) = density.axons(iNeuron,kParcel) .* 1; %density.dendrites(jNeuron,kParcel);
                        else
                            connectionProbabilities.tensor(iNeuron,jNeuron,kParcel) = 0;
                        end % if
                    end % kParcel
                else % postsynaptic cell is not a principal cell
                    connectionProbabilities.tensor(iNeuron,jNeuron,1:nParcels) = 0;
                end % if
                
            elseif is.targeting.interneuronSpecific(iNeuron)
                if is.excitatory(jNeuron)
                    connectionProbabilities.tensor(iNeuron,jNeuron,1:nParcels) = 0;
                else % postsynaptic cell is inhibitory
                    connectionProbabilities.tensor(iNeuron,jNeuron,1:nParcels) = density.axons(iNeuron,1:nParcels) .* density.dendrites(jNeuron,1:nParcels);
                end % if
                
            elseif is.targeting.somatic(iNeuron)
                if is.somaInPcl(jNeuron)
                    for kParcel = 1:nParcels
                        if is.principalCellLayer(kParcel)
                            connectionProbabilities.tensor(iNeuron,jNeuron,kParcel) = density.axons(iNeuron,kParcel) .* density.dendrites(jNeuron,kParcel);
                        else % current parcel is not a principal cell layer
                            connectionProbabilities.tensor(iNeuron,jNeuron,kParcel) = 0;
                        end % if
                    end % j
                else % postsynaptic cell soma is not in the principal cell layer
                    connectionProbabilities.tensor(iNeuron,jNeuron,1:nParcels) = 0;
                end % if
                
            end % is.targeting(iNeuron) 
        end % jNeuron
    end % iNeuron
    
end % calculate_connection_probabilities()