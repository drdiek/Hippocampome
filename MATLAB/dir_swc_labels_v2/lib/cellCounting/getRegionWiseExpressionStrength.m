%geneExpressionVolumeFile = 'voxelizeImageFileInSameSpaceAsTheAnnotationFileName';
%regionStructureWebFileName = 'http://api.brain-map.org/api/v2/structure_graph_download/1.json';
%regionStructureWebFileName = 'C:\Users\kannanuv\Documents\GitHub\headlight\data\ARA2_annotation_structure_info.csv';
%imAnnotationFileName = 'D:\data\CerterraDropbox\Dropbox (CSHL-Certerra)\Gad-data\annotation_025_coronal.nrrd';

function regionProperties = getRegionWiseExpressionStrength (geneExpressionVolumeFile, regionStructureWebFileName, annotationLabelMapFile)

if (~isdeployed)
    addpath ('../utils/');
    addpath ('../atlas/');
end

% Reading the annotation structure file
[~, ~, annotationFileType] = fileparts (regionStructureWebFileName);
if (strcmp (annotationFileType, '.json'))
  [regionIDList, region, ~] = readAllenRegionAnnotationWebFile(regionStructureWebFileName);
else
  % else assuming it is a csv file from old format
  [regionIDList, region] = readAllenRegionAnnotationFile(regionStructureWebFileName);
end

% The annotation structure file and the nrrd/tif expression image file
if (contains (annotationLabelMapFile, 'tif'))
  imAnnot = imreadstack (annotationLabelMapFile);
else
  if (contains (annotationLabelMapFile, 'nrrd'))
    [imAnnot, ~] = nrrdread(annotationLabelMapFile);
  end
end

if (contains (geneExpressionVolumeFile, 'tif'))
  geneExpressionVolume = imreadstack (geneExpressionVolumeFile);
else
    if (contains (geneExpressionVolumeFile, 'nrrd'))
        [geneExpressionVolume, ~] = nrrdread(geneExpressionVolumeFile);
    end
end

% Generate the list of unique region labels
imSlice = imAnnot;
uniqueLabels = unique (imSlice(:));
uniqueLabels = uniqueLabels (2:end);
nUniqueLabels = length (uniqueLabels);

regionProperties = struct;
for iLabel = 1:nUniqueLabels
    fprintf ('Processing label %d/%d\n', iLabel, nUniqueLabels)
    %% Region wise data collection from the label image
    regionPixels = geneExpressionVolume(imAnnot == uniqueLabels(iLabel));
    regionProperties(iLabel).meanValue = mean (regionPixels);
    regionProperties(iLabel).minValue = min (regionPixels);
    regionProperties(iLabel).maxValue = max (regionPixels);
    regionProperties(iLabel).sumValue = sum (regionPixels);
    regionProperties(iLabel).medianValue = median (regionPixels);
    regionProperties(iLabel).totalVoxels = length (regionPixels);

    %% Region wise data collection from the label image
    regionTableIndex = find ([region.id] == uniqueLabels(iLabel));
    if (~isempty(regionTableIndex))
        regionProperties(iLabel).name = region(regionTableIndex).name;
        regionProperties(iLabel).acronym = region(regionTableIndex).acronym;
        regionProperties(iLabel).structure_order = region(regionTableIndex).structure_order;
        regionProperties(iLabel).regionID = uniqueLabels(iLabel);
    else
      fprintf ('Processing label error region ID = %d not found.\n', uniqueLabels(iLabel))
      regionProperties(iLabel).name = 'NameNotFound';
      regionProperties(iLabel).acronym = 'AcronymNotFound';
      regionProperties(iLabel).structure_order = 'StructureOrderNotFound';
      regionProperties(iLabel).regionID = uniqueLabels(iLabel);
    end
end
regionIDarray = uint32([regionProperties.regionID]);
meanValueArray = [regionProperties.meanValue];
maxValueArray = [regionProperties.maxValue];
minValueArray = [regionProperties.minValue];
expressionCountArray = [regionProperties.sumValue];
medianValueArray = [regionProperties.medianValue];
totalVoxelsArray = [regionProperties.totalVoxels];

%% Calculate counts in the agglomerated regions
nRegionsFromOntologyFile = size (region, 2);
for iRegion = 1:nRegionsFromOntologyFile
    fprintf ('Calculating agglomerated region expression counts %d/%d (%s)\n', iRegion, nRegionsFromOntologyFile, region(iRegion).name)
    regionID = region(iRegion).id;
    % get all leaf children
    subregionIDList = getAllSubregions(regionIDList, region, regionID, 'silent');
    if (size(subregionIDList,2) <= 1)
      subregionIDList = regionID;
    end
    % get expression strength count of all leaf children
    region(iRegion).sumValue = sum (expressionCountArray (ismember(regionIDarray, subregionIDList)));
    region(iRegion).totalVoxels = sum (totalVoxelsArray (ismember(regionIDarray, subregionIDList)));
    region(iRegion).maxValue = max (maxValueArray (ismember(regionIDarray, subregionIDList)));
    region(iRegion).minValue = min (minValueArray (ismember(regionIDarray, subregionIDList)));
    if (size(subregionIDList,2) > 1)
      region(iRegion).meanValue = single (region(iRegion).sumValue) / single(region(iRegion).totalVoxels);
      region(iRegion).medianValue = 0;
    else
      region(iRegion).meanValue = meanValueArray (ismember(regionIDarray, subregionIDList));
      region(iRegion).medianValue = medianValueArray (ismember(regionIDarray, subregionIDList));
    end
end

%% Write the results to a file
fp = fopen ([geneExpressionVolumeFile(1:end-4) '_regionProperties.csv'], 'w+');
fprintf (fp, 'regionID,structure_order,parent_id,acronym,name,mean,median,min,max,sum,noOfVoxels\n');
for iLabel = 1:nRegionsFromOntologyFile
    fprintf (fp, '"%d","%d","%d","%s","%s","%f","%f","%f","%f","%f","%f"\n', region(iLabel).id, region(iLabel).structure_order, region(iLabel).parent_id, ...
      region(iLabel).acronym, region(iLabel).name, ...
        region(iLabel).meanValue, region(iLabel).medianValue, region(iLabel).minValue, region(iLabel).maxValue, ...
        region(iLabel).sumValue, region(iLabel).totalVoxels);
end
fclose (fp);