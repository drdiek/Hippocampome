function pairwise_correlations_Barnard()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

clear all;

path(path,'./diek_lib/');

nTypeIds = 40;
nProperties = 202; % morphology and markers
% nProperties = 150; % without firing patterns
% nProperties = 239; % with firing patterns

    
% load all properties for all neuronal types: nTypes x nProperties
%
[properties, typeIds, nTypeIds, typeNames, propertyNames] = load_contingency_matrices_properties(nTypeIds, nProperties);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 x 2 Contingency Table
% -----------------------------------
% | Observed counts |   B   | NOT B |
% -----------------------------------
% |               A |   a   |   b   | 
% -----------------------------------
% |           NOT A |   c   |   d   | 
% -----------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = zeros(nProperties, nProperties);
b = zeros(nProperties, nProperties);
c = zeros(nProperties, nProperties);
d = zeros(nProperties, nProperties);
n = zeros(nProperties, nProperties);

posVerbStr = {'are'; 'have'; 'are positive for'; 'have high values for'; ...
              'are always'; 'always have'; 'are always positive for'; 'always have high values for'; ...
              'are almost always'; 'almost always have'; 'are almost always positive for'; 'almost always have high values for'};

negVerbStr = {'are not'; 'do not have'; 'are negative for'; 'have low values for';
              'are never'; 'never have'; 'are always negative for'; 'always have low values for'; ...
              'are almost never'; 'almost never have'; 'are almost always negative for'; 'almost always have low values for'};


posAdverbStr = {'always'};

negAdverbStr = {'never'};

outputFileName = sprintf('Barnard_values_%s.csv', datestr(now, 'yyyymmddHHMMSS'));
    
fid = fopen(outputFileName, 'w');  % initialize file for saving pValues

strng = sprintf('A,B,A AND B,A AND notB,notA AND B,notA AND notB,Sum,Interesting?');

strng = sprintf('%s,chi2-P value,Significance,mid-P value,Significance', strng);

strng = sprintf('%s,Barnard-P value,Significance,Auto-Interpretation', strng);

strng = sprintf('%s,RR of B for A,Auto-Interpretation,RR of notB for A,Auto-Interpretation', strng);

strng = sprintf('%s,RR of A for B,Auto-Interpretation,RR of A for notB,Auto-Interpretation', strng);

strng = sprintf('%s,AR of B for A,Auto-Interpretation,AR of notB for A,Auto-Interpretation', strng);

strng = sprintf('%s,AR of A for B,Auto-Interpretation,AR of A for notB,Auto-Interpretation', strng);

strng = sprintf('%s,OR of B for A,Auto-Interpretation,OR of notB for A,Auto-Interpretation', strng);

strng = sprintf('%s,OR of A for B,Auto-Interpretation,OR of A for notB,Auto-Interpretation', strng);

fprintf(fid, '%s\n', strng);  % print column headers to the file

% fileName = 'contingency_matrices_values.xlsx';
% 
% headers = {'A'; 'B'; 'A AND B'; 'A AND notB'; 'notA AND B'; 'notA AND notB'; 'Sum'; 'Interesting?'; 'Auto-Interpretation'};
% 
% xlswrite(fileName, headers);

