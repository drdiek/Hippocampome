import pandas as pd

from lib.select_file import select_data_file
from lib.initialize import initialize_variables
from lib.save_data import save_data_file

dataFileName = select_data_file();
if dataFileName == '!':
    exit()
    
dataFrame = initialize_variables(dataFileName)

save_data_file(dataFrame, dataFileName)

print '\nFinis.\n'
