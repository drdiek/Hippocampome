function CijColorMap = select_colormap(maxCij, isUnvetted2Vetted)

    load parcellation.mat

    switch maxCij
        
        case 3 % all entries vetted
            colormap([WHITE;    ... % 0: no neurites
                      RED;      ... % 1: vetted axons only
                      BLUE;     ... % 2: vetted dendrites only
                      PURPLE]); ... % 3: vetted axons and dendrites
                      
        case 4 % at least one unvetted axon
            if isUnvetted2Vetted
                colormap([WHITE;       ... % 0: no neurites
                          RED;         ... % 1: vetted axons only
                          BLUE;        ... % 2: vetted dendrites only
                          PURPLE;      ... % 3: vetted axons and dendrites
                          RED]);       ... % 4: unvetted axons only
            else
                colormap([WHITE;       ... % 0: no neurites
                          RED;         ... % 1: vetted axons only
                          BLUE;        ... % 2: vetted dendrites only
                          PURPLE;      ... % 3: vetted axons and dendrites
                          LIGHT_RED]); ... % 4: unvetted axons only
            end % if isUnvetted2Vetted
                 
        case 5 % at least one unvetted dendrite
            if isUnvetted2Vetted
                colormap([WHITE;        ... % 0: no neurites
                          RED;          ... % 1: vetted axons only
                          BLUE;         ... % 2: vetted dendrites only
                          PURPLE;       ... % 3: vetted axons and dendrites
                          RED;          ... % 4: unvetted axons only
                          BLUE]);       ... % 5: unvetted dendrites only
            else
                colormap([WHITE;        ... % 0: no neurites
                          RED;          ... % 1: vetted axons only
                          BLUE;         ... % 2: vetted dendrites only
                          PURPLE;       ... % 3: vetted axons and dendrites
                          LIGHT_RED;    ... % 4: unvetted axons only
                          LIGHT_BLUE]); ... % 5: unvetted dendrites only
            end % if isUnvetted2Vetted
    elseif (nColors == 6)
        if isUnvetted2Vetted
            colormap([WHITE;      ... % 0: no neurites
                      RED;        ... % 1: vetted axons only
                      BLUE;       ... % 2: vetted dendrites only
                      PURPLE;     ... % 3: vetted axons and dendrites
                      RED;        ... % 4: unvetted axons only
                      BLUE;       ... % 5: unvetted dendrites only
                      WHITE;      ... % 6: not used
                      WHITE;      ... % 7: not used
                      WHITE;      ... % 8: not used
                      PURPLE]);       % 9: unvetted axons and dendrites
        else
            colormap([WHITE;      ... % 0: no neurites
                      RED;        ... % 1: vetted axons only
                      BLUE;       ... % 2: vetted dendrites only
                      PURPLE;     ... % 3: vetted axons and dendrites
                      LIGHT_RED;  ... % 4: unvetted axons only
                      LIGHT_BLUE; ... % 5: unvetted dendrites only
                      WHITE;      ... % 6: not used
                      WHITE;      ... % 7: not used
                      WHITE;      ... % 8: not used
                      LIGHT_PURPLE]); % 9: unvetted axons and dendrites
        end % if isUnvetted2Vetted
    end

    
end % select_colormap()