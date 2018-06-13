def parse_neurites(subregion, adPattern, projectionPattern):
    import pandas as pd
    import numpy as np
    import re
    
    import lib.supertypes_constants as c
    
    from lib.encode_supertypes_neurites import encode_neurites
    
    parsedCols = ['DG_A_D', 'CA3_A_D', 'CA2_A_D', 'CA1_A_D', 'SUB_A_D', 'EC_A_D'] 
    neuritesParsedDataFrame = pd.DataFrame(0, index=range(1), columns=parsedCols)
    
    neuritesParsedDataFrame = encode_neurites(subregion, adPattern, neuritesParsedDataFrame)
    
    if projectionPattern == projectionPattern:
        indexUnderscores = [m.start() for m in re.finditer('_', projectionPattern)]
        indexHyphens = [m.start() for m in re.finditer('-', projectionPattern)]
        lenIndexUnderscores = len(indexUnderscores)
        indexStart = 0
        for i in range(lenIndexUnderscores):
            if (i > 0):
                indexStart = indexHyphens[i-1] + 1
            if (i == lenIndexUnderscores-1):
                indexStop = len(projectionPattern)
            else:
                indexStop = indexHyphens[i]
            projectionSubregion = projectionPattern[indexStart:indexUnderscores[i]]
            projectionSubregionPattern = projectionPattern[indexUnderscores[i]+1:indexStop]
            neuritesParsedDataFrame = encode_neurites(projectionSubregion, projectionSubregionPattern,
                                                      neuritesParsedDataFrame)
    
    return(neuritesParsedDataFrame.loc[0])