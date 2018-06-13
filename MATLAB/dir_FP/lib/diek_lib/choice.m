function n = choice(x)
    
    r = ceil(length(x) * rand(1));
    
    n = x(r);
