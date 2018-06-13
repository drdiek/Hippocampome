def merge_data_files(dataFrame1, dataFrame2):

    import pandas as pd

    N = len(dataFrame1.index)
    dataFrameMerged = dataFrame1
    
    dfSTID1 = pd.DataFrame(index = range(N), columns = ['STID1'])
    dfSTID2 = pd.DataFrame(index = range(N), columns = ['STID2'])
    dfSTIDboth = pd.DataFrame(index = range(N), columns = ['STIDboth'])
    dfHCID1 = pd.DataFrame(index = range(N), columns = ['HCID1'])
    dfHCID2 = pd.DataFrame(index = range(N), columns = ['HCID2'])
    dfHCIDboth = pd.DataFrame(index = range(N), columns = ['HCIDboth'])
    dfExclusion1 = pd.DataFrame(index = range(N), columns = ['Exclusion1'])
    dfExclusion2 = pd.DataFrame(index = range(N), columns = ['Exclusion2'])
    dfExclusionboth = pd.DataFrame(index = range(N), columns = ['Exclusionboth'])

    nSTID1 = 0
    nSTID2 = 0
    nSTIDboth = 0
    nHCID1 = 0
    nHCID2 = 0
    nHCIDboth = 0
    nExclusion1 = 0
    nExclusion2 = 0
    nExclusionboth = 0
    
    for i in range(N):
        isIntHCID1 = 0
        isIntHCID2 = 0
     
        try:
            isIntHCID1 = int(dataFrame1.loc[i, 'Hippocampome_ID'])
        except ValueError:
            pass # dataFrame1.loc[i, 'Hippocampome_ID'] is a string or a NaN
        try:
            isIntHCID2 = int(dataFrame2.loc[i, 'Hippocampome_ID'])
        except ValueError:
            pass # dataFrame1.loc[i, 'Hippocampome_ID'] is a string or a NaN
            
        # compare and combine data from 'Hippocampome_ID' column
        if isIntHCID1 and not isIntHCID2:
            if pd.isnull(dataFrame2.loc[i, 'Hippocampome_ID']):
                dataFrameMerged.loc[i, 'Hippocampome_ID'] = dataFrame1.loc[i, 'Hippocampome_ID']
                print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} HC ID {:.0f}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1.loc[i, 'Hippocampome_ID'])
                dfHCID1.loc[nHCID1, 'HCID1'] = i+1
                nHCID1 += 1
            else: # dataFrame2.loc[i, 'Hippocampome_ID'] is a string
                print 'At line #{:d} NMO ID {:d} the Hippocampome ID for dataFile#1 is {:.0f} and the Hippocampome ID for dataFile#2 is {}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1.loc[i, 'Hippocampome_ID'], dataFrame2.loc[i, 'Hippocampome_ID'])
                dataFrameMerged.loc[i, 'Hippocampome_ID'] = '{:.0f}; {}'.format(dataFrame1.loc[i, 'Hippocampome_ID'], dataFrame2.loc[i, 'Hippocampome_ID'])
                dfHCIDboth.loc[nHCIDboth, 'HCIDboth'] = i+1
                nHCIDboth += 1
        elif not isIntHCID1 and isIntHCID2:
            if pd.isnull(dataFrame1.loc[i, 'Hippocampome_ID']):
                dataFrameMerged.loc[i, 'Hippocampome_ID'] = dataFrame2.loc[i, 'Hippocampome_ID']
                print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} HC ID {:.0f}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2.loc[i, 'Hippocampome_ID'])
                dfHCID2.loc[nHCID2, 'HCID2'] = i+1
                nHCID2 += 1
            else: # dataFrame1.loc[i, 'Hippocampome_ID'] is a string
                print 'At line #{:d} NMO ID {:d} the Hippocampome ID for dataFile#1 is {} and the Hippocampome ID for dataFile#2 is {:.0f}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1.loc[i, 'Hippocampome_ID'], dataFrame2.loc[i, 'Hippocampome_ID'])
                dataFrameMerged.loc[i, 'Hippocampome_ID'] = '{}; {:.0f}'.format(dataFrame1.loc[i, 'Hippocampome_ID'], dataFrame2.loc[i, 'Hippocampome_ID'])
                dfHCIDboth.loc[nHCIDboth, 'HCIDboth'] = i+1
                nHCIDboth += 1
        elif not isIntHCID1 and not isIntHCID2:
            if not pd.isnull(dataFrame1.loc[i, 'Hippocampome_ID']) and pd.isnull(dataFrame2.loc[i, 'Hippocampome_ID']):
                dataFrameMerged.loc[i, 'Hippocampome_ID'] = dataFrame1.loc[i, 'Hippocampome_ID']
                print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} HC ID {}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1.loc[i, 'Hippocampome_ID'])
                dfHCID1.loc[nHCID1, 'HCID1'] = i+1
                nHCID1 += 1
            elif pd.isnull(dataFrame1.loc[i, 'Hippocampome_ID']) and not pd.isnull(dataFrame2.loc[i, 'Hippocampome_ID']):
                dataFrameMerged.loc[i, 'Hippocampome_ID'] = dataFrame2.loc[i, 'Hippocampome_ID']
                print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} HC ID {}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2.loc[i, 'Hippocampome_ID'])
                dfHCID2.loc[nHCID2, 'HCID2'] = i+1
                nHCID2 += 1
            elif not pd.isnull(dataFrame1.loc[i, 'Hippocampome_ID']) and not pd.isnull(dataFrame2.loc[i, 'Hippocampome_ID']):
                if dataFrame1.loc[i, 'Hippocampome_ID'] != dataFrame2.loc[i, 'Hippocampome_ID']:
                    print 'At line #{:d} NMO ID {:d} the Hippocampome ID for dataFile#1 is {} and the Hippocampome ID for dataFile#2 is {}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1.loc[i, 'Hippocampome_ID'], dataFrame2.loc[i, 'Hippocampome_ID'])
                    dataFrameMerged.loc[i, 'Hippocampome_ID'] = '{}; {}'.format(dataFrame1.loc[i, 'Hippocampome_ID'], dataFrame2.loc[i, 'Hippocampome_ID'])
                    dfHCIDboth.loc[nHCIDboth, 'HCIDboth'] = i+1
                    nHCIDboth += 1
        else: # both dataFrame1.loc[i, 'Hippocampome_ID'] and dataFrame2.loc[i, 'Hippocampome_ID'] are finite numbers not NaN's or character strings
            if dataFrame1.loc[i, 'Hippocampome_ID'] != dataFrame2.loc[i, 'Hippocampome_ID']:
                if not pd.isnull(dataFrame1.loc[i, 'Hippocampome_ID']) and pd.isnull(dataFrame2.loc[i, 'Hippocampome_ID']):
                    dataFrameMerged.loc[i, 'Hippocampome_ID'] = dataFrame1.loc[i, 'Hippocampome_ID']
                    print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} HC ID {:.0f}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1.loc[i, 'Hippocampome_ID'])
                    dfHCID1.loc[nHCID1, 'HCID1'] = i+1
                    nHCID1 += 1
                elif pd.isnull(dataFrame1.loc[i, 'Hippocampome_ID']) and not pd.isnull(dataFrame2.loc[i, 'Hippocampome_ID']):
                    dataFrameMerged.loc[i, 'Hippocampome_ID'] = dataFrame2.loc[i, 'Hippocampome_ID']
                    print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} HC ID {:.0f}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2.loc[i, 'Hippocampome_ID'])
                    dfHCID2.loc[nHCID2, 'HCID2'] = i+1
                    nHCID2 += 1
                elif not pd.isnull(dataFrame1.loc[i, 'Hippocampome_ID']) and not pd.isnull(dataFrame2.loc[i, 'Hippocampome_ID']):
                    print 'At line #{:d} NMO ID {:d} the Hippocampome ID for dataFile#1 is {:.0f} and the Hippocampome ID for dataFile#2 is {:.0f}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1.loc[i, 'Hippocampome_ID'], dataFrame2.loc[i, 'Hippocampome_ID'])
                    dataFrameMerged.loc[i, 'Hippocampome_ID'] = '{:.0f}; {:.0f}'.format(dataFrame1.loc[i, 'Hippocampome_ID'], dataFrame2.loc[i, 'Hippocampome_ID'])
                    dfHCIDboth.loc[nHCIDboth, 'HCIDboth'] = i+1
                    nHCIDboth += 1
        
        # compare and combine data from 'reason_for_exclusion' column    
        if not pd.isnull(dataFrame1.loc[i, 'reason_for_exclusion']) and pd.isnull(dataFrame2.loc[i, 'reason_for_exclusion']):
            dataFrameMerged.loc[i, 'reason_for_exclusion'] = dataFrame1.loc[i, 'reason_for_exclusion']
            print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} exclusion {}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1.loc[i, 'reason_for_exclusion'])
            dfExclusion1.loc[nExclusion1, 'Exclusion1'] = i+1
            nExclusion1 += 1
        elif pd.isnull(dataFrame1.loc[i, 'reason_for_exclusion']) and not pd.isnull(dataFrame2.loc[i, 'reason_for_exclusion']):
            dataFrameMerged.loc[i, 'reason_for_exclusion'] = dataFrame2.loc[i, 'reason_for_exclusion']
            print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} exclusion {}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2.loc[i, 'reason_for_exclusion'])
            dfExclusion2.loc[nExclusion2, 'Exclusion2'] = i+1
            nExclusion2 += 1
        elif not pd.isnull(dataFrame1.loc[i, 'reason_for_exclusion']) and not pd.isnull(dataFrame2.loc[i, 'reason_for_exclusion']):
            if dataFrame1.loc[i, 'reason_for_exclusion'] != dataFrame2.loc[i, 'reason_for_exclusion']:
                print 'At line #{:d} NMO ID {:d} the exclusion for dataFile#1 is {} and the exclusion for dataFile#2 is {}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1.loc[i, 'reason_for_exclusion'], dataFrame2.loc[i, 'reason_for_exclusion'])
                dataFrameMerged.loc[i, 'reason_for_exclusion'] = '{}; {}'.format(dataFrame1.loc[i, 'reason_for_exclusion'], dataFrame2.loc[i, 'reason_for_exclusion'])
                dfExclusionboth.loc[nExclusionboth, 'Exclusionboth'] = i+1
                nExclusionboth += 1

        # compare and combine data from 'Supertype_ID' column    
        if not pd.isnull(dataFrame1.loc[i, 'Supertype_ID']) and pd.isnull(dataFrame2.loc[i, 'Supertype_ID']):
            dataFrameMerged.loc[i, 'Supertype_ID'] = dataFrame1.loc[i, 'Supertype_ID']
            print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} Supertype ID {}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1.loc[i, 'Supertype_ID'])
            dfSTID1.loc[nSTID1, 'STID1'] = i+1
            nSTID1 += 1
        elif pd.isnull(dataFrame1.loc[i, 'Supertype_ID']) and not pd.isnull(dataFrame2.loc[i, 'Supertype_ID']):
            dataFrameMerged.loc[i, 'Supertype_ID'] = dataFrame2.loc[i, 'Supertype_ID']
            print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} Supertype ID {}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2.loc[i, 'Supertype_ID'])
            dfSTID2.loc[nSTID2, 'STID2'] = i+1
            nSTID2 += 1
        elif not pd.isnull(dataFrame1.loc[i, 'Supertype_ID']) and not pd.isnull(dataFrame2.loc[i, 'Supertype_ID']):
            if dataFrame1.loc[i, 'Supertype_ID'] != dataFrame2.loc[i, 'Supertype_ID']:
                print 'At line #{:d} NMO ID {:d} the Supertype ID for dataFile#1 is {} and the Supertype ID for dataFile#2 is {}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1.loc[i, 'Supertype_ID'], dataFrame2.loc[i, 'Supertype_ID'])
                dataFrameMerged.loc[i, 'Supertype_ID'] = '{}; {}'.format(dataFrame1.loc[i, 'Supertype_ID'], dataFrame2.loc[i, 'Supertype_ID'])
                dfSTIDboth.loc[nSTIDboth, 'STIDboth'] = i+1
                nSTIDboth += 1

    dfSTID1 = dfSTID1.loc[:nSTID1-1]
    dfSTID2 = dfSTID2.loc[:nSTID2-1]
    dfSTIDboth = dfSTIDboth.loc[:nSTIDboth-1]
    dfHCID1 = dfHCID1.loc[:nHCID1-1]
    dfHCID2 = dfHCID2.loc[:nHCID2-1]
    dfHCIDboth = dfHCIDboth.loc[:nHCIDboth-1]
    dfExclusion1 = dfExclusion1.loc[:nExclusion1-1]
    dfExclusion2 = dfExclusion2.loc[:nExclusion2-1]
    dfExclusionboth = dfExclusionboth.loc[:nExclusionboth-1]

    return (dataFrameMerged, dfHCID1, dfHCID2, dfHCIDboth, dfExclusion1, dfExclusion2, dfExclusionboth, dfSTID1, dfSTID2, dfSTIDboth)