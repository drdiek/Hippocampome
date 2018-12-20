function morphologyARAAnnotator(inputSWCFile, outputSWCFile, labelImageFile, scalingFactor)

    addpath('./lib/');
    
    swcList = morphologySWCReader(inputSWCFile, 1); 
    
    pointList = [swcList.xCoord; swcList.yCoord; swcList.zCoord];
    pointList = pointList * scalingFactor;
  
    size = [528 320 456];
    % labelImage = 3-D matrix of annotation labels
%     fid = fopen('./data/annotation.raw', 'r', 'l' );
%     labelImage = fread( fid, prod(size), 'uint32' );
%     fclose( fid );
%     labelImage = reshape(labelImage,size);
    labelImage = nrrdread (labelImageFile);
    
    pointLabels = interp3 (labelImage, pointList(1,:), pointList(2,:) , pointList(3,:), 'nearest');
    
    pNANC = read_numbers_acronyms_names_colors(1);
    
    for iPoint = 1:length (swcList)
        swcList(iPoint).pointLabel = pointLabels(iPoint);
        if (pointLabels(iPoint) == 0)
            swcList(iPoint).pointNumber = 0;
            swcList(iPoint).pointAcronym = 'dww';
            swcList(iPoint).pointName = 'Diek W. Wheeler';
            swcList(iPoint).pointColor = '#FFFFFF';
        else
            idx = find(pNANC.numbers == pointLabels(iPoint))
            swcList(iPoint).pointNumber = pNANC.numbers(idx);
            swcList(iPoint).pointAcronym = pNANC.acronyms(idx);
            swcList(iPoint).pointName = pNANC.names(idx);
            swcList(iPoint).pointColor = {pNANC.colors(idx)};
        end
    end
    
    morphologySWCWriter (swcList, outputSWCFile);

end % morphologyARAAnnotator()