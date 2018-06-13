from Bio import Entrez
from Bio import Medline

import pandas as pd

from lib.fetch_old import fetch_old_PMIDs
from lib.fetch_new import fetch_new_PMIDs
from lib.fetch_pubmed import fetch_pubmed_info
from lib.write_pubmed import write_pubmed_info

dfPubMed = fetch_old_PMIDs()
if isinstance(dfPubMed, basestring) and dfPubMed == '!':
    print
    exit()

dfNewPMIDs = fetch_new_PMIDs()
if isinstance(dfNewPMIDs, basestring) and dfNewPMIDs == '!':
    print
    exit()

dfUniquePMIDs = dfNewPMIDs[~dfNewPMIDs.isin(dfPubMed['pmid_isbn'].values)].reset_index(drop=True)
# dfUniquePMIDs = dfNewPMIDs[~dfNewPMIDs.isin(dfOldPMIDs.values)].reset_index(drop=True)

dfPubMed = fetch_pubmed_info(dfUniquePMIDs, dfPubMed)

write_pubmed_info(dfPubMed)
