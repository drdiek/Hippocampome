def data_frame_header(nBrainRegions2Save, nCellTypes2Save, nNeuronResourcesMax):

    import pandas as pd
    
    headerCols = ['Hippocampome_ID',
                  'reason_for_exclusion',
                  'Supertype_ID',
                  'neuron_id',
                  'neuron_name',
                  'archive',
                  'note',
                  'age_classification']
    for i in range(1,nBrainRegions2Save+1):
        strng = 'brain_region_{}'.format(i)
        headerCols.append(strng)
    for i in range(1,nCellTypes2Save+1):
        strng = 'cell_type_{}'.format(i)
        headerCols.append(strng)
    
    headerCols.append('species')
    headerCols.append('strain')              
    headerCols.append('scientific_name')
    headerCols.append('stain')
    headerCols.append('experiment_condition')
    headerCols.append('protocol')
    headerCols.append('slicing_direction')
    headerCols.append('reconstruction_software')
    headerCols.append('objective_type')
    headerCols.append('original_format')
    headerCols.append('domain')
    headerCols.append('attributes')
    headerCols.append('magnification')
    headerCols.append('upload_date')
    headerCols.append('deposition_date')
    headerCols.append('shrinkage_reported')
    headerCols.append('shrinkage_corrected')
    headerCols.append('reported_value')
    headerCols.append('reported_xy')
    headerCols.append('reported_z')
    headerCols.append('corrected_value')
    headerCols.append('corrected_xy')
    headerCols.append('corrected_z')
    headerCols.append('soma_surface')
    headerCols.append('surface')
    headerCols.append('volume')
    headerCols.append('slicing_thickness')
    headerCols.append('min_age')
    headerCols.append('max_age')
    headerCols.append('min_weight')
    headerCols.append('max_weight')
    headerCols.append('png_url')
    headerCols.append('reference_pmid')
    headerCols.append('reference_doi')
    headerCols.append('physical_Integrity')
    headerCols.append('x0x5F_links')
                  
    cellsDF = pd.DataFrame(index=range(nNeuronResourcesMax), columns=headerCols)
    
    return cellsDF
