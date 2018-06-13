function AD = merge_axons_and_dendrites(A,D)

    if ((A == 2) && (D == 2))       % PURPLE
        AD = 15;
    elseif ((A == 2) && (D == 1))   % (RED+BLUE_LIGHT)/2
        AD = 14;
    elseif ((A == 2) && (D == 0))   % (RED+BLUE_ULTRALIGHT)/2
        AD = 13;
    elseif ((A == 2) && (D == -1))  % RED
        AD = 12;
    elseif ((A == 1) && (D == 2))   % (RED_LIGHT+BLUE)/2
        AD = 11;
    elseif ((A == 1) && (D == 1))   % PURPLE_LIGHT
        AD = 10;
    elseif ((A == 1) && (D == 0))   % (RED_LIGHT+BLUE_ULTRALIGHT)/2
        AD = 9;
    elseif ((A == 1) && (D == -1))  % RED_LIGHT
        AD = 8;
    elseif ((A == 0) && (D == 2))   % (RED_ULTRALIGHT+BLUE)/2
        AD = 7;
    elseif ((A == 0) && (D == 1))   % (RED_ULTRALIGHT+BLUE_LIGHT)/2
        AD = 6;
    elseif ((A == 0) && (D == 0))   % PURPLE_ULTRALIGHT
        AD = 5;
    elseif ((A == 0) && (D == -1))  % RED_ULTRALIGHT
        AD = 4;
    elseif ((A == -1) && (D == 2))  % BLUE
        AD = 3;
    elseif ((A == -1) && (D == 1))  % BLUE_LIGHT
        AD = 2;
    elseif ((A == -1) && (D == 0))  % BLUE_ULTRALIGHT
        AD = 1;
    else % ((A == -1) && (D == -1)) % WHITE
        AD = 0;
    end 

end % merge_axons_and_dendrites()