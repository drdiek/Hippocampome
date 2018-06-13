def find_unique_PMIDs(dfOldPMIDs, dfNewPMIDs):

    import pandas as pd
#     import numpy as np
    
#     dfUniquePMIDs = dfNewPMIDs
#     i = 0

    dfUniquePMIDs = dfNewPMIDs[~dfNewPMIDs.isin(dfOldPMIDs.values)].reset_index(drop=True)
    
#     for j in range(len(dfNewPMIDs.index)):
#     
#         newPMID = dfNewPMIDs.loc[j]
#         print newPMID
#     
#         if dfNewPMIDs.loc[j].isin(dfOldPMIDs):
# #         if ~dfNewPMIDs.loc[j, 'PMID/ISBN'].isin(dfOldPMIDs):
# 
#             dfUniquePMIDs.loc[i, 'PMID/ISBN'] = dfNewPMIDs.loc[j, 'PMID/ISBN']
#             i += 1
#     
#     IDs = dfUniquePMIDs.loc[0:i, 'PMID/ISBN']
# 
#     print IDs
#     
#     for newPMID in newPMIDs:
# 
#         if newPMID not in oldPMIDs:
#     
#             uniquePMIDs[i] = newPMID
#             i = i + 1
# 
#     IDs = uniquePMIDs[0:i]
# 
#     dfAllPMIDs = dfOldPMIDs.append(dfNewPMIDs)
#     i = len(dfAllPMIDs.index)
#     
#     print i
# 
#     arrayPMIDs = np.array(dfAllPMIDs.unique())
#     
#     listPMIDs = arrayPMIDs.tolist()
#     
#     dfUniquePMIDs = dfNewPMIDs[~dfNewPMIDs['PMID/ISBN'].isin(dfOldPMIDs['pmid_isbn'].values)]
#     
#     print dfUniquePMIDs
#     
# #     dfUniquePMIDs = pd.DataFrame({'pmid_isbn':range(len(listPMIDs))})
# #     
# #     dfUniquePMIDs['pmid_isbn'] = pd.Series(listPMIDs, index = dfUniquePMIDs.index[:len(listPMIDs)])
    
    return(dfUniquePMIDs)
