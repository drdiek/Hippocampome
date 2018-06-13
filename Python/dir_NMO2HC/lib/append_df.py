def append_data_frame(cellsDF, dataFrame, brainRegion, cellType, nNeuronResources, nBrainRegions2Save, nCellTypes2Save, cellsDfIndex):

    import pandas as pd
    
    from pandas.io.json import json_normalize

    print '\nAppending {} {}:{} cells to data frame ...'.format(nNeuronResources, brainRegion, cellType)
    
    for i in range(nNeuronResources):
    
        cellsDF.loc[i+cellsDfIndex]['neuron_id'] = dataFrame.loc[i]['neuron_id']
        cellsDF.loc[i+cellsDfIndex]['neuron_name'] = dataFrame.loc[i]['neuron_name']
        cellsDF.loc[i+cellsDfIndex]['archive'] = dataFrame.loc[i]['archive']
        cellsDF.loc[i+cellsDfIndex]['note'] = dataFrame.loc[i]['note']
        cellsDF.loc[i+cellsDfIndex]['age_classification'] = dataFrame.loc[i]['age_classification']
                
        nBrainRegions = 0
        for brain_region in dataFrame.loc[i]['brain_region']:
            nBrainRegions += 1        
            brainRegionStr = 'brain_region_{}'.format(nBrainRegions)
            cellsDF.loc[i+cellsDfIndex][brainRegionStr] = brain_region
                    
        nCelltypes = 0
        for cell_type in dataFrame.loc[i]['cell_type']:
            nCelltypes += 1        
            celltypeStr = 'cell_type_{}'.format(nCelltypes)
            cellsDF.loc[i+cellsDfIndex][celltypeStr] = cell_type
            
        cellsDF.loc[i+cellsDfIndex]['species'] = dataFrame.loc[i]['species']
        cellsDF.loc[i+cellsDfIndex]['strain'] = dataFrame.loc[i]['strain']
        cellsDF.loc[i+cellsDfIndex]['scientific_name'] = dataFrame.loc[i]['scientific_name']
        cellsDF.loc[i+cellsDfIndex]['stain'] = dataFrame.loc[i]['stain']
        cellsDF.loc[i+cellsDfIndex]['experiment_condition'] = dataFrame.loc[i]['experiment_condition']
        cellsDF.loc[i+cellsDfIndex]['protocol'] = dataFrame.loc[i]['protocol']
        cellsDF.loc[i+cellsDfIndex]['slicing_direction'] = dataFrame.loc[i]['slicing_direction']
        cellsDF.loc[i+cellsDfIndex]['reconstruction_software'] = dataFrame.loc[i]['reconstruction_software']
        cellsDF.loc[i+cellsDfIndex]['objective_type'] = dataFrame.loc[i]['objective_type']
        cellsDF.loc[i+cellsDfIndex]['original_format'] = dataFrame.loc[i]['original_format']
        cellsDF.loc[i+cellsDfIndex]['domain'] = dataFrame.loc[i]['domain']
        cellsDF.loc[i+cellsDfIndex]['attributes'] = dataFrame.loc[i]['attributes']
        cellsDF.loc[i+cellsDfIndex]['magnification'] = dataFrame.loc[i]['magnification']
        cellsDF.loc[i+cellsDfIndex]['upload_date'] = dataFrame.loc[i]['upload_date']
        cellsDF.loc[i+cellsDfIndex]['deposition_date'] = dataFrame.loc[i]['deposition_date']
        cellsDF.loc[i+cellsDfIndex]['shrinkage_reported'] = dataFrame.loc[i]['shrinkage_reported']
        cellsDF.loc[i+cellsDfIndex]['shrinkage_corrected'] = dataFrame.loc[i]['shrinkage_corrected']
        cellsDF.loc[i+cellsDfIndex]['reported_value'] = dataFrame.loc[i]['reported_value']
        cellsDF.loc[i+cellsDfIndex]['reported_xy'] = dataFrame.loc[i]['reported_xy']
        cellsDF.loc[i+cellsDfIndex]['reported_z'] = dataFrame.loc[i]['reported_z']
        cellsDF.loc[i+cellsDfIndex]['corrected_value'] = dataFrame.loc[i]['corrected_value']
        cellsDF.loc[i+cellsDfIndex]['corrected_xy'] = dataFrame.loc[i]['corrected_xy']
        cellsDF.loc[i+cellsDfIndex]['corrected_z'] = dataFrame.loc[i]['corrected_z']
        cellsDF.loc[i+cellsDfIndex]['soma_surface'] = dataFrame.loc[i]['soma_surface']
        cellsDF.loc[i+cellsDfIndex]['surface'] = dataFrame.loc[i]['surface']
        cellsDF.loc[i+cellsDfIndex]['volume'] = dataFrame.loc[i]['volume']
        cellsDF.loc[i+cellsDfIndex]['slicing_thickness'] = dataFrame.loc[i]['slicing_thickness']
        cellsDF.loc[i+cellsDfIndex]['min_age'] = dataFrame.loc[i]['min_age']
        cellsDF.loc[i+cellsDfIndex]['max_age'] = dataFrame.loc[i]['max_age']
        cellsDF.loc[i+cellsDfIndex]['min_weight'] = dataFrame.loc[i]['min_weight']
        cellsDF.loc[i+cellsDfIndex]['max_weight'] = dataFrame.loc[i]['max_weight']
        cellsDF.loc[i+cellsDfIndex]['png_url'] = dataFrame.loc[i]['png_url']
        cellsDF.loc[i+cellsDfIndex]['reference_pmid'] = dataFrame.loc[i]['reference_pmid']
        cellsDF.loc[i+cellsDfIndex]['reference_doi'] = dataFrame.loc[i]['reference_doi']
        cellsDF.loc[i+cellsDfIndex]['physical_Integrity'] = dataFrame.loc[i]['physical_Integrity']
                    
    cellsDfIndex += nNeuronResources
    
    return(cellsDF, cellsDfIndex)
    