function [attributableRisk, arAutoInterpStrs] = attributable_risk(contingencyMatrix, propertyStr1, propertyStr2)

    a = contingencyMatrix(1,1);

    b = contingencyMatrix(1,2);

    c = contingencyMatrix(2,1);
    
    d = contingencyMatrix(2,2);
    
    
    attributableRisk = [(a/(a+b)) - (c/(c+d)) (b/(a+b)) - (d/(c+d)); ...
                        (a/(a+c)) - (b/(b+d)) (c/(a+c)) - (d/(b+d))];
    
    attributableRiskStandardError = attributable_risk_standard_error(a, b, c, d);
    
    attributableRiskConfidenceIntervalsLower = attributableRisk - (1.96 * attributableRiskStandardError);
    
    attributableRiskConfidenceIntervalsUpper = attributableRisk + (1.96 * attributableRiskStandardError);
    
    
    
    propertyStr{1,1} = {propertyStr2, propertyStr1};
    
    propertyStr{1,2} = {strcat('NOT_',propertyStr2), propertyStr1};
    
    
    propertyStr{2,1} = {propertyStr1, propertyStr2};
    
    propertyStr{2,2} = {strcat('NOT_',propertyStr1), propertyStr2};
    
    
    for i = 1:2
        
        for j = 1:2
            
            propertyStrB = char(propertyStr{i,j}{1});
            
            propertyStrA = char(propertyStr{i,j}{2});
            
            if (attributableRisk(i,j) > 0)
                
                adverb = 'more';
              
            else
                
                adverb = 'fewer';
                
            end
            
            if (attributableRisk(i,j) == 0)
                
                strng = sprintf('The probability of types having %s is equal for both %s and NOT_%s types.', propertyStrB, propertyStrA, propertyStrA);
                
            elseif (abs(attributableRisk(i,j)) <= 0.1)
                
                strng = sprintf('The probability of types having %s is nearly equal (%.2f) for both %s and NOT_%s types.', propertyStrB, attributableRisk(i,j), propertyStrA, propertyStrA);
                
            else
                
                strng = sprintf('Out of every 100 types having %s on average %d %s are likely to have %s.', propertyStrB, round(100*abs(attributableRisk(i,j))), adverb, propertyStrA);
                
            end
            
            strng = sprintf('%s The 95%% Confidence Interval is %.3f < %.3f < %.3f.', strng, attributableRiskConfidenceIntervalsLower(i,j), attributableRisk(i,j), attributableRiskConfidenceIntervalsUpper(i,j));
            
            if ((attributableRiskConfidenceIntervalsLower(i,j) < 0) && (0 < attributableRiskConfidenceIntervalsUpper(i,j)))
                
                strng = sprintf('%s Since this interval includes 0 there is not significant evidence to suggest an increased chance of %s for %s over NOT_%s.', strng, propertyStrB, propertyStrA, propertyStrA);
            
            else
                
                strng = sprintf('%s Since this interval does not include 0 there is significant evidence to suggest an increased chance of %s for %s over NOT_%s.', strng, propertyStrB, propertyStrA, propertyStrA);

            end
            
            arAutoInterpStrs{i,j} = strng;
            
        end % for j
        
    end % for i
    
end % attributable_risk