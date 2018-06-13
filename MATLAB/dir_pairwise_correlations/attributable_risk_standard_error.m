function attributableRiskStandardError = attributable_risk_standard_error(a, b, c, d)

    attributableRiskStandardError = [0 0; 0 0];
    
    p1 = a / (a+b);
    
    p2 = c / (c+d);
    
    n1 = (a+b);
    
    n2 = (c+d);

    attributableRiskStandardError = attributableRiskStandardError + [sqrt((p1*(1-p1)/n1) + (p2*(1-p2)/n2)) 0; 0 0];
        
    p1 = b / (a+b);
    
    p2 = d / (c+d);
    
    n1 = (a+b);
    
    n2 = (c+d);

    attributableRiskStandardError = attributableRiskStandardError + [0 sqrt((p1*(1-p1)/n1) + (p2*(1-p2)/n2)); 0 0];
        
    p1 = a / (a+c);
    
    p2 = b / (b+d);
    
    n1 = (a+c);
    
    n2 = (b+d);

    attributableRiskStandardError = attributableRiskStandardError + [0 0; sqrt((p1*(1-p1)/n1) + (p2*(1-p2)/n2)) 0];
    
    p1 = c / (a+c);
    
    p2 = b / (b+d);
    
    n1 = (a+c);
    
    n2 = (b+d);

    attributableRiskStandardError = attributableRiskStandardError + [0 0; 0 sqrt((p1*(1-p1)/n1) + (p2*(1-p2)/n2))];
        
end