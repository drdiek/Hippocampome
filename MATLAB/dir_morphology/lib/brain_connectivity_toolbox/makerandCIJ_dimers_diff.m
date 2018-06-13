function [CIJ] = makerandCIJ_dimers_diff(allM, allD)
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
