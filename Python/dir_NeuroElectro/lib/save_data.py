def save_data_file(dataFrame, fileName):

    import pandas as pd
    import pandas.io.formats.excel
    import datetime
    
    print '\nsaving data ...'

    pandas.io.formats.excel.header_style = None    

    fileNameFull = fileName[0:-4]

    today = datetime.datetime.now()
    timeStampStr = ['{}'.format(today.year), \
                    '{:0>2}'.format(today.month), \
                    '{:0>2}'.format(today.day), \
                    '{:0>2}'.format(today.hour), \
                    '{:0>2}'.format(today.minute)]
    timeStampStr = ''.join(timeStampStr)

    fileNameFull = './output/{}_merged_{}.xlsx'.format(fileNameFull, timeStampStr)
    
    writer = pd.ExcelWriter(fileNameFull, engine='xlsxwriter')

    dataFrame.to_excel(writer, index=False, sheet_name='Sheet1')
    
    workbook = writer.book
    worksheet = writer.sheets['Sheet1']
    
    format = workbook.add_format()
    format.set_align('left')
    format.set_bold(True)
    worksheet.set_row(0, None, format)
