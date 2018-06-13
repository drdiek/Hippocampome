function [density] = load_density_data(nNeurons,nParcels,density)
    % fetch density data from file %%%%%%%%%%%%%%%%%%%%
    disp('Loading density data from file ...');
    
    for i = 1:nNeurons
        for j = 1:nParcels
%             % read in density values for axons
%             if ~isnan(cell2mat(density.raw(1+i*4,j+1))) % start with row 5 of num then skip every fourth; start with column 1 of raw
%                 density.raw(1+i*4,j+1)
%                 cell2mat(density.raw(1+i*4,j+1))
%                 pause
%                 density.axons(i,j) = cell2mat(density.raw(1+i*4,j+1));
%             end
%             % read in density values for dendrites
%             if ~isnan(cell2mat(density.raw(1+i*4+2,j+1)))
%                 density.dendrites(i,j) = cell2mat(density.raw(1+i*4+2,j+1));
%             end
            % read in density values for axons
            if ~isnan(density.numbers(-3+i*4,j)) % start with row 1 of num then skip every fourth
                density.axons(i,j) = density.numbers(-3+i*4,j);
            end
            % read in density values for dendrites
            if ~isnan(density.numbers(-3+i*4+2,j))
                density.dendrites(i,j) = density.numbers(-3+i*4+2,j);
            end
        end % j
    end % i

end % load_density_data()