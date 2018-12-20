from lib.menu.select_processing import select_processing_function
from lib.menu.select_ARA import select_ARA_or_CCF
from lib.menu.select_nrrd import select_file_nrrd
from lib.menu.select_subregion import select_source_subregion

MATRIX = 3

processingFunction = select_processing_function()
if (processingFunction == '!'):
    exit()

isARA = select_ARA_or_CCF()
if (isARA == '!'):
    exit()

labelImageFile = select_file_nrrd()
if (labelImageFile == '!'):
    exit()
    
subregion = select_source_subregion()
if (subregion == '!'):
    exit()

print subregion