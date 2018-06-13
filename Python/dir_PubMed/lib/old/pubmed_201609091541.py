from Bio import Entrez
from Bio import Medline

ID = 11406829

Entrez.email = 'dwheele5@gmu.edu'

h = Entrez.efetch(db='pubmed', id=ID, rettype='medline', retmode='text')
records = Medline.parse(h)

print records

authors = []for record in records:
    print record    au = record.get('AU', '?')    for a in au:         if a not in authors:            authors.append(a)    print('Authors: {0}'.format(', '.join(authors)))
    print
    pmid = record.get('PMID', '?')
    print pmid
    print
    pmcid = record.get('PMC', '?')
    print pmcid
    print
    nihmsid = record.get('MID', '?')
    print nihmsid
    print
    doi = record.get('LID', '?')
    print doi
    print
    pages = record.get('PG', '?')
    print pages
    print
    title = record.get('TI', '?')
    print title
    print
    year = record.get('DP', '?')
    print year
    print
    publication = record.get('TA', '?')
    print publication
    print
    volume = record.get('VI', '?')
    print volume
    print
    issue = record.get('SO', '?')
    print issue
    print
    

