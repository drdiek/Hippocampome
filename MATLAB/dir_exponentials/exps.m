function exps()

    t = [0:0.1:30];
    
    gsyn_bar = 1;
    
    tau1 = 5;
    
    tau2 = 3;
    
    tau_peak = 4;
    
    gsyn = gsyn_bar*(exp(-t/tau1)-exp(-t/tau2));
    
    gsyn_max = max(gsyn);
    
    cla;
    
    figure(1)
    
    plot(t, gsyn)
    
    hold on
    
    gsyn_alpha = gsyn_max*(t/tau_peak).*exp(1-(t/tau_peak));
    
    plot(t, gsyn_alpha, 'r');

end % exps()