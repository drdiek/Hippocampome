function [percentOfPresence] = load_percent_of_presence_data(nNeurons,nParcels,percentOfPresence)
    % fetch percent of presence data from file %%%%%%%%%%%%%%%%%%%%    
    disp('Loading percent-of-presence data ...');
    
    for i = 1:nNeurons
        for j = 1:nParcels
%             % read in percent of presence values for axons
%             if ~isnan(cell2mat(percentOfPresence.raw(1+i*4,j+1))) % start with row 5 of raw then skip every fourth; start with column 1 of raw
%                 percentOfPresence.axons(i,j) = cell2mat(percentOfPresence.raw(1+i*4,j+1));
%             end
%             % read in percent of presence values for dendrites
%             if ~isnan(cell2mat(percentOfPresence.raw(1+i*4+2,j+1)))
%                 percentOfPresence.dendrites(i,j) = cell2mat(percentOfPresence.raw(1+i*4+2,j+1));
%             end
            % read in percent of presence values for axons
            if ~isnan(percentOfPresence.numbers(-3+i*4,j)) % start with row 1 of num then skip every fourth
                percentOfPresence.axons(i,j) = percentOfPresence.numbers(-3+i*4,j);
            end
            % read in percent of presence values for dendrites
            if ~isnan(percentOfPresence.numbers(-3+i*4+2,j))
                percentOfPresence.dendrites(i,j) = percentOfPresence.numbers(-3+i*4+2,j);
            end
        end % j  
    end % i
    
end % load_percent_of_presence_data()