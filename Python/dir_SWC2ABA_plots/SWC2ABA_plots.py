import pandas as pd

from lib.select_csv import select_file_csv
from lib.plot_morphology import plot_morphology_matrix

csvFileName = select_file_csv()
if (csvFileName == '!'):
    exit()

if (csvFileName.find('ARA') > -1):
    plotLabel = 'ARA_Old'
else:
    plotLabel = 'Atlas_V3'
    
morphologyDF = pd.read_csv(csvFileName)

plot_morphology_matrix(morphologyDF, plotLabel)