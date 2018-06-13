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


fid = fopen('pairwise_mid-p_values.csv', 'w');  % initialize file for saving pValues

fprintf(fid, 'A,B,mid-p,significance,A AND B,A AND notB,notA AND B,notA AND notB,sum,\n');  % print column headers to the file


for i = 1:nProperties % ALLPROPERTIES  % AXONS:DENDRITES:SOMATA:MARKERS:EPHYS
    
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
        
        midP(i,j) = FisherExtest_midP([a(i,j) b(i,j); c(i,j) d(i,j)], 'ne');
        
        Barnardextest(a,b,c,d)
        
        significanceStr = '';
        
        if (midP(i,j) <= 0.001)
            
            significanceStr = '***';
            
        elseif (midP(i,j) <= 0.01)
            
            significanceStr = '**';
            
        elseif (midP(i,j) <= 0.05)
            
            significanceStr = '*';
            
        end
    
    
        % save corrected pValues to a file
        %
        fprintf(fid, '%s,%s,%.16f,%s,%d,%d,%d,%d,%d\n', ...
            propertyNames{i}, propertyNames{j}, midP(i,j), significanceStr, a(i,j), b(i,j), c(i,j), d(i,j), n(i,j));
        
    end % for j
    
end % for i


fclose(fid);  % close pValues file

clean_exit();

end % pairwise_correlations()

