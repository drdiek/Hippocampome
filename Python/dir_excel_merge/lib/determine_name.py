def determine_merged_file_name(fileName1, fileName2):

    import datetime
    
    fileNameMerged = ''
    i = 0
    while fileName1[i] == fileName2[i]:
        i += 1        
    if fileName1[i-1] == '_':
        i -= 1
    fileNameMerged = fileName1[0:i]

    today = datetime.datetime.now()
    timeStampStr = ['{}'.format(today.year), \
                    '{:0>2}'.format(today.month), \
                    '{:0>2}'.format(today.day), \
                    '{:0>2}'.format(today.hour), \
                    '{:0>2}'.format(today.minute)]
    timeStampStr = ''.join(timeStampStr)

    fileNameMerged = './output/{}_merged_{}.xlsx'.format(fileNameMerged, timeStampStr)
    
    return(fileNameMerged)