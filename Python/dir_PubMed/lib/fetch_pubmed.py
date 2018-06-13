def fetch_pubmed_info(dfUniquePMIDs, dfPubMed):

    import pandas as pd

    from Bio import Entrez
    from Bio import Medline

    print '\nFetching new PubMed information ...'

    N = len(dfPubMed.index)

    Entrez.email = 'dwheele5@gmu.edu'

    i = 0
    
    for ID in dfUniquePMIDs:

        if '-' not in ID:

            h = Entrez.efetch(db='pubmed', id=ID, rettype='medline', retmode='text')
            records = Medline.parse(h)
    
            for record in records:
                print record
                print

                authors = []
                au = record.get('AU', ' ')
                for a in au: 
                    if a not in authors:
                        authors.append(a)
                authorStr = '{0}'.format(', '.join(authors))
                dfPubMed.loc[N+i, 'authors'] = authorStr
                print 'Authors: {}'.format(authorStr)

                pmid = record.get('PMID', ' ')
                dfPubMed.loc[N+i, 'pmid_isbn'] = pmid
                print 'PMID: {}'.format(pmid)

                pmcid = record.get('PMC', ' ')
                dfPubMed.loc[N+i, 'pmcid'] = pmcid
                print 'PMCID: {}'.format(pmcid)

                nihmsids = []
                mid = record.get('MID', ' ')
                for nihmsid in mid:
                    if nihmsid not in nihmsids:
                        nihmsids.append(nihmsid)
                nihmsidStr = '{}'.format(', '.join(nihmsids))
                print 'NIHMSID: {}'.format(nihmsidStr)
                dfPubMed.loc[N+i, 'nihmsid'] = nihmsidStr

                doi = ''
                doiStrs = record.get('AID', ' ')
                for doiStr in doiStrs:
                    openIndex = doiStr.find("[doi]")
                    if not (openIndex == -1):
                        doi = doiStr[0:openIndex-1]
                print 'DOI: {}'.format(doi)
                dfPubMed.loc[N+i, 'doi'] = doi

                pages = record.get('PG', ' ')
                hyphenIndex = pages.find("-")
                if hyphenIndex == -1:
                    firstPage = " "
                    lastPage = " "
                else:
                    firstPage = pages[0:hyphenIndex]
                    lastPage = pages[hyphenIndex+1:]
                    print 'Pages: {} - {}'.format(firstPage, lastPage)
                dfPubMed.loc[N+i, 'first_page'] = firstPage
                dfPubMed.loc[N+i, 'last_page'] = lastPage

                title = record.get('TI', ' ')
                print 'Title: {}'.format(title)
                dfPubMed.loc[N+i, 'title'] = title
            
                year = record.get('DP', ' ')
                print 'Year: {}'.format(year)
                dfPubMed.loc[N+i, 'year'] = year

                publication = record.get('TA', ' ')
                print 'Publication: {}'.format(publication)
                dfPubMed.loc[N+i, 'publication'] = publication

                volume = record.get('VI', ' ')
                print 'Volume: {}'.format(volume)
                dfPubMed.loc[N+i, 'volume'] = volume

                issueStr = record.get('SO', ' ')
                openIndex = issueStr.find("(")
                closeIndex = issueStr.find(")")
                if openIndex == -1:
                    issue = " "
                else:
                    issue = issueStr[openIndex+1:closeIndex]
                print 'Issue: {}'.format(issue)
                dfPubMed.loc[N+i, 'issue'] = issue
    
            i += 1
        
    return(dfPubMed)
