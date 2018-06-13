function article_PoK

    clear all

    [num, txt, raw] = xlsread('db/Article_view.csv');
    
    ArticleIDs = uint16(num(:, 1));
    
    PMIDs = txt(2:end, 2);
    
    isReview = uint8(num(:, 3));
    
    nArticleIDs = size(ArticleIDs, 1);
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/ArticleEvidenceRel_view.csv');
    
    ArticleEvidenceRel_ArticleIDs = uint16(num(:, 1));
    
    ArticleEvidenceRel_EvidenceIDs = uint16(num(:, 2));
    
    nArticleEvidenceRels = size(ArticleEvidenceRel_ArticleIDs, 1);
    
    aids_unique = unique(ArticleEvidenceRel_ArticleIDs);
    
    nAids_unique = length(aids_unique);
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/EvidenceFragmentRel_view.csv');
    
    EvidenceFragmentRel_EvidenceIDs = uint16(num(:, 1));
    
    EvidenceFragmentRel_FragmentIDs = uint16(num(:, 2));
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/FragmentTypeRel_view.csv');
    
    FragmentTypeRel_FragmentIDs = uint16(num(:, 1));
    
    FragmentTypeRel_TypeIDs = uint16(num(:, 2));
    
    nFragmentTypeRels = size(FragmentTypeRel_FragmentIDs, 1);
    
    fids_unique = unique(FragmentTypeRel_FragmentIDs);
    
    nFids_unique = length(fids_unique)
    pause
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/PropertyTypeRel_view.csv');
    
    PropertyTypeRel_PropertyIDs = uint16(num(:, 1));
        
    PropertyTypeRel_TypeIDs = uint16(num(:, 2));
    
    nPropertyTypeRels = size(PropertyTypeRel_TypeIDs, 1);
    
    tids_unique = unique(PropertyTypeRel_TypeIDs);
    
    nTids_unique = length(tids_unique);
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/Property_view.csv');
    
    PropertyIDs = uint16(num(:, 1));
   
    PropertyIDs_subjects = txt(2:end, 2);
    
    PropertyIDs_predicates = txt(2:end, 3);
   
    PropertyIDs_objects = txt(2:end, 4);
    
    nPropertyIDs = size(PropertyIDs, 1);
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/Type_view.csv');
    
    TypeIDs = uint16(num(:, 1));
    
    TypeIDs_nicknames = txt(2:end, 2);
    
    nTypeIDs = size(TypeIDs, 1);
    
    clear num txt raw

    
    fileId = fopen('articles_PoK.csv', 'w');
    
    fprintf(fileId, 'PMID,Article_ID,Evidence_ID,Fragment_ID,Type_ID,Type_Name,Property_ID,Property_Subject,Property_Predicate,Property_Object\n');
    
    for iAid = 1:nAids_unique
        
        aids_idx = find(ArticleIDs == aids_unique(iAid));
        
        pmid = PMIDs{aids_idx};
        
        aid = aids_unique(iAid); %ArticleIDs(aids_idx);
        
        if (aid == 268)
            YO = 1111
            pause
        end
        
        aer_aids_idx = find(ArticleEvidenceRel_ArticleIDs == aid);
        
        eids = ArticleEvidenceRel_EvidenceIDs(aer_aids_idx);
        
        for iEid = 1:length(eids)
            
        if ((aid == 268) && (iEid == 1))
            YO = 2222
            pause
        end
        
            eid = eids(iEid);
            
            eid_idx = find(EvidenceFragmentRel_EvidenceIDs == eid);
            
            fid = EvidenceFragmentRel_FragmentIDs(eid_idx);
            
            if (any(fids_unique == fid))
            
                fids_idx = find(FragmentTypeRel_FragmentIDs == fid);
            
                tids = FragmentTypeRel_TypeIDs(fids_idx);
                
                for iTid = 1:length(tids)
                    
        if ((aid == 268) && (iTid == 1))
            YO = 3333
            pause
        end
        
                    tid = tids(iTid);
                    
                    if (any(tids_unique == tid))
                        
                        tid_idx = find(TypeIDs == tid);
                        
                        tid_name = TypeIDs_nicknames{tid_idx};
                    
                        tids_idx = find(PropertyTypeRel_TypeIDs == tid);
                        
                        pids = PropertyTypeRel_PropertyIDs(tids_idx);
                        
                        pids_unique = unique(pids);
            
                        for iPid = 1:length(pids_unique)
                            
        if ((aid == 268) && (iPid == 1))
            YO = 4444
            pause
        end
        
                            pid = pids_unique(iPid);
                            
                            pid_idx = find(PropertyIDs == pid);
                            
                            for i = 1:length(pid_idx)
                            
        if ((aid == 268) && (i == 1))
            YO = 5555
            pause
        end
        
                                if (aids_unique(iAid) > 267)
                                aaiidd = aids_unique(iAid)
                                pause
                                end
        
                                pid_subject = PropertyIDs_subjects{pid_idx(i)};
                                
                                pid_predicate = PropertyIDs_predicates{pid_idx(i)};
                                
                                pid_object = PropertyIDs_objects{pid_idx(i)};
                                
                                % fprintf(fileId, 'PMID, Article_ID, Evidence_ID, Fragment_ID, Type_ID, Type_Name,
                                %                  Property_ID, Property_Subject, Property_Predicate, Property_Object\n');
                                
                                fprintf(fileId, '''%s,%d,%d,%d,%d,%s,%d,%s,%s,%s\n', ...
                                    pmid, ...
                                    aid, ...
                                    eid, ...
                                    fid, ...
                                    tid, ...
                                    tid_name, ...
                                    pid, ...
                                    pid_subject, ...
                                    pid_predicate, ...
                                    pid_object);
                                
                            end % i
                                                            
                        end % iPid
                            
                    end % if (any(tids_unique == tid))
                    
                end % iTid
                
            end % if (any(fids_unique == fid))
            
        end % iEid
                
    end % iAid
    
    fclose(fileId);
            
end % article_PoK