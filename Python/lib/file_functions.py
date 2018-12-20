def load_csv(fileName):
    import csv

    print '\nReading data from csv file ...\n'    
    with open(fileName, "rb") as filePointer:
        csvMatrix = csv.reader(filePointer)
        data = list(csvMatrix) # data[range(0, nRows)][range(0, nCols)]
    filePointer.close()
    return(data)


def csv2df(fileName):
    import pandas as pd
    
    print '\nReading data from csv file into a DataFrame ...\n'
    dataFrame = pd.read_csv(fileName);
    return(dataFrame)
	
	
def write_csv(dataMatrix, outputFileNameBase):

    import csv
    
    from diek_functions import time_stamp

    print '\nWriting data to csv file ...\n'
    
    timeStampStr = time_stamp()
    
    strList = ['python_output/', outputFileNameBase, '_', timeStampStr, '.csv']
    
    outputFileName = ''.join(strList)
    
    with open(outputFileName, "wb") as filePointer:

	    csvMatrix = csv.writer(filePointer)
	
	    csvMatrix.writerows(dataMatrix)

    filePointer.close()
	
    return()
	

