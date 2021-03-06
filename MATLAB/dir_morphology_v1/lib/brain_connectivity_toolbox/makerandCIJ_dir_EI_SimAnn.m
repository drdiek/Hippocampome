function [CIJ] = makerandCIJ_dir_EI_SimAnn(CIJ)

% inputs:
%           allM - list & counts of 4 types of monomers
%           allD - list & counts of 26 types of monomers
% output:
%           CIJ = directed random connection matrix
%
% Generates a random directed binary connection matrix, with the correct
% numbers of monomers and dimers randomly placed
%
% Olaf Sporns, Indiana University, 2007/2008
% Christopher Rees, George Mason University, 2010




[newCount newDisconnCount newAllM newDisconnD newTempAllD newAllD] = motif2struct_wei(CIJ);
origCount
disconnCount
newCount
newDisconnCount
curDiff = sum(newCount - origCount, 1)

pause
[row, col] = find(CIJ);

counter = 1000000000000;
% pick 2 random edges & determine if energy function is lower
while (curDiff > 100 && counter < 10000)
    counter = counter + 1;
    
    randIndices = randperm(length(row));
    row1 = row(randIndices(1));
    col1 = col(randIndices(1));
    row2 = row(randIndices(2));
    col2 = col(randIndices(2));
    
    CIJ(row1,col2) = determineEorI(allM, row1);
    CIJ(row2,col1) = determineEorI(allM, row2);
    CIJ(row1,col1) = 0;
    CIJ(row2,col2) = 0;
    
    [newCount newDisconnCount newAllM newDisconnD newTempAllD newAllD] = motif2struct_wei(CIJ);
    %newCount
    newDiff = sum(newCount - origCount, 1)
    %pause

    if (newDiff <= curDiff)
        % allow swap
        curDiff = newDiff;
    else
        % otherwise, pick random # and maybe allow swap
        acceptanceR = rand(1);
        T = 2.5;
        if (acceptanceR < exp(-1*T*abs(curDiff - newDiff)))
            % swap
            curDiff = newDiff;
        else
            %don't swap (revert back)
            CIJ(row1,col1) = determineEorI(allM, row1);
            CIJ(row2,col2) = determineEorI(allM, row2);
            CIJ(row1,col2) = 0;
            CIJ(row2,col1) = 0;
        end
    end

end %while

    
pause
end



function [value] = determineEorI(allM, node)
    if find(ismember(allM{1}, node))
        value = 1;
    end
    if find(ismember(allM{2}, node))
        value = -1;
    end
    if find(ismember(allM{3}, node))
        value = 1;
    end
    if find(ismember(allM{4}, node))
        value = -1;
    end
end
