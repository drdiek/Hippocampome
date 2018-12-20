function swc_labels()

	addpath('./lib/');
	addpath('./lib/utils/');
	addpath('./lib/menu/');
    addpath('./lib/warping');

    isConversion = select_conversion_or_plot();
    if strcmp(isConversion, '!')
        return;
    end
    
    if isConversion
        
        isARA = select_ARA_or_CCF();
        if strcmp(isARA, '!')
            return;
        end
        
        inputSWCFile = select_file_swc(isARA);
        if strcmp(inputSWCFile, '!')
            return;
        end
        nSWCFiles = length(inputSWCFile);
        %	inputSWCFile = './data/Han_etal_ARA.swc';
        % 	inputSWCFile = './data/AA0208.swc';
        
        if isARA
            [regionIDList, region] = readAllenRegionAnnotationFile();
            outputSWCFile = sprintf('./output/%s_openSTP_ARA.swc', inputSWCFile(1).name(1:end-4));
            morphologyARAAnnotator(inputSWCFile(1).name, outputSWCFile, './data/annotation_ara_2011_25.nrrd', 1/25);
            
            %         % 25 micron volume size
            %         size = [528 320 456];
            %         % ANO = 3-D matrix of annotation labels
            %         fid = fopen('./data/annotation.raw', 'r', 'l' );
            %         ANO = fread( fid, prod(size), 'uint32' );
            %         fclose( fid );
            %         ANO = reshape(ANO,size);
            %
            %         max(max(max(ANO)))
            %         ANO(263:265,221:223,331:333)
            %         pause
        else % isARA == 0; is CCF file
            labelImageFile = select_file_nrrd(isARA);
            if strcmp(labelImageFile, '!')
                return;
            end
            %         labelImageFile = './data/annotation_ccf_2017_25.nrrd';
            
            idx = strfind(labelImageFile, '_');
            
            for i = 1:nSWCFiles
                outputSWCFile = sprintf('./output/%s_openSTP_%s.swc', inputSWCFile(i).name(1:end-4), labelImageFile(idx(2)+1:idx(3)-1));
                %	outputSWCFile = './output/Han_etal_ARA_openSTP_2017.swc';
                % 	outputSWCFile = './output/AA0208_openSTP_2016.swc';
                
                scalingFactor = 1/str2double(labelImageFile(idx(3)+1:end-5));
                %	scalingFactor = 1/25;
                
                %     writeSWCToElastixFile(inputSWCFile);
                
                morphologySWCAnnotator(inputSWCFile(i).name, outputSWCFile, labelImageFile, scalingFactor)
            end % i
        end % if isARA
        
    else % plot; isConversion == 0
        
        plotSWCFile = select_file_converted_swc();
        if strcmp(plotSWCFile, '!')
            return;
        end
        
        morphologySWCPlotter(plotSWCFile);
        
    end % if isConversion

end % swc_labels()