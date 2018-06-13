function [mCount allM cellMtypes]=motif1struct_wei(W)
    mCount = zeros(4,1);

    % stores the instances of 4 types of monomers
    m1 = zeros(1,1);
    m2 = zeros(1,1);
    m3 = zeros(1,1);
    m4 = zeros(1,1);
    
    allM = { m1; m2; m3; m4; };

    cellMtypes = zeros(length(W),2);
    
    
    
    rowSum = sum(W,2);
    selfConns = diag(W);
    
    for a = 1:size(W,1)
        thisSelf = selfConns(a);
        if (thisSelf == 1) %count monomers
            Mindex = 3;
            EorI = 1;
        elseif (thisSelf == -1)
            Mindex = 4;
            EorI = -1;
        else %no self-connection
            if (rowSum(a) > 0)
                Mindex = 1;
                EorI = 1;
            elseif (rowSum(a) < 0)
                Mindex = 2;
                EorI = -1;
            end
        end
        
        if (allM{Mindex}(1) == 0)
            index2 = 1;
        else
            index2 = length(allM{Mindex})+1;
        end
        
        allM{Mindex}(index2) = a;

        cellMtypes(a,1) = Mindex;
        cellMtypes(a,2) = EorI;
    end
        
    for i = 1:4
        mCount(i) = length(allM{i});
    end
    
end

