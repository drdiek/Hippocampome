
function swc_labels()

	addpath('./lib/');
	addpath('./lib/utils/');
	addpath('./lib/menu/');
    addpath('./lib/warping');

    clear all;
    
    CONVERSION = 1;
    PLOTTING = 2;
    MATRIX = 3;
    SWC2ELASTIX = 4;
    TRANSFORMIX2SWC = 5;
    
    processingFunction = select_processing_function();
    if strcmp(processingFunction, '!')
        return;
    end
    
    if ((processingFunction == CONVERSION) || (processingFunction == PLOTTING) || (processingFunction == MATRIX))
        isARA = select_ARA_or_CCF();
        if strcmp(isARA, '!')
            return;
        end
        
        labelImageFile = select_file_nrrd(isARA);
        if strcmp(labelImageFile, '!')
            return;
        end
        %         labelImageFile = './data/annotation_ccf_2017_25.nrrd';
        
        subregion = select_subregion();
        if strcmp(subregion, '!')
            return;
        end
        
        inputSWCFile = select_file_swc(isARA, subregion);
        if strcmp(inputSWCFile, '!')
            return;
        end
        nSWCFiles = length(inputSWCFile);
        %	inputSWCFile = './data/Han_etal_ARA.swc';
        % 	inputSWCFile = './data/AA0208.swc';
        
        idx = strfind(labelImageFile, '_');
        
        morphologyMatrix.axonCounts = zeros(100,10000);
        morphologyMatrix.dendriteCounts = zeros(100,10000);
        morphologyMatrix.somaCounts = zeros(100,10000);
        morphologyMatrix.neuronTypes = {'neuronType'};
        morphologyMatrix.parcels = {'parcel'};
        morphologyMatrix.nRows = 0;
        morphologyMatrix.nCols = 0;
        morphologyMatrix.subregion = subregion;
        
        for i = 1:nSWCFiles
            %         outputSWCFile = sprintf('./output/%s_openSTP_%s.swc', inputSWCFile(i).name(1:end-4), ...
            %             labelImageFile(idx(2)+1:idx(3)-1));
            outputSWCFile = sprintf('./output/%s_openSTP_%s.swc', inputSWCFile(i).name(1:end-4), ...
                labelImageFile(8:end-5));
            %	outputSWCFile = './output/Han_etal_ARA_openSTP_2017.swc';
            % 	outputSWCFile = './output/AA0208_openSTP_2016.swc';
            
            %         scalingFactor = 1/str2double(labelImageFile(idx(3)+1:end-5));
            scalingFactor = 1/25;
            
            %     writeSWCToElastixFile(inputSWCFile);
            
            morphologyMatrix = morphologySWCAnnotator(inputSWCFile(i).name, outputSWCFile, ...
                labelImageFile, scalingFactor, isARA, processingFunction, morphologyMatrix);
        end % i
        
        if (processingFunction == MATRIX)
            save_morphology_matrix(morphologyMatrix, labelImageFile(8:end-5));
        end
    elseif (processingFunction == SWC2ELASTIX)
        isARA = select_ARA_or_CCF();
        if strcmp(isARA, '!')
            return;
        end
        
        subregion = select_subregion();
        if strcmp(subregion, '!')
            return;
        end
        
        inputSWCFile = select_file_swc(isARA, subregion);
        if strcmp(inputSWCFile, '!')
            return;
        end
        nSWCFiles = length(inputSWCFile);
        %	inputSWCFile = './data/Han_etal_ARA.swc';
        % 	inputSWCFile = './data/AA0208.swc';
        
        for i = 1:nSWCFiles
            writeSWCToElastixFile(inputSWCFile(i).name);
        end % i        
    else % processingFunction == TRANSFORMIX2SWC
    end % if processingFunction
        
end % swc_labels()