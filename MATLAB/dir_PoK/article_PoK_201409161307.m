function article_PoK

    clear all

    [num, txt, raw] = xlsread('db/Type_view.csv');
    
    Type_TypeIDs = uint16(num(:, 1));
    
    Type_nicknames = txt(2:end, 2);
    
    tids_unique = Type_TypeIDs;
    
    nTids_unique = length(tids_unique);
    
    clear num txt raw

    [num, txt, raw] = xlsread('db/PropertyTypeRel_view.csv');
    
    PropertyTypeRel_PropertyIDs = uint16(num(:, 1));
        
    PropertyTypeRel_TypeIDs = uint16(num(:, 2));
    
    nPropertyTypeRels = size(PropertyTypeRel_PropertyIDs, 1);
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/Property_view.csv');
    
    Property_PropertyIDs = uint16(num(:, 1));
   
    Property_subjects = txt(2:end, 2);
    
    Property_predicates = txt(2:end, 3);
   
    Property_objects = txt(2:end, 4);
    
    Property_isInclude = uint8(num(:, 5));
    
    clear num txt raw
    
    [num, txt, raw] = xlsread('db/EvidencePropertyTypeRel_view.csv');
    
    EvidencePropertyTypeRel_EvidenceIDs = uint16(num(:, 1));
        
    EvidencePropertyTypeRel_PropertyIDs = uint16(num(:, 2));
        
    EvidencePropertyTypeRel_TypeIDs = uint16(num(:, 3));
    
%     nEvidencePropertyTypeRels = size(EvidencePropertyTypeRel_EvidenceIDs, 1);
    
    clear num txt raw
    
%     [num, txt, raw] = xlsread('db/EvidenceFragmentRel_view.csv');
%     
%     EvidenceFragmentRel_EvidenceIDs = uint16(num(:, 1));
%         
%     EvidenceFragmentRel_FragmentIDs = uint16(num(:, 2));
%     
% %     nEvidenceFragmentRels = size(EvidenceFragmentRel_EvidenceIDs, 1);
%     
%     clear num txt raw
%  
%     [num, txt, raw] = xlsread('db/Fragment_view.csv');
%     
%     Fragment_FragmentIDs = uint16(num(:, 1));
%         
%     Fragment_PMIDs = raw(2:end, 2);
%     
% %     nFragmentTypeRels = size(FragmentTypeRel_FragmentIDs, 1);
%     
%     clear num txt raw
    
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
    
    fprintf(fileId, 'PMID,Article_ID,Review,Evidence_ID,Type_ID,Type_Name,Property_ID,Property_Subject,Property_Predicate,Property_Object\n');
    
    i = 0;
    
    for iTid = 1:nTids_unique
        
        tid = tids_unique(iTid);
        
        tid2tid_idx = Type_TypeIDs == tid;
        
        tid_name = Type_nicknames{tid2tid_idx};
            
        tid2pid_idx = PropertyTypeRel_TypeIDs == tid;
        
        pids_unique = unique(PropertyTypeRel_PropertyIDs(tid2pid_idx));
        
        nPids_unique = length(pids_unique);
        
        for iPid = 1:nPids_unique
            
            pid = pids_unique(iPid);
            
            pid2pid_idx = Property_PropertyIDs == pid;
            
            pid_subject = Property_subjects{pid2pid_idx};
            
            pid_predicate = Property_predicates{pid2pid_idx};
            
            pid_object = Property_objects{pid2pid_idx};
            
            pid_isInclude = Property_isInclude(pid2pid_idx);
    
            if (pid_isInclude)
                
                tid2eid_idx = find(EvidencePropertyTypeRel_TypeIDs == tid);
            
                pid2eid_idx = find(EvidencePropertyTypeRel_PropertyIDs == pid);
                
                eid_idx = intersect(tid2eid_idx, pid2eid_idx);
                
                eids_unique = unique(EvidencePropertyTypeRel_EvidenceIDs(eid_idx));
                
                nEids_unique = length(eids_unique);

                for iEid = 1:nEids_unique
                    
                    eid = eids_unique(iEid);
                
                    eid2aid_idx = ArticleEvidenceRel_EvidenceIDs == eid;
                    
                    aids_unique = unique(ArticleEvidenceRel_ArticleIDs(eid2aid_idx));
                    
                    nAids_unique = length(aids_unique);
            
                    for iAid = 1:nAids_unique
                        
                        aid = aids_unique(iAid);
                        
                        aid2aid_idx = Article_ArticleIDs == aid;
                        
                        pmid = Article_PMIDs{aid2aid_idx};
                        
                        if (isnumeric(pmid))
                            
                            pmid = num2str(pmid);
                            
                        end % if (isnumeric(pmid))
                        
                        isReview = Article_isReview(aid2aid_idx);
                
                        i = i + 1;
                        
                        % fprintf(fileId, 'PMID, Article_ID, Review, Evidence_ID, Type_ID, Type_Name,
                        %                  Property_ID, Property_Subject, Property_Predicate, Property_Object\n');
                        
                        fprintf(fileId, '''%s,%d,%d,%d,%d,%s,%d,%s,%s,%s\n', ...
                            pmid, ...
                            aid, ...
                            isReview, ...
                            eid, ...
                            tid, ...
                            tid_name, ...
                            pid, ...
                            pid_subject, ...
                            pid_predicate, ...
                            pid_object);

                        aids(i) = aid;
                        
                        isReviews(i) = isReview;
                        
                    end % iAid
                
                end % iEid
                
            end % if (pid_isInclude)
                    
        end % iPid
        
    end % iTid
        
    loops = i
    
    fclose(fileId);
            
    aids_unique = unique(aids);

    out = [aids_unique; histc(aids,aids_unique)]';
    
    fileId = fopen('articles_vs_reviews_PoK.csv', 'w');

    fprintf(fileId, 'Article_ID,Counts,Review\n');
    
    for i = 1:size(out,1)
        
%         isReviews_unique = unique(isReviews(aids == aids_unique(i)))
%         
%         pause
    
        fprintf(fileId, '%d,%d,%d\n', out(i,1), out(i,2), unique(isReviews(aids == aids_unique(i))));
        
    end
    
    fclose(fileId);
    
end % article_PoK