for i = 1:nProperties
    
    for j = i+1:nProperties
        
        % morphology values are '0'/'1' (do not / do exist in a given layer
        % marker values are 'n'/'p' and '-' if neither (negative / positive expression)
        % ephys values are 'L'/'H' and '-' if neither (low / high values)
        %
        A = (properties(:,i) == '1') | (properties(:,i) == 'p') | (properties(:,i) == 'H');
        
        notA = (properties(:,i) == '0') | (properties(:,i) == 'n') | (properties(:,i) == 'L');
        
        B = (properties(:,j) == '1') | (properties(:,j) == 'p') | (properties(:,j) == 'H');
        
        notB = (properties(:,j) == '0') | (properties(:,j) == 'n') | (properties(:,j) == 'L');
        
        
        % Find and count the number of overlaps between group and property combinations
        % 
        a = length(find(A .* B == 1));
        
        b = length(find(A .* notB == 1));
        
        c = length(find(notA .* B == 1));
        
        d = length(find(notA .* notB == 1));
        
        contingencyMatrix = [a b; c d];
        
        n = a + b + c + d;

%         tic
%         Barnardextest(a,b,c,d)
%         toc
        
        stats = mybarnard([a b; c d]);
        
        barnardP = stats.p_value;
        
        significanceStrBarnardP = '';
        
        if (barnardP <= 0.001)
            
            significanceStrBarnardP = '***';
            
        elseif (barnardP <= 0.01)
            
            significanceStrBarnardP = '**';
            
        elseif (barnardP <= 0.05)
            
            significanceStrBarnardP = '*';
            
        end
    
    
        midP = FisherExtest_midP(contingencyMatrix, 'ne');
        
        significanceStrMidP = '';
        
        if (midP <= 0.001)
            
            significanceStrMidP = '***';
            
        elseif (midP <= 0.01)
            
            significanceStrMidP = '**';
            
        elseif (midP <= 0.05)
            
            significanceStrMidP = '*';
            
        end
    
    
        if ((n >= 20) && all(all(contingencyMatrix>5)))
            
            [chi2P,x2] = chisquarecont(contingencyMatrix);
            
        else
            
            chi2P = NaN;
        
        end
        
        significanceStrChi2P = '';
        
        if (chi2P <= 0.001)
            
            significanceStrChi2P = '***';
            
        elseif (chi2P <= 0.01)
            
            significanceStrChi2P = '**';
            
        elseif (chi2P <= 0.05)
            
            significanceStrChi2P = '*';
            
        end
    
    
        [relativeRisk, rrAutoInterpStrs] = relative_risk(contingencyMatrix, propertyNames(i), propertyNames(j));
        
        
        [attributableRisk, arAutoInterpStrs] = attributable_risk(contingencyMatrix, propertyNames(i), propertyNames(j));
        
        
        if (find([a b c d] == 0))
            
            oddsRatio = [NaN NaN; NaN NaN];
            
            orAutoInterpStrs = {'' ''; '' ''};
            
        else
            
            [oddsRatio, orAutoInterpStrs] = odds_ratio(contingencyMatrix, propertyNames(i), propertyNames(j));
        
        end
        
        
        iVerb = check_property_type(i);

        jVerb = check_property_type(j);

        iiVerb = iVerb + 4;
        
        jjVerb = jVerb + 4;
                
        iiiVerb = iiVerb + 4;
        
        jjjVerb = jjVerb + 4;
        
        
                
        isInteresting = 1;
        
        if (n == 0)
            
            isInteresting = -3;
        
        elseif (n == 1)
            
            isInteresting = -2;
        
        elseif (n == 2)
            
            isInteresting = -1;
        
        elseif (((iVerb == 1) || (jVerb == 1)) && ((iVerb == 4) || (jVerb == 4))) % glut/proj and ephys
            
            isInteresting = 8;
            
        elseif (((iVerb == 2) || (jVerb == 2)) && ((iVerb == 4) || (jVerb == 4))) % morph and ephys
            
            isInteresting = 7;
            
        elseif (((iVerb == 1) || (jVerb == 1)) && ((iVerb == 3) || (jVerb == 3))) % glut/proj and marker
            
            isInteresting = 6;
            
        elseif (((iVerb == 2) || (jVerb == 2)) && ((iVerb == 3) || (jVerb == 3))) % morph and marker
            
            isInteresting = 5;
            
        elseif (((iVerb == 3) || (jVerb == 3)) && ((iVerb == 4) || (jVerb == 4))) % marker and ephys
            
            isInteresting = 4;
            
        elseif ((iVerb == 4) && (jVerb == 4)) % ephys and ephys
            
            isInteresting = 3;
            
        elseif ((iVerb == 3) && (jVerb == 3)) % marker and marker
            
            isInteresting = 2;
            
        elseif ((iVerb == 1) && (jVerb == 1)) % glut/proj and glut/proj
            
            isInteresting = 1;
            
        elseif ((iVerb == 2) && (jVerb == 2)) % morph and morph
            
            isInteresting = 0;
            
        end
        
        
        autoInterpretationStr = ' ';

        if ((b == 0) && (c == 0) && (d == 0) && (a > 0))
            
            autoInterpretationStr = sprintf('Only types exist that %s %s and %s %s', posVerbStr{iVerb,1}, propertyNames{i}, posVerbStr{jVerb,1}, propertyNames{j});

        elseif ((a == 0) && (c == 0) && (d == 0) && (b > 0))
            
            autoInterpretationStr = sprintf('Only types exist that %s %s and %s %s', posVerbStr{iVerb,1}, propertyNames{i}, negVerbStr{jVerb,1}, propertyNames{j});

        elseif ((a == 0) && (b == 0) && (d == 0) && (c > 0))
            
            autoInterpretationStr = sprintf('Only types exist that %s %s and %s %s', negVerbStr{iVerb,1}, propertyNames{i}, posVerbStr{jVerb,1}, propertyNames{j});

        elseif ((a == 0) && (b == 0) && (c == 0) && (d > 0))
            
            autoInterpretationStr = sprintf('Only types exist that %s %s and %s %s', negVerbStr{iVerb,1}, propertyNames{i}, negVerbStr{jVerb,1}, propertyNames{j});

            
        elseif ((a == 0) && (b*c*d) > 0)
            
            autoInterpretationStr = sprintf('No types exist that %s %s and %s %s', posVerbStr{iVerb,1}, propertyNames{i}, posVerbStr{jVerb,1}, propertyNames{j});

        elseif ((b == 0) && (a*c*d) > 0)
            
            autoInterpretationStr = sprintf('No types exist that %s %s and %s %s', posVerbStr{iVerb,1}, propertyNames{i}, negVerbStr{jVerb,1}, propertyNames{j});

        elseif ((c == 0) && (a*b*d) > 0)
            
            autoInterpretationStr = sprintf('No types exist that %s %s and %s %s', negVerbStr{iVerb,1}, propertyNames{i}, posVerbStr{jVerb,1}, propertyNames{j});

        elseif ((d == 0) && (a*b*c) > 0)
            
            autoInterpretationStr = sprintf('No types exist that %s %s and %s %s', negVerbStr{iVerb,1}, propertyNames{i}, negVerbStr{jVerb,1}, propertyNames{j});

            
        elseif ((a <= 2) && (b > 2) && (c > 2) && (d > 2))
            
            autoInterpretationStr = sprintf('Only %d out of %d types exist that %s %s and %s %s', a, n, posVerbStr{iVerb,1}, propertyNames{i}, posVerbStr{jVerb,1}, propertyNames{j});

        elseif ((b <= 2) && (a > 2) && (c > 2) && (d > 2))
            
            autoInterpretationStr = sprintf('Only %d out of %d types exist that %s %s and %s %s', b, n, posVerbStr{iVerb,1}, propertyNames{i}, negVerbStr{jVerb,1}, propertyNames{j});

        elseif ((c <= 2) && (a > 2) && (b > 2) && (d > 2))
            
            autoInterpretationStr = sprintf('Only %d out of %d types exist that %s %s and %s %s', c, n, negVerbStr{iVerb,1}, propertyNames{i}, posVerbStr{jVerb,1}, propertyNames{j});

        elseif ((d <= 2) && (a > 2) && (b > 2) && (c > 2))
            
            autoInterpretationStr = sprintf('Only %d out of %d types exist that %s %s and %s %s', d, n, negVerbStr{iVerb,1}, propertyNames{i}, negVerbStr{jVerb,1}, propertyNames{j});

            
        elseif ((a + b == 0) && (c*d) > 0)
            
            autoInterpretationStr = sprintf('Types for which we have information about %s %s %s', propertyNames{j}, negVerbStr{iiVerb,1}, propertyNames{i});

        elseif ((c + d == 0) && (a*b) > 0)
            
            autoInterpretationStr = sprintf('Types for which we have information about %s %s %s', propertyNames{j}, posVerbStr{iiVerb,1}, propertyNames{i});

        elseif ((a + c == 0) && (b*d) > 0)
            
            autoInterpretationStr = sprintf('Types for which we have information about %s %s %s', propertyNames{i}, negVerbStr{jjVerb,1}, propertyNames{j});
            
        elseif ((b + d == 0) && (a*c) > 0)
            
            autoInterpretationStr = sprintf('Types for which we have information about %s %s %s', propertyNames{i}, posVerbStr{jjVerb,1}, propertyNames{j});

            
        elseif ((a <= 2) && (b <= 2) && (c > 2) && (d > 2))
            
            autoInterpretationStr = sprintf('Types for which we have information about %s %s %s', propertyNames{j}, negVerbStr{iiiVerb,1}, propertyNames{i});

        elseif ((c <= 2) && (d <= 2) && (a > 2) && (b > 2))
            
            autoInterpretationStr = sprintf('Types for which we have information about %s %s %s', propertyNames{j}, posVerbStr{iiiVerb,1}, propertyNames{i});

        elseif ((a <= 2) && (c <= 2) && (b > 2) && (d > 2))
            
            autoInterpretationStr = sprintf('Types for which we have information about %s %s %s', propertyNames{i}, negVerbStr{jjjVerb,1}, propertyNames{j});
            
        elseif ((b <= 2) && (d <= 2) && (a > 2) && (c > 2))
            
            autoInterpretationStr = sprintf('Types for which we have information about %s %s %s', propertyNames{i}, posVerbStr{jjjVerb,1}, propertyNames{j});

        end
        
        
        idx = strfind(autoInterpretationStr, 'not Glutamatergic');
        
        if ~isempty(idx)
            
            for ii = 1:length(idx)
            
                autoInterpretationStr = sprintf('%sGABA%s', autoInterpretationStr(1:idx-1), autoInterpretationStr(idx+12:end));
                
            end % for ii
            
        end % if
            
        idx = [];
        idx = strfind(autoInterpretationStr, 'about Glutamatergic');
        
        if ~isempty(idx)
            
            for ii = 1:length(idx)
            
                autoInterpretationStr = sprintf('%sthe major neurotransmitter%s', autoInterpretationStr(1:idx+5), autoInterpretationStr(idx+19:end));
                
            end % for ii
            
        end % if
            
        
        idx = [];
        idx = strfind(autoInterpretationStr, 'about Projecting');
        
        if ~isempty(idx)
            
            for ii = 1:length(idx)
            
                autoInterpretationStr = sprintf('%sthe projecting status%s', autoInterpretationStr(1:idx+5), autoInterpretationStr(idx+16:end));
                
            end % for ii
            
        end % if
            

        if ((a < 10) && (b < 10) && (c < 10) && (d < 10))
            
            isInteresting = isInteresting - 0.5;
            
            autoInterpretationStr = sprintf('LOW VALUES! %s', autoInterpretationStr);
            
        end
        
        if (n == 0)
            
            autoInterpretationStr = sprintf('ZEROS!!');
            
        end
        
        
        % save corrected pValues to a file
        %
        if (mod(isInteresting,1))
        
            strng = sprintf('%s,%s,%d,%d,%d,%d,%d,%d,%.16f,%s,%.16f,%s,%.16f,%s,%s', ...
                propertyNames{i}, propertyNames{j}, a, b, c, d, n, isInteresting, chi2P, significanceStrChi2P, midP, significanceStrMidP, barnardP, significanceStrBarnardP, autoInterpretationStr);
        
        else
            
            strng = sprintf('%s,%s,%d,%d,%d,%d,%d,%.1f,%.16f,%s,%.16f,%s,%.16f,%s,%s', ...
                propertyNames{i}, propertyNames{j}, a, b, c, d, n, isInteresting, chi2P, significanceStrChi2P, midP, significanceStrMidP, barnardP, significanceStrBarnardP, autoInterpretationStr);
        
        end
        
        for ii = 1:2
            
            for jj = 1:2
        
                strng = sprintf('%s,%.2f,%s', strng, relativeRisk(ii,jj), rrAutoInterpStrs{ii,jj});
                
            end % for jj
            
        end % for ii
        
        for ii = 1:2
            
            for jj = 1:2
        
                strng = sprintf('%s,%.2f,%s', strng, attributableRisk(ii,jj), arAutoInterpStrs{ii,jj});
                
            end % for jj
            
        end % for ii
        
        for ii = 1:2
            
            for jj = 1:2
        
                strng = sprintf('%s,%.2f,%s', strng, oddsRatio(ii,jj), orAutoInterpStrs{ii,jj});
                
            end % for jj
            
        end % for ii
        
        fprintf(fid, '%s\n', strng);

%     data = {propertyNames{i}, propertyNames{j}, a, b, c, d, n, isInteresting, autoInterpretationStr};
% 
%     xlswrite(fileName, data);
    
    end % for j
    
end % for i


fclose(fid);  % close pValues file

clean_exit();

end % contingency_matrices()

