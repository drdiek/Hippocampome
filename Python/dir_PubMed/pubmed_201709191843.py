from Bio import Entrez
from Bio import Medline

import csv

from diek_functions import time_stamp

from fetch_old_PMIDs import fetch_old_PMIDs
from fetch_new_PMIDs import fetch_new_PMIDs

print

oldPMIDsFileName = "../data/article_201610141752.csv"
oldPMIDs = fetch_old_PMIDs(oldPMIDsFileName)

newPMIDsFileName = "../data/URD_new_entries.csv"
newPMIDs = fetch_new_PMIDs(newPMIDsFileName)

uniquePMIDs = newPMIDs
i = 0


for newPMID in newPMIDs:

    if newPMID not in oldPMIDs:
    
        uniquePMIDs[i] = newPMID
        i = i + 1

IDs = uniquePMIDs[0:i]
#IDs = [11406829, 26402459, 27516119]

Entrez.email = 'dwheele5@gmu.edu'

outputFileNameBase = "../output/pubmed_addendum"

timeStampStr = time_stamp()

outputFileName = "%s_%s.csv" % (outputFileNameBase, timeStampStr)

with open(outputFileName, "wb") as filePointer:

    csvMatrix = csv.writer(filePointer)
    
    outputRow = []
        
    outputRow.append("authors".encode("utf-8"))
    outputRow.append("pmid_isbn".encode("utf-8"))
    outputRow.append("pmcid".encode("utf-8"))
    outputRow.append("nihmsid".encode("utf-8"))
    outputRow.append("doi".encode("utf-8"))
    outputRow.append("citation_count".encode("utf-8"))
    outputRow.append("open_access".encode("utf-8"))
    outputRow.append("first_page".encode("utf-8"))
    outputRow.append("last_page".encode("utf-8"))
    outputRow.append("title".encode("utf-8"))
    outputRow.append("year".encode("utf-8"))
    outputRow.append("publication".encode("utf-8"))
    outputRow.append("volume".encode("utf-8"))
    outputRow.append("issue".encode("utf-8"))
    outputRow.append("type_mapped".encode("utf-8"))
    outputRow.append("packet".encode("utf-8"))

    csvMatrix.writerow(outputRow)
        
    for ID in IDs:
    
        h = Entrez.efetch(db='pubmed', id=ID, rettype='medline', retmode='text')
        records = Medline.parse(h)
        
        authors = []
        for record in records:
            print record
            print
            au = record.get('AU', ' ')
            for a in au: 
                if a not in authors:
                    authors.append(a)
            authorStr = '{0}'.format(', '.join(authors))
            print authorStr

            pmid = record.get('PMID', ' ')
            print pmid

            pmcid = record.get('PMC', ' ')
            print pmcid

            nihmsids = record.get('MID', ' ')
            for nihmsid in nihmsids:
                print nihmsid

            doiStrs = record.get('AID', ' ')
            for doiStr in doiStrs:
                openIndex = doiStr.find("[doi]")
                if openIndex == -1:
                    doi = " "
                else:
                    doi = doiStr[0:openIndex-1]
                print doi

            pages = record.get('PG', ' ')
            hyphenIndex = pages.find("-")
            if hyphenIndex == -1:
                firstPage = " "
                lastPage = " "
            else:
                firstPage = pages[0:hyphenIndex]
                lastPage = pages[hyphenIndex+1:]
                print firstPage + " - " + lastPage
            
            title = record.get('TI', ' ')
            print title
            print
            year = record.get('DP', ' ')
            print year
            print
            publication = record.get('TA', ' ')
            print publication
            print
            volume = record.get('VI', ' ')
            print volume
            print

            issueStr = record.get('SO', ' ')
            openIndex = issueStr.find("(")
            closeIndex = issueStr.find(")")
            if openIndex == -1:
                issue = " "
            else:
                issue = issueStr[openIndex+1:closeIndex]
            print issue
        
        outputRow = []
        
        outputRow.append(authorStr.encode("utf-8"))
        outputRow.append(pmid.encode("utf-8"))
        outputRow.append(pmcid.encode("utf-8"))
        outputRow.append(nihmsid.encode("utf-8"))
        outputRow.append(doi.encode("utf-8"))
        outputRow.append(" ".encode("utf-8"))
        outputRow.append(" ".encode("utf-8"))
        outputRow.append(firstPage.encode("utf-8"))
        outputRow.append(lastPage.encode("utf-8"))
        outputRow.append(title.encode("utf-8"))
        outputRow.append(year.encode("utf-8"))
        outputRow.append(publication.encode("utf-8"))
        outputRow.append(volume.encode("utf-8"))
        outputRow.append(issue.encode("utf-8"))
    
        csvMatrix.writerow(outputRow)

filePointer.close()        

