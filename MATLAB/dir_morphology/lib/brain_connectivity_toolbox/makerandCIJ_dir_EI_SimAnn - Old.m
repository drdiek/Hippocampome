function [CIJ] = makerandCIJ_dir_EI_SimAnn(allM, allD, origCount, disconnCount)

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

N = 0;
for i=1:4
    N = N + size(allM{i},2);
end


Ke = 0;
Ki = 0;
for i=1:26
    if (i <= 4) || (i >= 9 && i <= 12)
        Ke = Ke + size(allD{i},2);
    elseif (i >= 5 && i <= 8) || (i >=13 && i <= 16)
        Ki = Ki + size(allD{i},2);
    elseif (i == 17) || (i == 19) || (i == 22)
        Ke = Ke + 2*size(allD{i},2);
    elseif (i == 18) || (i == 20) || (i == 25)
        Ki = Ki + 2*size(allD{i},2);
    elseif (i == 21) || (i == 23) || (i == 24) || (i == 26)
        Ke = Ke + size(allD{i},2);
        Ki = Ki + size(allD{i},2);
    end
end

K = Ki+Ke;

CIJ = makerandCIJ_dir(N,K);

% add self connections
NeNO = length(allM{1});
NiNO = length(allM{2});
NeYES = length(allM{3});
NiYES = length(allM{4});

for a=1:NeYES
    CIJ(allM{3}(a),allM{3}(a)) = 1;
end
for b=1:NiYES
    CIJ(allM{4}(b),allM{4}(b)) = 1;
end

for c=1:N
    CIJ(c,:) = CIJ(c,:)*determineEorI(allM, c);
end


[newCount newDisconnCount newAllM newDisconnD newTempAllD newAllD] = motif2struct_wei(CIJ);
%origCount
%disconnCount
%newCount
%newDisconnCount
curDiff = sum(newCount - origCount, 1)


[row, col] = find(CIJ);

counter = 1;
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
