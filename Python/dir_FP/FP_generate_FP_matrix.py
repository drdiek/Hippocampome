import csv

from file_functions import load_csv
from file_functions import write_csv

from diek_functions import size2x2
from diek_functions import pause
from diek_functions import time_stamp

print

namesFileName = "data/neuron_type_names.csv"

namesMatrix = load_csv(namesFileName)
	
nNamesRows, nNamesColumns = size2x2(namesMatrix)

nNames = nNamesRows - 1 # account for names header row
        
namesHeaderRowNo = 0 # python indexing starts at zero

namesCellIdColumnNo = 3 # python indexing starts at zero

nNamesHeaderRows = 1

nNamesHeaderColumns = 6

    
patternsFileName = "data/FP_patterns.csv"

patternsMatrix = load_csv(patternsFileName)

nPatternsRows, nPatternsColumns = size2x2(patternsMatrix)

nPatterns = nPatternsColumns

patternsHeaderRowNo = 0 # python indexing starts at zero


namesByPatternsMatrix = [[0 for j in range(nPatterns)] for i in range(nNames)] # initialize matrix to zeros

parametersFileName = "data/FP_parameters.csv"

parametersMatrix = load_csv(parametersFileName)

nParametersRows, nParametersColumns = size2x2(parametersMatrix)

nParameters = nParametersColumns - 1 # do not count parameters header column

parametersUniqueIdRowNo = 2 # python indexing starts at zero

parametersFiringPatternRowNo = 16 # python indexing starts at zero


for iNamesRowNo in range(1, nNames+1): # account for names header row
    
    namesCellId = namesMatrix[iNamesRowNo][namesCellIdColumnNo]


    for jParametersColumnNo in range(1, nParameters+1): # account for parameters header column
        

        parametersUniqueId = parametersMatrix[parametersUniqueIdRowNo][jParametersColumnNo]
        
        parametersFiringPattern = parametersMatrix[parametersFiringPatternRowNo][jParametersColumnNo]
        
        
        if parametersUniqueId == namesCellId:
            
            
            for jPatternsColumnNo in range(nPatterns):
                
                patternsFiringPattern = patternsMatrix[patternsHeaderRowNo][jPatternsColumnNo]
                
                
                if parametersFiringPattern == patternsFiringPattern:
                    
                    namesByPatternsMatrix[iNamesRowNo-1][jPatternsColumnNo] += 1 # account for names header row

                    
outputFileNameBase = "output/FP_csv_output/FP_matrix"

timeStampStr = time_stamp()

outputFileName = "{0}_{1}.csv".format(outputFileNameBase, timeStampStr)

with open(outputFileName, "w") as filePointer:

    csvMatrix = csv.writer(filePointer)
    
    outputRow = []
    
    for jOutputNamesHeaderColumnNo in range(nNamesHeaderColumns):       
        outputRow.append(namesMatrix[namesHeaderRowNo][jOutputNamesHeaderColumnNo].encode("utf-8"))
    
    for jOutputPatternsHeaderColumnNo in range(nPatterns-1): # omit *No_data column
        outputRow.append(patternsMatrix[patternsHeaderRowNo][jOutputPatternsHeaderColumnNo].encode("utf-8"))
    
    csvMatrix.writerow(outputRow)
    
    for iOutputNamesRowNo in range(nNames):    
        outputRow = []
    
        for jOutputNamesHeaderColumnNo in range(nNamesHeaderColumns):
            outputRow.append(namesMatrix[iOutputNamesRowNo+1][jOutputNamesHeaderColumnNo].encode("utf-8")) # account for names header row
    
        for jOutputPatternsColumnNo in range(nPatterns-1): # omit *No_data column
            outputRow.append(str(namesByPatternsMatrix[iOutputNamesRowNo][jOutputPatternsColumnNo]).encode("utf-8"))
            
        csvMatrix.writerow(outputRow)

filePointer.close()
