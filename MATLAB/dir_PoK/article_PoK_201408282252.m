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
    
    nPids_unique = length(pids_unique);
    
    clear num txt raw
    

    [num, txt, raw] = xlsread('db/EvidenceFragmentRel_view.csv');
    
    EvidenceFragmentRel_EvidenceIDs = uint16(num(:, 1));
   
    EvidenceFragmentRel_FragmentIDs = uint16(num(:, 2));
   
    nEvidenceFragmentRel_EvidenceIDs = size(EvidenceFragmentRel_EvidenceIDs, 1);
    
    fids_unique = unique(EvidenceFragmentRel_FragmentIDs);
    
    nFids_unique = length(fids_unique);
    
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
    
%     aids_unique = unique(ArticleEvidenceRel_ArticleIDs);
%     
%     nAids_unique = length(aids_unique);
    
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
    
    for iFid = 1:nFids_unique
    
        fid = fids_unique(iFid);
        
        fid2eid_idx = find(EvidenceFragmentRel_FragmentIDs == fid);
        
        eids_unique = unique(EvidenceFragmentRel_EvidenceIDs(fid2eid_idx));
        
        nEids_unique = length(eids_unique);
    
        for iEid = 1:nEids_unique
            
            eid = eids_unique(iEid);
            
            eid2pid_idx = find(EvidencePropertyTypeRel_EvidenceIDs == eid);
            
            pids_unique = unique(EvidencePropertyTypeRel_PropertyIDs(eid2pid_idx));
            
            nPids_unique = length(pids_unique);
            
            for iPid = 1:nPids_unique
                
                pid = pids_unique(iPid);
                
                pid2pid_idx = find(Property_PropertyIDs == pid);
                
                if (Property_isInclude(pid2pid_idx))
                
                    pid_subject = Property_subjects{pid2pid_idx};
                    
                    pid_predicate = Property_predicates{pid2pid_idx};
                    
                    pid_object = Property_objects{pid2pid_idx};
                    
                    pid2tid_idx = find(EvidencePropertyTypeRel_PropertyIDs == pid);
                    
                    tids_unique = unique(EvidencePropertyTypeRel_TypeIDs(pid2tid_idx));
                    
                    nTids_unique = length(tids_unique);
                    
                    for iTid = 1:nTids_unique
                        
                        tid = tids_unique(iTid);
                        
                        tid2tid_idx = find(Type_TypeIDs == tid);
                        
                        tid_name = Type_nicknames{tid2tid_idx};
                        
                        eid2aid_idx = find(ArticleEvidenceRel_EvidenceIDs == eid);
                        
                        aids_unique = unique(ArticleEvidenceRel_ArticleIDs(eid2aid_idx));
                        
                        nAids_unique = length(aids_unique);
                        
                        for iAid = 1:nAids_unique
                            
                            aid = aids_unique(iAid);
                            
                            aid2aid_idx = find(Article_ArticleIDs == aid);
                            
                            pmid = Article_PMIDs{aid2aid_idx};
                            
                            if (isnumeric(pmid))
                                
                                pmid = num2str(pmid);
                                
                            end
                            
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
                            
                        end % iAid
                        
                    end % iTid
                    
                end % if (Property_isInclude(pid2pid_idx))
                
            end % iPid
            
        end % iEid
        
    end % iFid
        
    loops = i
    
    fclose(fileId);
            
end % article_PoK