import pandas as pd

from pandas.io.json import json_normalize

from lib.header import data_frame_header
from lib.append_df import append_data_frame
from lib.save_cells_df import save_cells_data_frame

maxNo = 500
pageNo = 0

uploadDate = '2018-04-16'

brainRegions = ('hippocampus', 'subiculum', 'entorhinal%20cortex')

cellTypes = ('interneuron', 'principal%20cell')

baseSearch = 'http://neuromorpho.org/api/neuron'

nBrainRegions2Save = 15
nCellTypes2Save = 30

nNeuronResourcesMax = 0
for brainRegionNo in range(len(brainRegions)):

    for cellTypeNo in range(len(cellTypes)):
    
        searchURL = '{}/select?q=upload_date:{}&fq=brain_region:{}&fq=cell_type:{}&size={}&page={}'.format(baseSearch, 
                    uploadDate, brainRegions[brainRegionNo], cellTypes[cellTypeNo], maxNo, pageNo)
                    
        try:
            nmoTextDF = pd.read_json(searchURL)
            nNeuronResourcesMax += int(nmoTextDF['page']['totalElements'])
        except:
            print 'Zero totalElements for {}:{}'.format(brainRegions[brainRegionNo], cellTypes[cellTypeNo])

cellsDF = data_frame_header(nBrainRegions2Save, nCellTypes2Save, nNeuronResourcesMax)
cellsDfIndex = 0

for brainRegionNo in range(len(brainRegions)):

    for cellTypeNo in range(len(cellTypes)):
    
        searchURL = '{}/select?q=upload_date:{}&fq=brain_region:{}&fq=cell_type:{}&size={}&page={}'.format(baseSearch, 
                    uploadDate, brainRegions[brainRegionNo], cellTypes[cellTypeNo], maxNo, pageNo)

        try:
            nmoTextDF = pd.read_json(searchURL)
            pageNoMax = int(nmoTextDF['page']['totalPages'])
        except:
            pageNoMax = 0
            print '\nAppending 0 {}:{} cells to data frame ...'.format(brainRegions[brainRegionNo], cellTypes[cellTypeNo])
                    
        for i in range(pageNoMax):
        
            searchURL = '{}/select?q=upload_date:{}&fq=brain_region:{}&fq=cell_type:{}&size={}&page={}'.format(baseSearch, 
                        uploadDate, brainRegions[brainRegionNo], cellTypes[cellTypeNo], maxNo, i)
                    
            nmoTextDF = pd.read_json(searchURL)
            dataFrame = json_normalize(nmoTextDF['_embedded']['neuronResources'])

            nNeuronResources = len(dataFrame.index)
            
            cellsDF, cellsDfIndex = append_data_frame(cellsDF, dataFrame, brainRegions[brainRegionNo], cellTypes[cellTypeNo],
                                                      nNeuronResources, nBrainRegions2Save, nCellTypes2Save, cellsDfIndex)
                                                      
save_cells_data_frame(cellsDF)

print '\nFinis.\n'
