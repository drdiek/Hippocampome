function authors_unique()

    clear all % }
    
    [num, txt, raw] = xlsread('csv2db/Author.csv');
    
    Author_AuthorIDs = uint16(num(:, 1));

    Author_AuthorNames = txt(2:end, 3);
    
    nAuthors = length(Author_AuthorIDs);
    
    fid = fopen('authors.txt', 'w');
    
    for i = 1:nAuthors
        
        idx = strfind(Author_AuthorNames{i}, ' ');
        
        fprintf(fid, '%s\n', Author_AuthorNames{i}(1:idx+1));
        
    end
    
    fclose(fid);
    
end