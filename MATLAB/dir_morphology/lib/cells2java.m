function [java, cellIds, areSaved] = cells2java(csvFile, cellAbbrevs, baseFileName, Cij)
% hippocampome network graphics analysis
% 200904122120 David J. Halimton
%
% adapted from R to MATLAB 20090504 Diek W. Wheeler




    areSaved = 0;
    fprintf(1, '\nSaving ...')

%    [nParcellations, nOfficialParcellations, DGcells, CA3cells, CA2cells, CA1cells, SUBcells, ECcells...
%        nCells, nAllCells, DG, CA3, CA2, CA1, SUB, EC, rowSkip, colSkip, cellIdColNum, ...
%        labelColNum, axonOrDendriteColNum, excitOrInhibColNum, overlapNotesColNum, parcelNamesRowNum, version] = current_parcellation_data(csvFile);
    
    load parcellation.mat    
    
    axonsArray = zeros(1,nAllCells);
    dendritesArray = zeros(1,nAllCells);
     
    foundCells = 0;
    rowLooper = rowSkip + 1;
    while foundCells < nAllCells
        if ~isempty(csvFile{rowLooper,cellIdColNum})          
            if strcmpi(csvFile{rowLooper,axonOrDendriteColNum},'axons')
                axonsArray(foundCells+1) = rowLooper;
            elseif strcmpi(csvFile{rowLooper,axonOrDendriteColNum},'dendrites')
                foundCells = foundCells + 1;
                dendritesArray(foundCells) = rowLooper;
            end
        end      
        rowLooper = rowLooper + 1;
    end


    % retrieve cellIds from first column of input file and convert from
    % string to number
    cellIds = csvFile(axonsArray,cellIdColNum);
    cellIds = cellfun(@(cellIds) cellIds(2:end), cellIds, 'uni',false);
    cellIds = str2num(cell2mat(cellIds));    
    
    theLabels = csvFile(axonsArray,labelColNum);
    EorIvalue = csvFile(axonsArray,excitOrInhibColNum);
    
    
    xyNodeCoords = [280 545;... % Dentate gyrus granule neuron
        295 505;... % Dentate gyrus semilunar granule neuron
        240 525;... % Dentate gyrus mossy neuron        
        240 475;... % Dentate gyrus interneuron specific I neuron        
        270 400;... % Dentate gyrus interneuron specific II neuron
        340 520;... % Dentate gyrus MOPP neuron 
        390 500;... % Dentate gyrus vasoactive-intestinal-polypeptide-positive basket neuron
        354 470;... % Dentate gyrus parvalbumin-positive basket neuron
        290 465;... % Dentate gyrus pyramidal basket neuron 
        400 440;... % Dentate gyrus axo-axonic neuron
        350 440;... % Dentate gyrus HICAP neuron
        300 430;... % Dentate gyrus HIPP neuron
        370 405;... % Dentate gyrus Hilar project neuron
        

        90 530;... % CA3 pyramidal neuron              
        130 515;... % CA3 L-M-R neuron             
        170 520; % CA3 interneuron specific I neuron
        200 500;... % CA3 interneuron specific II neuron            
        160 485; % CA3 interneuron specific III neuron
        200 435;...  % CA3 ivy neuron
        120 470;... % CA3 spiny CR neuron
        70 440;... % CA3 patterned-spiking basket neuron
        110 430;... % CA3 basket neuron
        75 400;... % CA3 spiny lucidum cell              
        110 380;... % CA3 axo-axonic neuron
        140 400;... % CA3 bistratified 
        150 440;... % CA3 O-LM neuron
        175 410;... % stratum oriens neuron
        85 490;... % CA3 horizontal trilaminar neuron
        195 465;... % CA3 radial trilaminar neuron
    	
        
        205 380;... % CA2 pyramidal neuron
        155 360;... % CA2 broad basket neuron
        180 335;... % CA2 narrow basket neuron
        110 335;... % CA2 broad bistratified neuron
        145 300;... % CA2 narrow bistratified neuron

        
        250 350;... % CA1 pyramidal neuron
        225 325;... % CA1 olfactory-bulb-projecting pyramidal neuron
        265 310;... % CA1 neurogliaform neuron
        205 290;... % CA1 stratum lacunosum-moleculare neuron
        180 255;... % CA1 perforant path-associated neuron
        220 235;... % CA1 radiatum retrohippocampal projection neuron
        240 270;... % CA1 Schaffer collateral associated neuron
        290 340;... % CA1 parvalbumin or vesicular-glutamate-transporter-3-positive basket neuron
        330 345;... % CA1 CA1 vasoactive-intestinal-polypeptide-positive basket neuron
        310 305;... % CA1 interneuron specific I neuron
        285 275;... % CA1 interneuron specific II neuron
        325 270;... % CA1 interneuron specific III neuron
        255 210;... % CA1 apical dendrite innervating neuron
        275 240;... % CA1 ivy neuron
        305 200;... % CA1 axo-axonic neuron
        325 230;... % CA1 bistratified neuron
        370 220;... % CA1 backprojection neuron
        370 265;... % CA1 oriens lacunosum-moleculare neuron
        410 245;... % CA1 stratum oriens neuron
        365 310;... % CA1 horizontal trilaminar neuron
        375 350;... % CA1 radial trilaminar neuron
        405 290;... % CA1 oriens retrohippocampal projection neuron

    
        440 405;... % Subiculum pyramidal neuron
        450 355;... % Subiculum interneuron
       
        465 500;... % Entorhinal cortex layer II pyramidal neuron               
        495 525;... % Entorhinal cortex layer III pyramidal neuron
        530 480;... % Entorhinal cortex layer IV-V pyramidal neuron
        470 460;... % Entorhinal cortex layer VI pyramidal neuron
        490 420;... % Entorhinal cortex layer II stellate neuron      
        540 440;... % Entorhinal cortex layer III stellate neuron
        550 400;... % Entorhinal cortex layer IV-VI bipolar neuron               
        500 370;... % Entorhinal cortex layer V horizontal neuron
        555 350;... % Entorhinal cortex layer III multipolar neuron 
        455 150;... % Entorhinal cortex layer V multipolar neuron
        510 325;... % Entorhinal cortex layer VI multipolar neuron
        495 285;... % Entorhinal cortex layer I multipolar interneuron               
        550 260;... % Entorhinal cortex layer II multipolar interneuron
        555 310;... % Entorhinal cortex layer III multipolar interneuron
        525 220;... % Entorhinal cortex layer I-II horizontal interneuron            
        470 240;... % Entorhinal cortex layer II axo-axonic neuron
        410 180;... % Entorhinal cortex layer II basket neuron                  
        495 180;... % Entorhinal cortex layer III bipolar neuron
        455 200;... % Entorhinal cortex layer IV bipolar neuron
        405 125;... % Entorhinal cortex layer III pyramidal-looking interneuron
        350 160;... % Entorhinal cortex V globular neuron
        
    ];

    if (length(xyNodeCoords) == nAllCells) 

        % record nodes

        saveJavaNodes = sprintf('java_output/nodes.txt');
        fidJavaNodes = fopen(saveJavaNodes, 'wt');       

        fprintf(fidJavaNodes, 'Hippocampome v1.1\n\n');
        fprintf(fidJavaNodes, 'Number of nodes:\n%d\n\n',nAllCells);
        fprintf(fidJavaNodes, 'Subregion\tLabel\tx-coord\ty-coord\tE/I\n\n');

        outputCounter=1;

        for iNode=1:length(DGcells)
            fprintf(fidJavaNodes, 'Dentate Gyrus\t%s\t%d\t%d\t%s\n', char(theLabels(outputCounter)),xyNodeCoords(outputCounter,1),xyNodeCoords(outputCounter,2),char(EorIvalue(outputCounter)));
            outputCounter=outputCounter+1;
        end
        for iNode=1:length(CA3cells)
            fprintf(fidJavaNodes, 'CA3\t%s\t%d\t%d\t%s\n', char(theLabels(outputCounter)),xyNodeCoords(outputCounter,1),xyNodeCoords(outputCounter,2),char(EorIvalue(outputCounter)));
            outputCounter=outputCounter+1;
        end
        for iNode=1:length(CA2cells)
            fprintf(fidJavaNodes, 'CA2\t%s\t%d\t%d\t%s\n', char(theLabels(outputCounter)),xyNodeCoords(outputCounter,1),xyNodeCoords(outputCounter,2),char(EorIvalue(outputCounter)));
            outputCounter=outputCounter+1;
        end
        for iNode=1:length(CA1cells)
            fprintf(fidJavaNodes, 'CA1\t%s\t%d\t%d\t%s\n', char(theLabels(outputCounter)),xyNodeCoords(outputCounter,1),xyNodeCoords(outputCounter,2),char(EorIvalue(outputCounter)));
            outputCounter=outputCounter+1;
        end
        for iNode=1:length(SUBcells)
            fprintf(fidJavaNodes, 'Subiculum\t%s\t%d\t%d\t%s\n', char(theLabels(outputCounter)),xyNodeCoords(outputCounter,1),xyNodeCoords(outputCounter,2),char(EorIvalue(outputCounter)));
            outputCounter=outputCounter+1;
        end
        for iNode=1:length(ECcells)
            fprintf(fidJavaNodes, 'Entorhinal Cortex\t%s\t%d\t%d\t%s\n', char(theLabels(outputCounter)),xyNodeCoords(outputCounter,1),xyNodeCoords(outputCounter,2),char(EorIvalue(outputCounter)));
            outputCounter=outputCounter+1;
        end

        fprintf(fidJavaNodes, '\n*End Of File*');
        fclose(fidJavaNodes);     



        % record connections 

        cellIdx = 0;

        % loop over rows (cell types)
        for iCell = 1:nAllCells  
            for jCell = 1:nAllCells % pst
                if (Cij(iCell,jCell))
                    cellIdx = cellIdx + 1;
                    java(1:2, cellIdx) = [(iCell-1) (jCell-1)];
                end % if Cij(i,j)
            end % jCell loop
        end % iCell




        % print connections

        saveJavaLines = sprintf('java_output/lines.txt');
        fidJavaLines = fopen(saveJavaLines, 'wt');       

        fprintf(fidJavaLines, 'Hippocampome v1.0\n\n');
        fprintf(fidJavaLines, 'Number of lines:\n%d\n\n',length(java));
        fprintf(fidJavaLines, 'Start node\tEnd node\n\n');

        fprintf(fidJavaLines, '%d\t%d\n', java([1 2],:));

        fprintf(fidJavaNodes, '\n*End Of File*')
        fclose(fidJavaLines);    




        areSaved = 1;
    else
        disp('**** Incorrect Number of node coordinates specified in code.  Press any key. ****');
        java = [];
        cellIds = [];
        areSaved = 0;
        pause
    end
        
end % cells2fanmod
