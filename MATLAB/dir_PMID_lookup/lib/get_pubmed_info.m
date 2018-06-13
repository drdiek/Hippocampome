function pmstruct = get_pubmed_info(searchterm,varargin)
% GETPUBMED Search PubMed database & write results to MATLAB structure

    % Error checking for required input SEARCHTERM
    if(nargin<1)
        error(message('bioinfo:getpubmed:NotEnoughInputArguments'));
    end

    % Set default settings for property name/value pairs,
    % 'NUMBEROFRECORDS' and 'DATEOFPUBLICATION'
    maxnum = 50; % NUMBEROFRECORDS default is 50
    pubdate = ''; % DATEOFPUBLICATION default is an empty string
    
    % Parsing the property name/value pairs
    num_argin = numel(varargin);
    for n = 1:2:num_argin
        arg = varargin{n};
        switch lower(arg)
            
            % If NUMBEROFRECORDS is passed, set MAXNUM
            case 'numberofrecords'
                maxnum = varargin{n+1};
                
                % If DATEOFPUBLICATION is passed, set PUBDATE
            case 'dateofpublication'
                pubdate = varargin{n+1};
                
        end
    end
    
    % Create base URL for PubMed db site
    % baseSearchURL = 'https://www.ncbi.nlm.nih.gov/sites/entrez?cmd=search';
    baseSearchURL = 'https://www.ncbi.nlm.nih.gov/pubmed?cmd=search';
    
    % Set term parameter to SEARCHTERM and PUBDATE
    % (Default PUBDATE is '')
    % termOpt = ['&term=',searchterm,'+AND+',pubdate];
    termOpt = ['&term=',searchterm];
    
    % Set report parameter to medline
    reportOpt = '&report=medline';
    
    % Set format parameter to text
    formatOpt = '&format=text';
    
    % Set dispmax to MAXNUM
    % (Default MAXNUM is 50)
    maxOpt = ['&dispmax=',num2str(maxnum)];
    
    % Create search URL
    % searchURL = [baseSearchURL,dbOpt,termOpt,reportOpt,formatOpt,maxOpt];
    % https://www.ncbi.nlm.nih.gov/pubmed?cmd=search&term=1284975&report=medline&format=text
    searchURL = [baseSearchURL,termOpt,reportOpt,formatOpt]
    
    medlineText = urlread(searchURL);
    
    hits = regexp(medlineText,'PMID-.*?(?=PMID|</pre>$)','match');
    
    pmstruct = struct('Authors','',...
                      'Title','',...
                      'Publication','',...
                      'Year','',...
                      'PMID','');
    
    for n = 1:numel(hits)
        authors = regexp(hits{n},'(?<=AU  - ).*?(?=\n)','match');
        authorStr = authors{1};
        for i = 2:length(authors)
            authorStr = sprintf('%s, %s',authorStr,authors{i});
        end
        pmstruct(n).Authors = authorStr;
        title = regexp(hits{n},'(?<=TI  - ).*?(?=PG  -|AB  -)','match', 'once');
        title = regexprep(title,'\s+',' ');
        pmstruct(n).Title = title;
        publication = regexp(hits{n},'(?<=JT  - ).*?(?=\n)','match', 'once');
        idx = regexp([' ' publication],'(?<=\s+)\S','start')-1;
        publication(idx) = upper(publication(idx));
        pmstruct(n).Publication = publication;
        pmstruct(n).Year = regexp(hits{n},'(?<=DP  - ).*?(?=\n)','match', 'once');
        pmstruct(n).PMID = regexp(hits{n},'(?<=PMID- ).*?(?=\n)','match', 'once');
    end
    
end % get_pubmed_info()
