def write_pubmed_info(dfPubMed):

    import pandas as pd

    import datetime
    
    outputFileNameBase = "./output/article"

    today = datetime.datetime.now()
    timeStampStr = ['{}'.format(today.year), \
                    '{:0>2}'.format(today.month), \
                    '{:0>2}'.format(today.day), \
                    '{:0>2}'.format(today.hour), \
                    '{:0>2}'.format(today.minute)]
    timeStampStr = ''.join(timeStampStr)

    outputFileName = '{}_{}.csv'.format(outputFileNameBase, timeStampStr)
    
    dfPubMed.to_csv(outputFileName, index=False)
