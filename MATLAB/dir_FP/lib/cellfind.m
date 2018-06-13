function [TF, idx] = cellfind(uniqueNeurite,neurites)
% CELLFIND Find one cell entry within another cell array.
%
%     [TF,idx] = STRCMP(S1,S2) compares the cell entry S1 and the cell entries of
%     S2 and returns logical 1 (true) if they are identical, and returns
%     logical 0 (false) otherwise. Also returns a vector idx containing the
%     linear indices corresponding to the true entries of the array TF.

    idx = [];
    for i = 1:length(neurites)
        TF(i) = strcmp(uniqueNeurite,neurites{i});
        if TF(i)
            idx = horzcat(idx, i);
        end
    end

end % cellfind()