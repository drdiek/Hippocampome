function quantify_neurites()

    clear all;
    
    a = 200; % radius along x-axis ([micro]m)
    
    b = 200; % radius along y-axis ([micro]m)
    
    c = 200; % radius along z-axis ([micro]m)
    
    depth = 50; % distance from soma to surface of the slice ([micro]m)
    
    h = c - depth; % depth of tissue missing due to slice ([micro]m)
    
    Vcap = ((pi*a^2*h^2)/(3*c^2))*(3*c-h);
    
    Vwhole = (4/3)*pi*a*b*c;
    
    Vslice = Vwhole - Vcap;
    
    Vratio = Vcap/Vslice;
    
    Lslice = [0:10000];
    
    Lcap = Lslice*Vratio^(1/3);
    
    figure(1);
    
    clf;
    
    plot(Lslice, Lcap)
    
    hold on;
    
    plot(Lslice, Lslice*Vratio, 'r');
    
    plot(Lslice, Lslice*Vratio^0.5, 'k');
    
    
    figure(2);
    
    clf;
        
    for h = 0:0.1:c

        Vcap = ((pi*a^2*h^2)/(3*c^2))*(3*c-h);
        
        Vwhole = (4/3)*pi*a*b*c;
        
        Vslice = Vwhole - Vcap;
        
        Vratio = Vcap/Vslice;
        
        plot(h, Vratio^(1/2.35), 'b');

        hold on;
        
        plot(h, Vratio^(1/2.3), 'r');
        
        plot(h, Vratio^(1/2.25), 'g');
        
        plot(h, h/c, 'k');
        
        
    end % for h
        
end % quantify_neurites()