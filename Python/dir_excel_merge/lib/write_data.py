def write_data_file(dataFrame, dfHCID1, dfHCID2, dfHCIDboth, dfExclusion1, dfExclusion2, dfExclusionboth, dfSTID1, dfSTID2, dfSTIDboth, fileName):

    import pandas as pd
    import pandas.io.formats.excel
    pandas.io.formats.excel.header_style = None    
    
    writer = pd.ExcelWriter(fileName, engine='xlsxwriter')

    dataFrame.to_excel(writer, index=False, sheet_name='NMO2HC')
    
    workbook = writer.book
    worksheet = writer.sheets['NMO2HC']
    
    format = workbook.add_format()
    format.set_align('left')
    format.set_bold(True)
    worksheet.set_row(0, None, format)
    
    cellStrNo = ''
    
    for i in range(len(dfHCID1.index)):
        cellNoStr = 'A{}'.format(dfHCID1.loc[i, 'HCID1']+1)
        format = workbook.add_format()
        format.set_bg_color('#FF6600')
        worksheet.write(cellNoStr, dataFrame.loc[dfHCID1.loc[i, 'HCID1']-1, 'Hippocampome_ID'], format)
        
    for i in range(len(dfHCID2.index)):
        cellNoStr = 'A{}'.format(dfHCID2.loc[i, 'HCID2']+1)
        format = workbook.add_format()
        format.set_bg_color('#FFFF00')
        worksheet.write(cellNoStr, dataFrame.loc[dfHCID2.loc[i, 'HCID2']-1, 'Hippocampome_ID'], format)
        
    for i in range(len(dfHCIDboth.index)):
        cellNoStr = 'A{}'.format(dfHCIDboth.loc[i, 'HCIDboth']+1)
        format = workbook.add_format()
        format.set_bg_color('#FF0000')
        worksheet.write(cellNoStr, dataFrame.loc[dfHCIDboth.loc[i, 'HCIDboth']-1, 'Hippocampome_ID'], format)
        
    for i in range(len(dfExclusion1.index)):
        cellNoStr = 'B{}'.format(dfExclusion1.loc[i, 'Exclusion1']+1)
        format = workbook.add_format()
        format.set_bg_color('#FF6600')
        worksheet.write(cellNoStr, dataFrame.loc[dfExclusion1.loc[i, 'Exclusion1']-1, 'reason_for_exclusion'], format)
        
    for i in range(len(dfExclusion2.index)):
        cellNoStr = 'B{}'.format(dfExclusion2.loc[i, 'Exclusion2']+1)
        format = workbook.add_format()
        format.set_bg_color('#FFFF00')
        worksheet.write(cellNoStr, dataFrame.loc[dfExclusion2.loc[i, 'Exclusion2']-1, 'reason_for_exclusion'], format)
        
    for i in range(len(dfExclusionboth.index)):
        cellNoStr = 'B{}'.format(dfExclusionboth.loc[i, 'Exclusionboth']+1)
        format = workbook.add_format()
        format.set_bg_color('#FF0000')
        worksheet.write(cellNoStr, dataFrame.loc[dfExclusionboth.loc[i, 'Exclusionboth']-1, 'reason_for_exclusion'], format)
        
    for i in range(len(dfSTID1.index)):
        cellNoStr = 'C{}'.format(dfSTID1.loc[i, 'STID1']+1)
        format = workbook.add_format()
        format.set_bg_color('#FF6600')
        worksheet.write(cellNoStr, dataFrame.loc[dfSTID1.loc[i, 'STID1']-1, 'Supertype_ID'], format)
        
    for i in range(len(dfSTID2.index)):
        cellNoStr = 'C{}'.format(dfSTID2.loc[i, 'STID2']+1)
        format = workbook.add_format()
        format.set_bg_color('#FFFF00')
        worksheet.write(cellNoStr, dataFrame.loc[dfSTID2.loc[i, 'STID2']-1, 'Supertype_ID'], format)
        
    for i in range(len(dfSTIDboth.index)):
        cellNoStr = 'C{}'.format(dfSTIDboth.loc[i, 'STIDboth']+1)
        format = workbook.add_format()
        format.set_bg_color('#FF0000')
        worksheet.write(cellNoStr, dataFrame.loc[dfSTIDboth.loc[i, 'STIDboth']-1, 'Supertype_ID'], format)
        
    writer.save()
