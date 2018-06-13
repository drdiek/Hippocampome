function [oddsRatio, orAutoInterpStrs] = odds_ratio(contingencyMatrix, propertyStr1, propertyStr2)

    a = contingencyMatrix(1,1);

    b = contingencyMatrix(1,2);

    c = contingencyMatrix(2,1);
    
    d = contingencyMatrix(2,2);
    
    
    oddsRatio = [((a/b) / (c/d)) ((b/a) / (d/c)); ...
                 ((a/c) / (b/d)) ((c/a) / (d/b))];
    
    oddsRatioStandardError = relative_risk_standard_error(a, b, c, d);
    
    oddsRatioConfidenceIntervalsLower = exp(log(oddsRatio) - (1.96 * oddsRatioStandardError));
    
    oddsRatioConfidenceIntervalsUpper = exp(log(oddsRatio) + (1.96 * oddsRatioStandardError));
    
    
    propertyStr{1,1} = {propertyStr2, propertyStr1};
    
    propertyStr{1,2} = {strcat('NOT_',propertyStr2), propertyStr1};
    
    
    propertyStr{2,1} = {propertyStr1, propertyStr2};
    
    propertyStr{2,2} = {strcat('NOT_',propertyStr1), propertyStr2};
    
    
    for i = 1:2
        
        for j = 1:2
            
            propertyStrB = char(propertyStr{i,j}{1});
            
            propertyStrA = char(propertyStr{i,j}{2});
            
            if (oddsRatio(i,j) > 1)
                
                adverb = 'larger';
              
            else
                
                adverb = 'smaller';
                
            end
            
            if (oddsRatio(i,j) == 1)
                
                strng = sprintf('The probability of types having %s is equal for both %s and NOT_%s types.', propertyStrB, propertyStrA, propertyStrA);
                
            elseif (abs(oddsRatio(i,j)) <= 0.1)
                
                strng = sprintf('The probability of types having %s is nearly equal (%.2f) for both %s and NOT_%s types.', propertyStrB, oddsRatio(i,j), propertyStrA, propertyStrA);
                
            else
                
                strng = sprintf('For types having %s the odds of having %s is %.2f times %s than of having NOT_%s.', propertyStrB, propertyStrA, oddsRatio(i,j), adverb, propertyStrA);
                
            end
            
            strng = sprintf('%s The 95%% Confidence Interval is %.3f < %.3f < %.3f.', strng, oddsRatioConfidenceIntervalsLower(i,j), oddsRatio(i,j), oddsRatioConfidenceIntervalsUpper(i,j));
            
            if ((oddsRatioConfidenceIntervalsLower(i,j) < 1) && (1 < oddsRatioConfidenceIntervalsUpper(i,j)))
                
                strng = sprintf('%s Since this interval includes 1 there is not significant evidence to suggest an increased chance of %s for %s over NOT_%s.', strng, propertyStrB, propertyStrA, propertyStrA);
            
            else
                
                strng = sprintf('%s Since this interval does not include 1 there is significant evidence to suggest an increased chance of %s for %s over NOT_%s.', strng, propertyStrB, propertyStrA, propertyStrA);

            end
            
            orAutoInterpStrs{i,j} = strng;
            
        end % for j
        
    end % for i
    
end % attributable_risk