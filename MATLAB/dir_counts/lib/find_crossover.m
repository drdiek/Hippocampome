function index = find_crossover(nCount, nFormula)

    idx = find(nCount < nFormula);
    index = length(idx)+1;

end % find_crossover()