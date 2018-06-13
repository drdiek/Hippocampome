function article_PoK

    clear all

    [num, txt, raw] = xlsread('db/Property_view.csv');
    
    Property_PropertyIDs = uint16(num(:, 1));
   
    Property_subjects = txt(2:end, 2);
    
    Property_predicates = txt(2:end, 3);
   
    Property_objects = txt(2:end, 4);
    
    Property_isInclude = uint8(num(:, 5));
    
    pid_isInclude_idx = find(Property_isInclude == 1);
    
    pids_unique = Property_PropertyIDs(pid_isInclude_idx);
    
    nPids_unique = length(pids_unique)
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/EvidencePropertyTypeRel_view.csv');
    
    EvidencePropertyTypeRel_EvidenceIDs = uint16(num(:, 1));
        
    EvidencePropertyTypeRel_PropertyIDs = uint16(num(:, 2));
        
    EvidencePropertyTypeRel_TypeIDs = uint16(num(:, 3));
    
    nEvidencePropertyTypeRels = size(EvidencePropertyTypeRel_EvidenceIDs, 1);
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/Type_view.csv');
    
    Type_TypeIDs = uint16(num(:, 1));
    
    Type_nicknames = txt(2:end, 2);
    
    nTypeIDs = size(Type_TypeIDs, 1);
    
    clear num txt raw

    [num, txt, raw] = xlsread('db/ArticleEvidenceRel_view.csv');
    
    ArticleEvidenceRel_ArticleIDs = uint16(num(:, 1));
    
    ArticleEvidenceRel_EvidenceIDs = uint16(num(:, 2));
    
    nArticleEvidenceRels = size(ArticleEvidenceRel_ArticleIDs, 1);
        
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/Article_view.csv');
    
    Article_ArticleIDs = uint16(num(:, 1));
    
    Article_PMIDs = raw(2:end, 2);
    
    Article_isReview = uint8(num(:, 3));
    
    nArticleIDs = size(Article_ArticleIDs, 1);
    
    clear num txt raw
    
    
    fileId = fopen('articles_PoK.csv', 'w');
    
    fprintf(fileId, 'PMID,Article_ID,Fragment_ID,Evidence_ID,Type_ID,Type_Name,Property_ID,Property_Subject,Property_Predicate,Property_Object\n');
    
    
    i = 0;
    
    for iPid = 1:nPids_unique
    
        pid = pids_unique(iPid);
        
        pid2pid_idx = Property_PropertyIDs == pid;
        
        pid_subject = Property_subjects{pid2pid_idx};
        
        pid_predicate = Property_predicates{pid2pid_idx};
        
        pid_object = Property_objects{pid2pid_idx};
        
        pid2eid_idx = EvidencePropertyTypeRel_PropertyIDs == pid;
        
        eids_unique = unique(EvidencePropertyTypeRel_EvidenceIDs(pid2eid_idx));
        
        nEids_unique = length(eids_unique);
    
        for iEid = 1:nEids_unique
            
            if (iEid == 1)
                
                nnEids_unique = nEids_unique
                
            end
            
            eid = eids_unique(iEid)
                           
            eid2aid_idx = ArticleEvidenceRel_EvidenceIDs == eid;
            
            aids = ArticleEvidenceRel_ArticleIDs(eid2aid_idx);
            
            aids_unique = unique(ArticleEvidenceRel_ArticleIDs(eid2aid_idx));
            
            whos
            pause
            
            nAids_unique = length(aids_unique);
            
            for iAid = 1:nAids_unique
                
                if (iAid == 1)
                    
                    nnAids_unique = nAids_unique
                    
                end
                
                aid = aids_unique(iAid);
                
                aid2aid_idx = Article_ArticleIDs == aid;
                
                pmid = Article_PMIDs{aid2aid_idx};
                
                if (isnumeric(pmid))
                    
                    pmid = num2str(pmid);
                    
                end % if (isnumeric(pmid))
                
                eid2tid_idx = EvidencePropertyTypeRel_EvidenceIDs == eid;
                
                tids_unique = unique(EvidencePropertyTypeRel_TypeIDs(eid2tid_idx));
                
                nTids_unique = length(tids_unique);
                
                for iTid = 1:nTids_unique
                    
                    if (iTid == 1)
                        
                        nnTids_unique = nTids_unique
                        pause
                        
                    end
                    
                    tid = tids_unique(iTid);
                    
                    tid2tid_idx = Type_TypeIDs == tid;
                    
                    tid_name = Type_nicknames{tid2tid_idx};
                        
                    i = i + 1;
                    
                    % fprintf(fileId, 'PMID, Article_ID, Fragment_ID, Evidence_ID, Type_ID, Type_Name,
                    %                  Property_ID, Property_Subject, Property_Predicate, Property_Object\n');
                    
                    %                             fprintf(fileId, '''%s,%d,%d,%d,%d,%s,%d,%s,%s,%s\n', ...
                    %                                 pmid, ...
                    %                                 aid, ...
                    %                                 fid, ...
                    %                                 eid, ...
                    %                                 tid, ...
                    %                                 tid_name, ...
                    %                                 pid, ...
                    %                                 pid_subject, ...
                    %                                 pid_predicate, ...
                    %                                 pid_object);
                    
                end % iTid
                
            end % iAid
                    
        end % iEid
        
    end % iPid
        
    loops = i
    
    fclose(fileId);
            
end % article_PoK