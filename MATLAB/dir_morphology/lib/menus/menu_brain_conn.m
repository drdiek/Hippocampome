function [reply] = menu_brain_conn(csvFileName)
% modified 20100917 by Diek W. Wheeler, Ph.D

    load adPCLtoggles
    load Cij.mat
    load CellCounts.mat
    
    computedText = ['uncomputed';
                    'computed  '];

    isBetweennessComputed = 0; 
    areClusteringCoefficientsComputed = 0;
    areDegreesComputed = 0;
    areDistancesComputed = 0;
    isEdgeBetweennessComputed = 0;
    isGlobalEfficiencyComputed = 0;    
    isLocalEfficiencyComputed = 0;
    isExcitRangeComputed = 0;
    isInhibRangeComputed = 0;
    areJointDegreesComputed = 0;
    areStrengthsComputed = 0;

    CijAssortativity = [];
    CijConnectionDensity = [];
    CijNVertices = [];
    CijNEdges = [];
    CijExcitAverageRange = [];
    CijInhibAverageRange = [];
    CijExcitFractionOfShortcuts = [];
    CijInhibFractionOfShortcuts = [];
    CijNVerticesOdGtId = [];
    CijNVerticesIdGtOd = [];
    CijNVerticesIdEqOd = [];
    
    baseFileName = 'parcel';
    
    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Current csv file is: %s\n', csvFileName);
        disp(strng);
        strng = sprintf('Including axons/dendrites CONTINUING in PCL? %s', bin2str(togglePCLcontinuing));
        disp(strng);
        strng = sprintf('Including axons/dendrites TERMINATING in PCL? %s\n', bin2str(togglePCLterminating));
        disp(strng);    
        strng = sprintf('Connectivity - BRAIN CONNECTIVITY TOOLBOX MENU\n');
        disp(strng);
        strng = sprintf('Select from the options below:\n');
        disp(strng);
        
        strng = sprintf('    1) Compute # vertices, # edges, connection density {CijNVertices,CijNEdges,CijConnectionDensity}');
        strng = sprintf('%s (%d,%d,%.3f)', strng, CijNVertices,CijNEdges,CijConnectionDensity);
        disp(strng);
        
        strng = sprintf('    2) Compute distances {CijDistances} (');
        strng = sprintf('%s%s)', strng, deblank(computedText(areDistancesComputed+1,:)));            
        disp(strng);        
        
        strng = sprintf('    3) Compute degrees {CijInDegrees,CijOutDegrees,CijAllDegrees} (');
        strng = sprintf('%s%s)', strng, deblank(computedText(areDegreesComputed+1,:)));            
        disp(strng);        
        
        strng = sprintf('    4) Compute strengths {CijInStrengths, CijOutStrengths, CijAllStrengths} (');
        strng = sprintf('%s%s)', strng, deblank(computedText(areStrengthsComputed+1,:)));
        disp(strng);        
        
        strng = sprintf('    5) Compute global efficiency {CijGlobalEfficiency} (');
        strng = sprintf('%s%s)', strng, deblank(computedText(isGlobalEfficiencyComputed+1,:)));            
        disp(strng);

        strng = sprintf('    6) Compute local efficiency {CijLocalEfficiency} (');
        strng = sprintf('%s%s)', strng, deblank(computedText(isLocalEfficiencyComputed+1,:)));            
        disp(strng);        
        
        
        strng = sprintf('    7) Compute assortativity {CijAssortativity}');
        strng = sprintf('%s (%.4f)', strng, CijAssortativity);
        disp(strng);

        strng = sprintf('    8) Compute betweenness {CijBetweenness} (');
        strng = sprintf('%s%s)', strng, deblank(computedText(isBetweennessComputed+1,:)));            
        disp(strng);

        strng = sprintf('    9) Compute clustering coefficients {CijClusteringCoefficients} (');
        strng = sprintf('%s%s)', strng, deblank(computedText(areClusteringCoefficientsComputed+1,:)));            
        disp(strng);

        strng = sprintf('   10) Compute edge and vertex betweenness {CijEdgeBetweenness, CijVertexBetweenness} (');
        strng = sprintf('%s%s)', strng, deblank(computedText(isEdgeBetweennessComputed+1,:)));            
        disp(strng);

        strng = sprintf('   11) Compute joint degrees {CijJointDegrees, CijNVerticesOdGtId, CijNVerticesIdGtOd, CijNVerticesIdEqOd} (');
        strng = sprintf('%s%s,%d,%d,%d)', strng, ...
                        deblank(computedText(areJointDegreesComputed+1,:)), CijNVerticesOdGtId, CijNVerticesIdGtOd, CijNVerticesIdEqOd);
        disp(strng);        
       
        strng = sprintf('   12) Compute range and shortcuts for E synapes {CijRange, CijAverageRange, CijShortcuts, CijFractionOfShortcuts} (');
        strng = sprintf('%s%s,%.4f,%s,%.4f)', strng, deblank(computedText(isExcitRangeComputed+1,:)), CijExcitAverageRange, ...
                        deblank(computedText(isExcitRangeComputed+1,:)), CijExcitFractionOfShortcuts);
        disp(strng);

        strng = sprintf('   13) Compute range and shortcuts for I synapes {CijRange, CijAverageRange, CijShortcuts, CijFractionOfShortcuts} (');
        strng = sprintf('%s%s,%.4f,%s,%.4f)', strng, deblank(computedText(isInhibRangeComputed+1,:)), CijInhibAverageRange, ...
                        deblank(computedText(isInhibRangeComputed+1,:)), CijInhibFractionOfShortcuts);
        disp(strng);

        disp('    d) Define terms');

        
        strng = sprintf('\n    G) Get/set base name output file {baseFileName} (%s)', baseFileName);
        disp(strng);       
        disp('    B) Back to connectivity menu');
        disp('    !) Exit');
        
        
        %% process input %%
        
        reply = lower(input('\nYour selection: ', 's'));

        switch reply               
            case '1'
                fprintf(1, '\nComputing vertices and edge stats ...')
                [CijNVertices,CijNEdges,CijConnectionDensity] = density_dir(CijNonZero);
                
                save_Cij_measure(CijNVertices, baseFileName, 'n-vertices', 0);
                save_Cij_measure(nInhib, baseFileName, 'n-inhib', 0);
                save_Cij_measure(nExcit, baseFileName, 'n-excit', 0);          
                save_Cij_measure(CijNEdges, baseFileName, 'n-allEdges', 0);                
                save_Cij_measure(nInhibEdges, baseFileName, 'n-inhibEdges', 0);
                save_Cij_measure(nExcitEdges, baseFileName, 'n-excitEdges', 0);      
                save_Cij_measure(nSelfEdges, baseFileName, 'n-selfEdges', 0);                                     
                save_Cij_measure(nInhibSelfEdges, baseFileName, 'n-selfInhibEdges', 0);    
                save_Cij_measure(nExcitSelfEdges, baseFileName, 'n-selfExcitEdges', 0);    
                save_Cij_measure(nIIedges, baseFileName, 'n-iiEdges', 0);  
                save_Cij_measure(nEEedges, baseFileName, 'n-eeEdges', 0);  
                save_Cij_measure(CijConnectionDensity, baseFileName, 'connection-density', 4);
                reply = [];            

            case '2'
                fprintf(1, '\nComputing distances ...')
                CijDistances = distance_wei(CijNonZero);
                
                areDistancesComputed = save_Cij_measure(CijDistances, baseFileName, 'distances', 0);
                reply = []; 
                
            case '3'
                fprintf(1, '\nComputing degrees ...')
                [CijInDegrees,CijOutDegrees,CijAllDegrees] = degrees_dir(CijNonZero);
                
                save_Cij_measure(CijInDegrees, baseFileName, 'in-degrees', 0);
                save_Cij_measure(CijOutDegrees, baseFileName, 'out-degrees', 0);
                areDegreesComputed = save_Cij_measure(CijAllDegrees, baseFileName, 'all-degrees', 0);
                reply = [];

            case '4'
                fprintf(1, '\nComputing strengths ...')
                [CijInStrengths, CijOutStrengths, CijAllStrengths] = strengths_dir(Cij);
                
                areStrengthsComputed = save_Cij_measure(CijInStrengths, baseFileName, 'in-strengths', 0);
                save_Cij_measure(CijOutStrengths, baseFileName, 'out-strengths', 0);
                save_Cij_measure(CijAllStrengths, baseFileName, 'all-strengths', 0);
                reply = [];
                
            case '5'
                fprintf(1, '\nComputing global efficiency ...')
                CijGlobalEfficiency = efficiency(CijNonZero);
                CijGlobalEfficiency = mean(CijGlobalEfficiency);
                
                isGlobalEfficiencyComputed = save_Cij_measure(CijGlobalEfficiency, baseFileName, 'global-efficiency', 8);
                reply = [];

            case '6'
                fprintf(1, '\nComputing local efficiency ...')
                CijLocalEfficiency = efficiency(CijNonZero, 1);
                
                isLocalEfficiencyComputed = save_Cij_measure(CijLocalEfficiency, baseFileName, 'local-efficiency', 8);
                reply = [];

               
                
            case '7'
                CijAssortativity = assortativity(CijNonZero, 1); % 1 := directed
                
                save_Cij_measure(CijAssortativity, baseFileName, 'assortativity', 4);
                reply = [];

            case '8'
                % Vertices that occur on many shortest paths
                % between other vertices have higher
                % betweenness than those that do not. (Wikipedia)
                fprintf(1, '\nComputing betweenness ...')
                [CijBetweenness] = betweenness_bin(CijNonZero);
                
                isBetweennessComputed = save_Cij_measure(CijBetweenness, baseFileName, 'betweenness', 8);
                reply = [];

            case '9'
                % The clustering coefficient of a vertex in a
                % graph quantifies how close its neighbors are
                % to being a clique (complete graph). (Wikipedia)
                fprintf(1, '\nComputing clustering coefficients ...')
                [CijClusteringCoefficients] = clustering_coef_bd(CijNonZero);
                %[CijClusteringCoefficients] = clustering_coef_wd(Cij);
                
                areClusteringCoefficientsComputed = save_Cij_measure(CijClusteringCoefficients, baseFileName, 'clustering-coefficients', 8);
                reply = [];

            case '10'
                % Edge centrality normalized with n*(n-1)
                % Vertex centrality normalized with (n-1)*(n-2)
                % Divide by factor of 2 for undirected graphs
                fprintf(1, '\nComputing edge betweenness ...')
                [CijEdgeBetweenness, CijVertexBetweenness] = edge_betweenness_bin(CijNonZero);
                
                isEdgeBetweennessComputed = save_Cij_measure(CijEdgeBetweenness, baseFileName, 'edge-betweenness', 8);
                save_Cij_measure(CijVertexBetweenness, baseFileName, 'vertex-betweenness', 8);
                reply = [];

            case '11'
                fprintf(1, '\nComputing joint degrees ...')
                [CijJointDegrees, CijNVerticesOdGtId, CijNVerticesIdGtOd, CijNVerticesIdEqOd] = jdegree(CijNonZero);

                areJointDegreesComputed = save_Cij_measure(CijJointDegrees, baseFileName, 'joint-degrees', 0);
                save_Cij_measure(CijNVerticesOdGtId, baseFileName, 'n-vertices-odGTid', 0);
                save_Cij_measure(CijNVerticesIdGtOd, baseFileName, 'n-vertices-idGTod', 0);
                save_Cij_measure(CijNVerticesIdEqOd, baseFileName, 'n-vertices-id=od', 0);
                reply = [];
                
            case '12'
                fprintf(1, '\nComputing range and shortcuts for excitatory synapses ...')
                [CijRange, CijExcitAverageRange, CijShortcuts, CijExcitFractionOfShortcuts] = erange(Cij, 0);
                isExcitRangeComputed = save_Cij_measure(CijRange, baseFileName, 'range_excit', 0);
                
                save_Cij_measure(CijExcitAverageRange, baseFileName, 'average-range_excit', 8);
                save_Cij_measure(CijShortcuts, baseFileName, 'shortcuts_excit', 0);
                save_Cij_measure(CijExcitFractionOfShortcuts, baseFileName, 'fraction-of-shortcuts_excit', 8);
                reply = [];

            case '13'
                fprintf(1, '\nComputing range and shortcuts for inhibitory synapses ...')
                [CijRange, CijInhibAverageRange, CijShortcuts, CijInhibFractionOfShortcuts] = erange(Cij, 1);
                
                isInhibRangeComputed = save_Cij_measure(CijRange, baseFileName, 'range_inhib', 0);
                save_Cij_measure(CijInhibAverageRange, baseFileName, 'average-range_inhib', 8);
                save_Cij_measure(CijShortcuts, baseFileName, 'shortcuts_inhib', 0);
                save_Cij_measure(CijInhibFractionOfShortcuts, baseFileName, 'fraction-of-shortcuts_inhib', 8);
                reply = [];


                
            case 'g'
                baseFileName = get_new_string(baseFileName);
                reply = [];
                
            case 'd'              
                strng = sprintf(['\nAssortativity: the preference of a network''s nodes to attach to others that are similar or different\n' ...
                        '\tin some way\n' ...
                    'Betweenness: nodes that occur on many shortest paths have higher betweenness than those that do not\n' ...
                    'Clustering coefficients: the degree to which nodes tend to cluster together. The clustering coefficient\n' ...
                        '\tof a node quantifies how close its neighbors are to being a clique (a tightly knit group with a high\n' ...
                        '\tdensity of ties)\n' ...
                    'Degrees: the number of connections to other nodes.  Average value = 2*(# edges)/(# nodes)\n' ...
                    'Connection density: number of connections present out of all possible on the graph (which equals N^2 - N)\n' ...
                    'Efficiency: a measure of how effectively a network exchanges information.\n' ...
                        '\t- Global efficiency: mean of the inverse distance matrix (excluding main diagonal)\n' ...
                        '\t- Local efficiency: average efficiency of local subgraphs (1/(shortest distance between i & j))\n' ...
                    'Range: the length of the shortest path from i to j for edge Cij AFTER that edge has been removed from\n' ...
                        '\tthe graph\n' ...
                    'Shortcuts: if range(i,j)>2, then edge Cij is a shortcut. One can compute the fraction of shortcuts over\n' ...
                        '\tthe entire graph\n' ...
                    'Joint degrees: (ONLY FOR DIRECTED GRAPHS)\n' ...
                        '\t- indegree: column sum of Cij matrix\n' ...
                        '\t- outdegree: row sum of Cij matrix\n' ...
                        '\t- od>id means an excess of outgoing edges\n' ...
                        '\t- id>od means an excess of incoming edges]\n' ...
                        '\t- od=id occurs on the main diagonal of Cij\n' ...
                    'Strengths:\n' ...
                        '\t(FOR DIRECTED GRAPHS) column sum + row sum of Cij\n' ...
                        '\t(FOR UNDIRECTED GRAPHS) column sum of Cij']);
                disp(strng);
                pause
                
                reply = [];              
            
            case 'b'
                % exit

            case '!'
                % exit
                
            otherwise
                reply = [];
                
        end % switch

    end % while loop
    
end % menu_brain_conn