function [relativeRisk, rrAutoInterpStrs] = relative_risk(contingencyMatrix, propertyStr1, propertyStr2)

    a = contingencyMatrix(1,1);

    b = contingencyMatrix(1,2);

    c = contingencyMatrix(2,1);
    
    d = contingencyMatrix(2,2);
    
    
    relativeRisk = [(a/(a+b))/(c/(c+d)) (b/(a+b))/(d/(c+d)); ...
                    (a/(a+c))/(b/(b+d)) (c/(a+c))/(d/(b+d))];
    
    relativeRiskStandardError = relative_risk_standard_error(a, b, c, d);
    
    relativeRiskConfidenceIntervalsLower = exp(log(relativeRisk) - (1.96 * relativeRiskStandardError));
    
    relativeRiskConfidenceIntervalsUpper = exp(log(relativeRisk) + (1.96 * relativeRiskStandardError));
    
    
    propertyStr{1,1} = {propertyStr2, propertyStr1};
    
    propertyStr{1,2} = {strcat('NOT_',propertyStr2), propertyStr1};
    
    
    propertyStr{2,1} = {propertyStr1, propertyStr2};
    
    propertyStr{2,2} = {strcat('NOT_',propertyStr1), propertyStr2};
    
    
    for i = 1:2
        
        for j = 1:2
            
            propertyStrB = char(propertyStr{i,j}{1});
            
            propertyStrA = char(propertyStr{i,j}{2});
            
            if (relativeRisk(i,j) == 1)
                
                strng = sprintf('The probability of types having %s is equal for both %s and NOT_%s types.', propertyStrB, propertyStrA, propertyStrA);
                
            elseif (abs(relativeRisk(i,j) - 1) <= 0.1)
                
                strng = sprintf('The probability of types having %s is nearly equal (%.2f) for both %s and NOT_%s types.', propertyStrB, relativeRisk(i,j), propertyStrA, propertyStrA);
                
            else
                
                strng = sprintf('Those types having %s are %.2f times more likely to have %s than to have NOT_%s.', propertyStrB, relativeRisk(i,j), propertyStrA, propertyStrA);
                
            end
            
            strng = sprintf('%s The 95%% Confidence Interval is %.3f < %.3f < %.3f.', strng, relativeRiskConfidenceIntervalsLower(i,j), relativeRisk(i,j), relativeRiskConfidenceIntervalsUpper(i,j));
            
            if ((relativeRiskConfidenceIntervalsLower(i,j) < 1) && (1 < relativeRiskConfidenceIntervalsUpper(i,j)))
                
                strng = sprintf('%s Since this interval includes 1 there is not significant evidence to suggest an increased chance of %s for %s over NOT_%s.', strng, propertyStrB, propertyStrA, propertyStrA);
            
            else
                
                strng = sprintf('%s Since this interval does not include 1 there is significant evidence to suggest an increased chance of %s for %s over NOT_%s.', strng, propertyStrB, propertyStrA, propertyStrA);

            end
            
            rrAutoInterpStrs{i,j} = strng;
            
        end % for j
        
    end % for i
    
end % relative_risk