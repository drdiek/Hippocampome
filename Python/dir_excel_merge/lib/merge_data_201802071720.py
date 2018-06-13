def merge_data_files(dataFrame1, dataFrame2):

    import pandas as pd

    N = len(dataFrame1.index)
    dataFrameMerged = dataFrame1
    
    dfHCID1 = pd.DataFrame(index = range(N), columns = ['HCID1'])
    dfHCID2 = pd.DataFrame(index = range(N), columns = ['HCID2'])
    dfHCIDboth = pd.DataFrame(index = range(N), columns = ['HCIDboth'])
    dfExclusion1 = pd.DataFrame(index = range(N), columns = ['Exclusion1'])
    dfExclusion2 = pd.DataFrame(index = range(N), columns = ['Exclusion2'])
    dfExclusionboth = pd.DataFrame(index = range(N), columns = ['Exclusionboth'])

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
            isIntHCID1 = int(dataFrame1['Hippocampome_ID'].loc[i])
        except ValueError:
            pass # dataFrame1['Hippocampome_ID'].loc[i] is a string or a NaN
        try:
            isIntHCID2 = int(dataFrame2['Hippocampome_ID'].loc[i])
        except ValueError:
            pass # dataFrame1['Hippocampome_ID'].loc[i] is a string or a NaN
            
        if isIntHCID1 and not isIntHCID2:
            if pd.isnull(dataFrame2['Hippocampome_ID'].loc[i]):
                dataFrameMerged['Hippocampome_ID'].loc[i] = dataFrame1['Hippocampome_ID'].loc[i]
                print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} HC ID {:.0f}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1['Hippocampome_ID'].loc[i])
                #dfHCID1['HCID1'].loc[nHCID1] = i+1
                dfHCID1.loc[nHCID1, 'HCID1'] = i+1
                nHCID1 += 1
            else: # dataFrame2['Hippocampome_ID'].loc[i] is a string
                print 'At line #{:d} NMO ID {:d} the Hippocampome ID for dataFile#1 is {:.0f} and the Hippocampome ID for dataFile#2 is {}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1['Hippocampome_ID'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                dataFrameMerged['Hippocampome_ID'].loc[i] = '{:.0f}; {}'.format(dataFrame1['Hippocampome_ID'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                #dfHCIDboth['HCIDboth'].loc[nHCIDboth] = i+1
                dfHCIDboth.loc[nHCIDboth, 'HCIDboth'] = i+1
                nHCIDboth += 1
        elif not isIntHCID1 and isIntHCID2:
            if pd.isnull(dataFrame1['Hippocampome_ID'].loc[i]):
                dataFrameMerged['Hippocampome_ID'].loc[i] = dataFrame2['Hippocampome_ID'].loc[i]
                print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} HC ID {:.0f}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                #dfHCID2['HCID2'].loc[nHCID2] = i+1
                dfHCID2.loc[nHCID2, 'HCID2'] = i+1
                nHCID2 += 1
            else: # dataFrame1['Hippocampome_ID'].loc[i] is a string
                print 'At line #{:d} NMO ID {:d} the Hippocampome ID for dataFile#1 is {} and the Hippocampome ID for dataFile#2 is {:.0f}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1['Hippocampome_ID'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                dataFrameMerged['Hippocampome_ID'].loc[i] = '{}; {:.0f}'.format(dataFrame1['Hippocampome_ID'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                #dfHCIDboth['HCIDboth'].loc[nHCIDboth] = i+1
                dfHCIDboth.loc[nHCIDboth, 'HCIDboth'] = i+1
                nHCIDboth += 1
        elif not isIntHCID1 and not isIntHCID2:
            if not pd.isnull(dataFrame1['Hippocampome_ID'].loc[i]) and pd.isnull(dataFrame2['Hippocampome_ID'].loc[i]):
                dataFrameMerged['Hippocampome_ID'].loc[i] = dataFrame1['Hippocampome_ID'].loc[i]
                print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} HC ID {}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1['Hippocampome_ID'].loc[i])
                #dfHCID1['HCID1'].loc[nHCID1] = i+1
                dfHCID1.loc[nHCID1, 'HCID1'] = i+1
                nHCID1 += 1
            elif pd.isnull(dataFrame1['Hippocampome_ID'].loc[i]) and not pd.isnull(dataFrame2['Hippocampome_ID'].loc[i]):
                dataFrameMerged['Hippocampome_ID'].loc[i] = dataFrame2['Hippocampome_ID'].loc[i]
                print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} HC ID {}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                #dfHCID2['HCID2'].loc[nHCID2] = i+1
                dfHCID2.loc[nHCID2, 'HCID2'] = i+1
                nHCID2 += 1
            elif not pd.isnull(dataFrame1['Hippocampome_ID'].loc[i]) and not pd.isnull(dataFrame2['Hippocampome_ID'].loc[i]):
                if dataFrame1['Hippocampome_ID'].loc[i] != dataFrame2['Hippocampome_ID'].loc[i]:
                    print 'At line #{:d} NMO ID {:d} the Hippocampome ID for dataFile#1 is {} and the Hippocampome ID for dataFile#2 is {}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1['Hippocampome_ID'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                    dataFrameMerged['Hippocampome_ID'].loc[i] = '{}; {}'.format(dataFrame1['Hippocampome_ID'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                    #dfHCIDboth['HCIDboth'].loc[nHCIDboth] = i+1
                    dfHCIDboth.loc[nHCIDboth, 'HCIDboth'] = i+1
                    nHCIDboth += 1
        else: # both dataFrame1['Hippocampome_ID'].loc[i] and dataFrame2['Hippocampome_ID'].loc[i] are finite numbers not NaN's or character strings
            if dataFrame1['Hippocampome_ID'].loc[i] != dataFrame2['Hippocampome_ID'].loc[i]:
                if not pd.isnull(dataFrame1['Hippocampome_ID'].loc[i]) and pd.isnull(dataFrame2['Hippocampome_ID'].loc[i]):
                    dataFrameMerged['Hippocampome_ID'].loc[i] = dataFrame1['Hippocampome_ID'].loc[i]
                    print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} HC ID {:.0f}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1['Hippocampome_ID'].loc[i])
                    #dfHCID1['HCID1'].loc[nHCID1] = i+1
                    dfHCID1.loc[nHCID1, 'HCID1'] = i+1
                    nHCID1 += 1
                elif pd.isnull(dataFrame1['Hippocampome_ID'].loc[i]) and not pd.isnull(dataFrame2['Hippocampome_ID'].loc[i]):
                    dataFrameMerged['Hippocampome_ID'].loc[i] = dataFrame2['Hippocampome_ID'].loc[i]
                    print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} HC ID {:.0f}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                    #dfHCID2['HCID2'].loc[nHCID2] = i+1
                    dfHCID2.loc[nHCID2, 'HCID2'] = i+1
                    nHCID2 += 1
                elif not pd.isnull(dataFrame1['Hippocampome_ID'].loc[i]) and not pd.isnull(dataFrame2['Hippocampome_ID'].loc[i]):
                    print 'At line #{:d} NMO ID {:d} the Hippocampome ID for dataFile#1 is {:.0f} and the Hippocampome ID for dataFile#2 is {:.0f}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1['Hippocampome_ID'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                    dataFrameMerged['Hippocampome_ID'].loc[i] = '{:.0f}; {:.0f}'.format(dataFrame1['Hippocampome_ID'].loc[i], dataFrame2['Hippocampome_ID'].loc[i])
                    #dfHCIDboth['HCIDboth'].loc[nHCIDboth] = i+1
                    dfHCIDboth.loc[nHCIDboth, 'HCIDboth'] = i+1
                    nHCIDboth += 1
            
        if not pd.isnull(dataFrame1['reason_for_exclusion'].loc[i]) and pd.isnull(dataFrame2['reason_for_exclusion'].loc[i]):
            dataFrameMerged['reason_for_exclusion'].loc[i] = dataFrame1['reason_for_exclusion'].loc[i]
            print 'Data from file #1 was added to the output file: line {:d} NMO ID {:d} exclusion {}'.format(i+1, dataFrame1['neuron_id'].loc[i], dataFrame1['reason_for_exclusion'].loc[i])
            #dfExclusion1['Exclusion1'].loc[nExclusion1]= i+1
            dfExclusion1.loc[nExclusion1, 'Exclusion1'] = i+1
            nExclusion1 += 1
        elif pd.isnull(dataFrame1['reason_for_exclusion'].loc[i]) and not pd.isnull(dataFrame2['reason_for_exclusion'].loc[i]):
            dataFrameMerged['reason_for_exclusion'].loc[i] = dataFrame2['reason_for_exclusion'].loc[i]
            print 'Data from file #2 was added to the output file: line {:d} NMO ID {:d} exclusion {}'.format(i+1, dataFrame2['neuron_id'].loc[i], dataFrame2['reason_for_exclusion'].loc[i])
            #dfExclusion2['Exclusion2'].loc[nExclusion2]= i+1
            dfExclusion2.loc[nExclusion2, 'Exclusion2'] = i+1
            nExclusion2 += 1
        elif not pd.isnull(dataFrame1['reason_for_exclusion'].loc[i]) and not pd.isnull(dataFrame2['reason_for_exclusion'].loc[i]):
            if dataFrame1['reason_for_exclusion'].loc[i] != dataFrame2['reason_for_exclusion'].loc[i]:
                print 'At line #{:d} NMO ID {:d} the exclusion for dataFile#1 is {} and the exclusion for dataFile#2 is {}'.format(i+1, dataFrameMerged['neuron_id'].loc[i], dataFrame1['reason_for_exclusion'].loc[i], dataFrame2['reason_for_exclusion'].loc[i])
                dataFrameMerged['reason_for_exclusion'].loc[i] = '{}; {}'.format(dataFrame1['reason_for_exclusion'].loc[i], dataFrame2['reason_for_exclusion'].loc[i])
                #dfExclusionboth['Exclusionboth'].loc[nExclusionboth]= i+1
                dfExclusionboth.loc[nExclusionboth, 'Exclusionboth'] = i+1
                nExclusionboth += 1

    dfHCID1 = dfHCID1.loc[:nHCID1]
    dfHCID2 = dfHCID2.loc[:nHCID2]
    dfHCIDboth = dfHCIDboth.loc[:nHCIDboth]
    dfExclusion1 = dfExclusion1.loc[:nExclusion1]
    dfExclusion2 = dfExclusion2.loc[:nExclusion2]
    dfExclusionboth = dfExclusionboth.loc[:nExclusionboth]

    return (dataFrameMerged, dfHCID1, dfHCID2, dfHCIDboth, dfExclusion1, dfExclusion2, dfExclusionboth)