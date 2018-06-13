function [ output_args ] = pairwise_correlations()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

clear all;

path(path,'./diek_lib/');

save_pairwise_correlations_defs();  % define global variables

load pairwise_correlations_defs.mat;  % load global variables

% load all properties for all neuronal types: nTypes x nProperties
%
[pairCorrProperties, typeIds, nTypeIds, typeNames, propertyNames] = load_pairwise_correlations_properties();

pValues = 1000*ones(nProperties, nProperties);  % initialize pValue matrix

nStatTests = 0;  % initialize the total number of statistical tests to be performed


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

probAorB = zeros(nProperties, nProperties);
probAorNotB = zeros(nProperties, nProperties);
probNotAorB = zeros(nProperties, nProperties);
probNotAorNotB = zeros(nProperties, nProperties);

for i = nProperties % ALLPROPERTIES  % AXONS:DENDRITES:SOMATA:MARKERS:EPHYS
    
    for j = i+1:nProperties % ALLPROPERTIES(i+1:end)  % avoid self correlations
        
        % morphology values are '0'/'1' (do not / do exist in a given layer
        % marker values are 'n'/'p' and '-' if neither (negative / positive expression)
        % ephys values are 'L'/'H' and '-' if neither (low / high values)
        %
        A = (pairCorrProperties(:,i) == '1') | (pairCorrProperties(:,i) == 'p') | (pairCorrProperties(:,i) == 'H');
        
        notA = (pairCorrProperties(:,i) == '0') | (pairCorrProperties(:,i) == 'n') | (pairCorrProperties(:,i) == 'L');
        
        B = (pairCorrProperties(:,j) == '1') | (pairCorrProperties(:,j) == 'p') | (pairCorrProperties(:,j) == 'H');
        
        notB = (pairCorrProperties(:,j) == '0') | (pairCorrProperties(:,j) == 'n') | (pairCorrProperties(:,j) == 'L');
        
        
        % Find and count the number of overlaps between group and property combinations
        % 
        a(i,j) = length(find(A .* B == 1));
        
        b(i,j) = length(find(A .* notB == 1));
        
        c(i,j) = length(find(notA .* B == 1));
        
        d(i,j) = length(find(notA .* notB == 1));
        
        n(i,j) = a(i,j) + b(i,j) + c(i,j) + d(i,j);
        
        if ((a(i,j) * b(i,j) * c(i,j) * d(i,j)) > 0)  % only run stat test if all values are non-zero
        
%         if ((a(i,j)+b(i,j) > 1) && (c(i,j)+d(i,j) > 1) && (a(i,j)+c(i,j) > 1) && (b(i,j)+d(i,j) > 1))
            
            aa(nStatTests+1) = a(i,j);
            bb(nStatTests+1) = b(i,j);
            cc(nStatTests+1) = c(i,j);
            dd(nStatTests+1) = d(i,j);
            nn(nStatTests+1) = n(i,j);
            prodABCD(nStatTests+1) = aa(nStatTests+1) * bb(nStatTests+1) * cc(nStatTests+1) * dd(nStatTests+1);
            
            holdYourHorses = 0;
            
            for kk = 1:nStatTests
                
                if ((nn(nStatTests+1) == nn(kk)) && (prodABCD(nStatTests+1) == prodABCD(kk)))
                
%                 if ((aa(nStatTests+1) == aa(kk)) && (bb(nStatTests+1) == bb(kk)) && (cc(nStatTests+1) == c(kk))  && (dd(nStatTests+1) == d(kk)))
                    
                    holdyourHorses = 1;
                    
                end % if
                
            end % for kk
            
            
%             pValues(i,j) = 1000;
%             
%         else

            if ~holdYourHorses
        
                [Pneg, Ppos, Pboth] = fisherextest(a(i,j), b(i,j), c(i,j), d(i,j));
                
                pValues(i,j) = Pboth;  % We are interested in any extreme values so use two-tailed results
                
                nStatTests = nStatTests + 1;  % increment counter the total number of statistical tests to be performed
                
                
                [probAorB(i,j), probAorNotB(i,j), probNotAorB(i,j), probNotAorNotB(i,j)] = prob_A_or_B(a(i,j), b(i,j), c(i,j), d(i,j));
        
            end % if ~holdYourHorse
                
        end % if ((a(i,j)+b(i,j) == 0) | (c(i,j)+d(i,j) == 0) | (a(i,j)+c(i,j) == 0) | (b(i,j)+d(i,j) == 0))
            
    end % for j
    
end % for i


if (nStatTests == 0)
    
    disp(' ');
    disp('No statistical tests have been performed.');
    disp(' ');
    return;
    
end


pValuesFdrCorrected = pValues;  % FDR = false discovery rate

nTests = nStatTests;  % establish parameter for looping


fid = fopen('pairwise_p_values.csv', 'w');  % initialize file for saving pValues

fprintf(fid, 'A,B,uncorrect p,corrected p,significance,A AND B,A AND notB,notA AND B,notA AND notB,sum,P(A OR B),P(A OR notB),P(notA OR B),P(notA OR notB)\n');  % print column headers to the file


[pValuesReshapedMin, idxMin] = sort(reshape(pValues, nProperties*nProperties, 1));  % reshape square matrix into a linear array

% ffid = fopen('z.txt', 'w');
% fprintf(ffid,'%.6e\t', pValuesReshaped);
% fclose(ffid);
% pause


% [pValuesReshapedMin, idxMin] = sort(pValuesReshaped);

aMin = mod(idxMin, nProperties);

idx = find(aMin == 0);

aMin(idx) = nProperties;

bMin = ceil(idxMin / nProperties);

for i = 1:nTests

%     [pValueMin, idxMin] = min(pValuesReshaped);  % find the index to the smallest pValue
    
    
    % find the group (i.e. property type) that corresponds to the smallest pValue
    % mod() yields the remainder from dividing idxMin by nProperties
    % the remainder corresponds to a row number in the original pValues matrix
    %
%     aMin = mod(idxMin(i), nProperties);

    % special case when the group corresponds to the last row of the pValues matrix
    %
%     if (aMin == 0)
%         
%         aMin = nProperties;
%         
%     end
    
    
    % find the category (i.e. property type) that corresponds to the smallest pValue
    % ceil() yields the rounded-up quotient from dividing idxMin by nProperties
    % the rounded-up quotient corresponds to a column number in the original pValues matrix
    %
%     bMin = ceil(idxMin(i) / nProperties);
    
    
    pValuesFdrCorrected(aMin(i), bMin(i)) = pValuesFdrCorrected(aMin(i), bMin(i)) * nStatTests;  % false discovery rate correction
    
    nStatTests = nStatTests - 1;  % decrement statistical test counter according to false discovery rate correction
      
    
    significanceStr = '';
    
    if (pValuesFdrCorrected(aMin(i), bMin(i)) <= 0.001)
        
        significanceStr = '***';
    
    elseif (pValuesFdrCorrected(aMin(i), bMin(i)) <= 0.01)
    
        significanceStr = '**';
    
    elseif (pValuesFdrCorrected(aMin(i), bMin(i)) <= 0.05)

        significanceStr = '*';
    
    end

%     % display corrected pValues to the screen
%     %
%     strng = sprintf('%s vs %s: p = %.6e, pCorrected = %.6e%s\n', ...
%         propertyNames{aMin}, propertyNames{bMin}, ...
%         pValues(aMin, bMin), pValuesFdrCorrected(aMin, bMin), significanceStr);
%     
%     disp(strng);
    
    
    % save corrected pValues to a file
    %
    fprintf(fid, '%s,%s,%.6e,%.6e,%s,%d,%d,%d,%d,%d,%.2f,%.2f,%.2f,%.2f\n', ...
        propertyNames{aMin(i)}, propertyNames{bMin(i)}, ...
        pValues(aMin(i), bMin(i)), pValuesFdrCorrected(aMin(i), bMin(i)), significanceStr, ...
        a(aMin(i), bMin(i)), b(aMin(i), bMin(i)), c(aMin(i), bMin(i)), d(aMin(i), bMin(i)), n(aMin(i), bMin(i)), ...
        probAorB(aMin(i), bMin(i)), probAorNotB(aMin(i), bMin(i)), probNotAorB(aMin(i), bMin(i)), probNotAorNotB(aMin(i), bMin(i)));

    
%     pValues(aMin(i), bMin(i)) = pValues(aMin(i), bMin(i)) + 100;  % ensure that this pValue is no longer the smallest in the next loop interation
    
end % for i

fclose(fid);  % close pValues file

clean_exit();

end % pairwise_correlations()

