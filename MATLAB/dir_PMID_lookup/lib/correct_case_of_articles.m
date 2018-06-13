function publication = correct_case_of_articles(publication)

    idx = regexp([' ' publication],'(?<=\s+)\S','start')-1;
    publication(idx) = upper(publication(idx));
    idx = findstr(publication,'Of');
    publication(idx) = 'o';
    idx = findstr(publication,'A ');
    if ~isempty(idx)
        if (idx(1) > 1)
            publication(idx) = 'a';
        else
            publication(idx(2:end)) = 'a';
        end
    end
    idx = findstr(publication,'An');
    if ~isempty(idx)
        if (idx(1) > 1)
            publication(idx) = 'a';
        else
            publication(idx(2:end)) = 'a';
        end
    end
    idx = findstr(publication,'The');
    if ~isempty(idx)
        if (idx(1) > 1)
            publication(idx) = 't';
        else
            publication(idx(2:end)) = 't';
        end
    end
    publication(idx) = 't';
    idx = findstr(publication,'And');
    publication(idx) = 'a';
    idx = findstr(publication,'In');
    publication(idx) = 'i';
    
end % correct_case_of_articles()