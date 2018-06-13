def save_cells_data_frame(cellsDF):

    import pandas as pd
    import pandas.io.formats.excel
    import datetime
    
    print '\nWriting cells DataFrame to file ...'

    pandas.io.formats.excel.header_style = None    

    fileName = 'NMO2HC_update'

    today = datetime.datetime.now()
    timeStampStr = ['{}'.format(today.year), \
                    '{:0>2}'.format(today.month), \
                    '{:0>2}'.format(today.day), \
                    '{:0>2}'.format(today.hour), \
                    '{:0>2}'.format(today.minute)]
    timeStampStr = ''.join(timeStampStr)

    fileNameFull = './output/{}_{}.xlsx'.format(fileName, timeStampStr)
    
    writer = pd.ExcelWriter(fileNameFull, engine='xlsxwriter')

    cellsDF.to_excel(writer, index=False, sheet_name='Sheet1')
    
    workbook = writer.book
    worksheet = writer.sheets['Sheet1']
    
    format = workbook.add_format()
    format.set_align('left')
    format.set_bold(True)
    worksheet.set_row(0, None, format)
