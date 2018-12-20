%pointListFileName = 'D:\data\CerterraDropbox\Dropbox (CSHL-Certerra)\Gad-data\cells_transformed_to_Atlas.mat';
%regionStructureWebFileName = 'http://api.brain-map.org/api/v2/structure_graph_download/1.json';
%imAnnotationFileName = 'D:\data\CerterraDropbox\Dropbox (CSHL-Certerra)\Gad-data\annotation_025_coronal.nrrd';

function getRegionWiseCellCounts (pointListFileName, regionStructureWebFileName, imAnnotationFileName, doWriteCellCountImage)

if (~isdeployed)
    addpath ('../utils/');
    addpath ('../atlas/');
    addpath ('../../../headlight/src/dataSetupScripts/');
else
  doWriteCellCountImage = str2double (doWriteCellCountImage);
end

%% Loading the detected cells
load (pointListFileName);
pointListX = pointList(:, 1);
pointListY = pointList(:, 2);
pointListZ = pointList(:, 3);

% The annotation structure file and the nrrd/tif expression image file
[regionIDList, region, ~] = readAllenRegionAnnotationWebFile(regionStructureWebFileName, 1, [pointListFileName(1:end-4) '_ontology.csv']);
imAnnonNRRD = nrrdread(imAnnotationFileName);

% Find the labels of the cells from the annotation label image
pointLabels = interp3 (imAnnonNRRD, pointListX, pointListY , pointListZ, 'nearest');

% Generate the list of unique region labels
imSlice = imAnnonNRRD;
uniqueLabels = unique (imSlice(:));
uniqueLabels = uniqueLabels (2:end);
nUniqueLabels = length (uniqueLabels);

regionProperties = struct;
for iLabel = 1:nUniqueLabels
    fprintf ('Getting cell counts for unique label %d/%d\n', iLabel, nUniqueLabels)
    %% Region wise data collection from the label image
    regionProperties(iLabel).cellCount = sum(pointLabels == uniqueLabels(iLabel));

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
cellCountArray = [regionProperties.cellCount];
regionIDarray = [regionProperties.regionID];

if (doWriteCellCountImage > 0)
  imCellCountImage = uint32 (zeros (size (imAnnonNRRD)));
  for iLabel = 1:nUniqueLabels
    imCellCountImage(imAnnonNRRD == regionProperties(iLabel).regionID) = regionProperties(iLabel).cellCount;
  end
  cellCountImageFileName = [pointListFileName(1:end-4) '_regionWiseCellCount.nrrd'];
  nrrdwrite (cellCountImageFileName, imCellCountImage, [25 25 50], [0 0 0], 'raw');
end

%% Calculate counts in the agglomerated regions
nRegionsFromOntologyFile = size (region, 2);
for iRegion = 1:nRegionsFromOntologyFile
    fprintf ('Calculating agglomerated region cell counts %d/%d (%s)\n', iRegion, nRegionsFromOntologyFile, region(iRegion).name)
    regionID = region(iRegion).id;
    % get all leaf children
    subregionIDList = getAllSubregions(regionIDList, region, regionID, 'silent');
    % get cell count of all leaf children
    if (size(subregionIDList,2) > 1)
      regionCellCount = sum (cellCountArray (ismember(regionIDarray, subregionIDList)));
    else
      regionCellCount = sum (pointLabels == regionID);
    end
    region(iRegion).cellCount = regionCellCount;
end

%% Write the results to a file
fp = fopen ([pointListFileName(1:end-4) '_regionWiseCellCounts.csv'], 'w+');
fprintf (fp, 'regionID,structure_order, parent_id,acronym,name,count\n');
for iLabel = 1:nRegionsFromOntologyFile
    fprintf (fp, '"%d","%d","%d","%s","%s","%f"\n', region(iLabel).id, region(iLabel).structure_order, region(iLabel).parent_id, region(iLabel).acronym, region(iLabel).name, ...
        region(iLabel).cellCount);
end
fclose (fp);