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

pValues = ones(nProperties, nProperties);  % initialize pValue matrix

nStatTests = 0;  % initialize the total number of statistical tests to be performed


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 x 2 Contingency Table
% -----------------------------------------------
% | Observed counts | posCategory | negCategory |
% -----------------------------------------------
% | posGroup        |      a      |      b      | 
% -----------------------------------------------
% | negGroup        |      c      |      d      | 
% -----------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = zeros(nProperties, nProperties);
b = zeros(nProperties, nProperties);
c = zeros(nProperties, nProperties);
d = zeros(nProperties, nProperties);

for i = ALLPROPERTIES  % AXONS:DENDRITES:SOMATA:MARKERS:EPHYS
    
    for j = ALLPROPERTIES(i+1:end)  % avoid self correlations
        
        % morphology values are '0'/'1' (do not / do exist in a given layer
        % marker values are 'n'/'p' and '-' if neither (negative / positive expression)
        % ephys values are 'L'/'H' and '-' if neither (low / high values)
        %
        posGroup = (pairCorrProperties(:,i) == '1') | (pairCorrProperties(:,i) == 'p') | (pairCorrProperties(:,i) == 'H');
        
        negGroup = (pairCorrProperties(:,i) == '0') | (pairCorrProperties(:,i) == 'n') | (pairCorrProperties(:,i) == 'L');
        
        posCategory = (pairCorrProperties(:,j) == '1') | (pairCorrProperties(:,j) == 'p') | (pairCorrProperties(:,i) == 'H');
        
        negCategory = (pairCorrProperties(:,j) == '0') | (pairCorrProperties(:,j) == 'n') | (pairCorrProperties(:,i) == 'L');
        
        
        % Find and count the number of overlaps between group and property combinations
        % 
        a(i,j) = length(find(posGroup .* posCategory == 1));
        
        b(i,j) = length(find(posGroup .* negCategory == 1));
        
        c(i,j) = length(find(negGroup .* posCategory == 1));
        
        d(i,j) = length(find(negGroup .* negCategory == 1));
        
        
        [Pneg, Ppos, Pboth] = fisherextest(a(i,j), b(i,j), c(i,j), d(i,j));
        
        pValues(i,j) = Pboth;  % We are interested in any extreme values so use two-tailed results
        
        nStatTests = nStatTests + 1;  % increment counter the total number of statistical tests to be performed
        
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

fprintf(fid, 'Group,Category,uncorrect p,corrected p,significance,posGroup&posCategory,posGroup&negCategory,negGroup&posCategory,negGroup&negcategory\n');  % print column headers to the file


for i = 1:nTests

    pValuesReshaped = reshape(pValues, nProperties*nProperties, 1);  % reshape square matrix into a linear array

    [pValueMin, idxMin] = min(pValuesReshaped);  % find the index to the smallest pValue
    
    
    % find the group (i.e. property type) that corresponds to the smallest pValue
    % mod() yields the remainder from dividing idxMin by nProperties
    % the remainder corresponds to a row number in the original pValues matrix
    %
    groupMin = mod(idxMin, nProperties);

    % special case when the group corresponds to the last row of the pValues matrix
    %
    if (groupMin == 0)
        
        groupMin = nProperties;
        
    end
    
    
    % find the category (i.e. property type) that corresponds to the smallest pValue
    % ceil() yields the rounded-up quotient from dividing idxMin by nProperties
    % the rounded-up quotient corresponds to a column number in the original pValues matrix
    %
    categoryMin = ceil(idxMin / nProperties);
    
    
    pValuesFdrCorrected(groupMin, categoryMin) = pValuesFdrCorrected(groupMin, categoryMin) * nStatTests;  % false discovery rate correction
    
    nStatTests = nStatTests - 1;  % decrement statistical test counter according to false discovery rate correction
      
    
    significanceStr = '';
    
    if (pValuesFdrCorrected(groupMin, categoryMin) <= 0.001)
        
        significanceStr = '***';
    
    elseif (pValuesFdrCorrected(groupMin, categoryMin) <= 0.01)
    
        significanceStr = '**';
    
    elseif (pValuesFdrCorrected(groupMin, categoryMin) <= 0.05)

        significanceStr = '*';
    
    end

    % display corrected pValues to the screen
    %
    strng = sprintf('%s vs %s: p = %.6e, pCorrected = %.6e%s\n', ...
        propertyNames{groupMin}, propertyNames{categoryMin}, ...
        pValues(groupMin, categoryMin), pValuesFdrCorrected(groupMin, categoryMin), significanceStr);
    
    disp(strng);
    
    
    % save corrected pValues to a file
    %
    fprintf(fid, '%s,%s,%.6e,%.6e,%s,%d,%d,%d,%d\n', ...
        propertyNames{groupMin}, propertyNames{categoryMin}, ...
        pValues(groupMin, categoryMin), pValuesFdrCorrected(groupMin, categoryMin), significanceStr, ...
        a(groupMin, categoryMin), b(groupMin, categoryMin), c(groupMin, categoryMin), d(groupMin, categoryMin));

    
    pValues(groupMin, categoryMin) = pValues(groupMin, categoryMin) + 100;  % ensure that this pValue is no longer the smallest in the next loop interation
    
end % for i

fclose(fid);  % close pValues file

clean_exit();

end % pairwise_correlations()

