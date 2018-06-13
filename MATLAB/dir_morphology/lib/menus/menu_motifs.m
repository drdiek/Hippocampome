function [reply] = menu_motifs(csvFileName)
% modified 20100917 by Diek W. Wheeler, Ph.D

    load adPCLtoggles
    load Cij.mat
    load CellCounts.mat

    if (exist('newMotifLib.mat', 'file') == 0)
        createCSVmotifList();
    end
    
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
        strng = sprintf('Connectivity - MOTIFS MENU\n');
        disp(strng);
        strng = sprintf('Select from the options below:\n');
        disp(strng);
        
        disp('    1) Count HC monomers, randomize, and determine significance');
        disp('    2) Count HC dimers, randomize, and determine significance');
        disp('    3) Count HC trimers, randomize, and determine significance');
                        
        strng = sprintf('\n    B) Back to connectivity menu');
        disp(strng)
        disp('    !) Exit');
        
        
        %% process input %%
                
        reply = lower(input('\nYour selection: ', 's'));

        switch reply
            case '1'
                %% monomers
                rNetNum = input('\nEnter # of random networks to generate (default = 1):  ');
                if isempty(rNetNum)
                    rNetNum = 1;
                end
                outfileName = input('Enter the output file name (default = _random1_#randNets.txt):  ', 's');                               
                if isempty(outfileName)
                    outfileName = ['_random1_', num2str(rNetNum), '.txt'];
                end

                fidRand = fopen(outfileName, 'wt');
                fprintf(fidRand, 'selfE\tselfI\n\n');

                tic
                for j=1:rNetNum
                    disp(j);
                    newCIJ = makerandCIJ_dir_EI_EEII(Cij, nInhib, nExcit, nIIedges, nEEedges);
                    nInhibSelfEdges = length(find(diag(newCIJ)<0));
                    nExcitSelfEdges = length(find(diag(newCIJ)>0));

                    fprintf(fidRand, '%d\t%d', nExcitSelfEdges, nInhibSelfEdges);
                    fprintf(fidRand, '\n');
                end
                totalTime = toc;

                avgTimePerRun = totalTime/rNetNum;
                percentValidSwaps = 1;
                
                fclose(fidRand);

                
            case '2'
                %% dimers
                rNetNum = input('\nEnter # of random networks to generate (default = 1):  ');
                if isempty(rNetNum)
                    rNetNum = 1;
                end
                stringencyCode = input('Enter code for swap stringency (1=liberal -> 5=conservative; default = 5):  ');
                if isempty(stringencyCode)
                    stringencyCode = 5;
                end
                outfileName = input('Enter the output file name (default = _random2_<#rand>_<stringency>.txt):  ', 's');                               
                if isempty(outfileName)
                    outfileName = ['_random2_', num2str(rNetNum), '_', num2str(stringencyCode), '.txt'];
                end

                
                fidRand = fopen(outfileName, 'wt');
                for index = 1:36
                    fprintf(fidRand, '%d\t', index);
                end
                fprintf(fidRand, '\n\n');

                
                [mCount allM cellMtypes] = motif1struct_wei(Cij);
                [origAllCount origTempAllD] = motif2struct_wei(Cij);

                fprintf(fidRand, '%d\t', origAllCount);
                fprintf(fidRand, '\n\n');

                totalValidSwaps = 0;
                totalInvalidSwaps = 0;
                
                tic
                for j=1:rNetNum
                    disp(j);
                    [newRandCIJ numValidSwaps numInvalidSwaps] = makerandCIJ_dir_EI_swap(cellMtypes, origTempAllD, Cij, stringencyCode);
                    [allCount] = motif2struct_wei(newRandCIJ);

                    totalValidSwaps = totalValidSwaps + numValidSwaps;
                    totalInvalidSwaps = totalInvalidSwaps + numInvalidSwaps;
                    fprintf(fidRand, '%d\t', allCount);
                    fprintf(fidRand, '\n');
                end
                totalTime = toc;
                
                avgTimePerRun = totalTime/rNetNum;
                percentValidSwaps = totalValidSwaps/(totalValidSwaps + totalInvalidSwaps);

                fclose(fidRand);


            case '3'
                %% trimers
                rNetNum = input('\nEnter # of random networks to generate (default = 1):  ');
                if isempty(rNetNum)
                    rNetNum = 1;
                end
                stringencyCode = input('Enter code for swap stringency (1=liberal -> 5=conservative; default = 5):  ');
                if isempty(stringencyCode)
                    stringencyCode = 5;
                end
                outfileName = input('Enter the output file name (default = _random3_<#rand>_<stringency>.txt):  ', 's');                               
                if isempty(outfileName)
                    outfileName = ['_random3_', num2str(rNetNum), '_', num2str(stringencyCode), '.txt'];
                end                                

                             
                fidRand = fopen(outfileName, 'wt');
                for index = 1:628
                    fprintf(fidRand, '%d\t', index);
                end
                fprintf(fidRand, '\n\n');

                
                [mCount allM cellMtypes] = motif1struct_wei(Cij);
                [allCount tempAllD] = motif2struct_wei(Cij);
                [origTriCount] = motif3struct_wei(Cij);

                fprintf(fidRand, '%d\t', origTriCount);
                fprintf(fidRand, '\n\n');                                       

                totalValidSwaps = 0;
                totalInvalidSwaps = 0;
                
                tic
                for j=1:rNetNum
                    disp(j);
                    [newRandCIJ numValidSwaps numInvalidSwaps] = makerandCIJ_dir_EI_swap(cellMtypes, tempAllD, Cij, stringencyCode);
                    [triCount2] = motif3struct_wei(newRandCIJ);

                    totalValidSwaps = totalValidSwaps + numValidSwaps;
                    totalInvalidSwaps = totalInvalidSwaps + numInvalidSwaps;
                    fprintf(fidRand, '%d\t', triCount2);
                    fprintf(fidRand, '\n');
                end
                totalTime = toc;
                
                avgTimePerRun = totalTime/rNetNum;
                percentValidSwaps = totalValidSwaps/(totalValidSwaps + totalInvalidSwaps);

                fclose(fidRand);
            
                
            case 'b'
                % exit

            case '!'
                % exit
                
            otherwise
                reply = [];
                
        end % switch
        
        % print randomization stats
        if ~isempty(reply) && (reply == '1' || reply == '2' || reply == '3')
            strng = sprintf('%d random networks generated', rNetNum);
            disp(strng);                
            strng = sprintf('\ntotal runtime = %.4f sec', totalTime);
            disp(strng);
            strng = sprintf('avg time per random network = %.4f sec', avgTimePerRun);
            disp(strng);
            strng = sprintf('fraction of valid swaps = %.3f', percentValidSwaps);
            disp(strng);
            strng = sprintf('\nmotif counts saved to: %s', outfileName);
            disp(strng);
            strng = sprintf('\nPress any key to continue');
            disp(strng);
            pause
            reply = [];
        end
    end % while loop
    
end % menu_motifs