import pandas as pd

from lib.select_file import select_data_file
from lib.read_data import read_data_file
from lib.merge_data import merge_data_files
from lib.determine_name import determine_merged_file_name
from lib.write_data import write_data_file

dataFileName = [None] * 2

dataFileName[0] = select_data_file(1);
if dataFileName[0] == '!':
    exit()
#dataFileName[0] = './data/{}'.format(dataFileName[0])
dataFileName[1] = dataFileName[0]

while dataFileName[1] == dataFileName[0]:
    dataFileName[1] = select_data_file(2);
    if dataFileName[1] == '!':
        exit()
    if dataFileName[1] == dataFileName[0]:
        programPause = raw_input('Please select a second file that is different from the first. Hit the <ENTER> key to continue:')
#dataFileName[1] = './data/{}'.format(dataFileName[1])

dataFrames = {0: {}, 1: {}}
for i in range(2):
    dataFrames[i] = read_data_file(dataFileName[i], i)
                
print '\nMerging data files ...'
dataFrameMerged, dfHCID1, dfHCID2, dfHCIDboth, dfExclusion1, dfExclusion2, dfExclusionboth, dfSTID1, dfSTID2, dfSTIDboth = merge_data_files(dataFrames[0], dataFrames[1])

print '\nWriting merged data to file ...'
dataFileNameMerged = determine_merged_file_name(dataFileName[0], dataFileName[1])
write_data_file(dataFrameMerged, dfHCID1, dfHCID2, dfHCIDboth, dfExclusion1, dfExclusion2, dfExclusionboth, dfSTID1, dfSTID2, dfSTIDboth, dataFileNameMerged)

print '\nFinis.\n'