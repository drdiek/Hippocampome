import io
import csv

import diek_functions as dww
   
#def read_from_csv(fileName):
#    import pandas as pd
#
#    print "Pandas reading data from csv file %s ...\n" % fileName
#    
##    dataFrame = pd.read_csv(fileName, sep=",", header=None, encoding="UTF-8")
#    dataFrame = pd.read_csv(fileName, sep=",", encoding="UTF-8")
#    
#    return(dataFrame)


def dictRead_from_csv(fileName):

    print "DictReading data from csv file %s ...\n" % fileName
    
    filePointer = io.open(fileName, "rb")
#    with io.open(fileName, "rb") as filePointer:
#        dataDict = list(csv.DictReader(io.TextIOWrapper(filePointer, encoding="UTF-8")))
    dataDict = csv.DictReader(io.TextIOWrapper(filePointer, encoding="UTF-8"))
#    filePointer.close()

#    print [dataDict[i]["HC ordering"] for i in range(len(dataDict))]
#    print
#    print dataDict["Name"]
#    print
#    dww.pause()

    print dataDict
    print
    print [row["Name"] for row in dataDict]
    print

    for row in dataDict:
        print row	
        name = row["Name"]
        print name
    print
    
    idx = [3, 2, 0, 1]
    
    for i in range(0, len(idx)):
        print dataDict[idx[i]]["Name"]
    print
    dww.pause()
    return(dataDict)


def load_csv(fileName):

    print "Reading data from csv file %s ...\n" % fileName

    with open(fileName, "rb") as filePointer:
        csvMatrix = list(csv.reader(filePointer)) # csvMatrix[range(0, nRows)][range(0, nCols)]
    filePointer.close()
    
    return(csvMatrix)
	
	
def write_csv(dataMatrix, outputFileNameBase):

    timeStampStr = dww.time_stamp()
    
#    strList = [outputFileNameBase, "_", timeStampStr, ".csv"]
#    outputFileName = "".join(strList)
    
    outputFileName = "%s_%s.csv" % (outputFileNameBase, timeStampStr)
    
    print "Writing data to csv file %s ...\n" % outputFileName
    
    with open(outputFileName, "wb") as filePointer:
	    csvMatrix = csv.writer(filePointer)	
	    csvMatrix.writerows(dataMatrix)
    filePointer.close()
	
    return()
	

