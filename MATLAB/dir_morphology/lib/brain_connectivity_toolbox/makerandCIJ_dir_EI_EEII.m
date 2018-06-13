function [CIJ] = makerandCIJ_dir_EI_EEII(Cij, nInhib, nExcit, nIIedges, nEEedges)

    cellTypes = sign(sum(Cij,2));
    %iDens = nIIedges/(nInhib*nInhib);
    %eDens = nEEedges/(nExcit*nExcit);
    
    possibleEtoE = zeros(nExcit^2);
    possibleItoI = zeros(nInhib^2);
    
    iIndex = 1;
    eIndex = 1;
    for row=1:length(Cij)
        for col=1:length(Cij)
            if ((cellTypes(row) == 1) && (cellTypes(col) == 1))
                possibleEtoE(eIndex) = sub2ind(size(Cij),row,col);
                eIndex = eIndex + 1;
            elseif ((cellTypes(row) == -1) && (cellTypes(col) == -1))
                possibleItoI(iIndex) = sub2ind(size(Cij),row,col);
                iIndex = iIndex + 1;
            end
        end
    end
    
    randomEtoE = randperm(length(possibleEtoE));
    randomItoI = randperm(length(possibleItoI));
    
    CIJ = zeros(length(Cij),length(Cij));
    for i=1:nEEedges
        CIJ(possibleEtoE(randomEtoE(i))) = 1;
    end
    for j=1:nIIedges
        CIJ(possibleItoI(randomItoI(j))) = -1;
    end
end

