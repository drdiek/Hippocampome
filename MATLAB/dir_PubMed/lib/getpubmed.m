function pmstruct = getpubmed(searchterm,varargin)
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

% Set db parameter to pubmed
dbOpt = '&db=pubmed';

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
searchURL = [baseSearchURL,termOpt,reportOpt,formatOpt]

medlineText = urlread(searchURL);

hits = regexp(medlineText,'PMID-.*?(?=PMID|</pre>$)','match');

pmstruct = struct('PMID','','PublicationDate','','Title','',...
             'Abstract','','Authors','','PMCID','',...
             'AID','','FirstPage','','LastPage','','Year','',...
             'Publication','','Volume','','Issue','');
         
for n = 1:numel(hits)
    pmstruct(n).PMID = regexp(hits{n},'(?<=PMID- ).*?(?=\n)','match', 'once');
    pmstruct(n).PMCID = regexp(hits{n},'(?<=PMC - ).*?(?=\n)','match', 'once');
    pmstruct(n).PublicationDate = regexp(hits{n},'(?<=DP  - ).*?(?=\n)','match', 'once');
    title = regexp(hits{n},'(?<=TI  - ).*?(?=PG  -|AB  -)','match', 'once');
%     title(title == char(10)) = '';       %10 is control-J, newline
%     title(title == char(13)) = '';       %13 is carriage return
    title = regexprep(title,'\s+',' ');
    pmstruct(n).Title = title;
    pmstruct(n).Abstract = regexp(hits{n},'(?<=AB  - ).*?(?=AD  -)','match', 'once');
    authors = regexp(hits{n},'(?<=AU  - ).*?(?=\n)','match');
    authorStr = authors{1};
    for i = 2:length(authors)
        authorStr = sprintf('%s, %s',authorStr,authors{i});
    end
    pmstruct(n).Authors = authorStr;
    AIDs = regexp(hits{n},'(?<=AID - ).*?(?=\n)','match');
    for i = 1:length(AIDs)
        idx = strfind(AIDs(i),'[doi]');
        if isempty(idx)
            pmstruct(n).AID = '';
        else
            idx = cell2mat(idx) - 2;
            pmstruct(n).AID = AIDs{i}(1:idx);
        end
    end %i
%     pmstruct(n).AIDs = regexp(hits{n},'(?<=AID - ).*?(?=\n)','match');
    citation = regexp(hits{n},'(?<=SO  - ).*?(?=\n)','match', 'once');
    openIdx = strfind(citation,'(');
    closeIdx = strfind(citation,')');
    pmstruct(n).Issue = citation(openIdx+1:closeIdx-1);
    pages = regexp(hits{n},'(?<=PG  - ).*?(?=\n)','match', 'once');
    idx = strfind(pages,'-');
    pmstruct(n).FirstPage = pages(1:idx-1);
    pmstruct(n).LastPage = pages(idx+1:end);
    pmstruct(n).Year = regexp(hits{n},'(?<=DP  - ).*?(?=\n)','match', 'once');
    pmstruct(n).Publication = regexp(hits{n},'(?<=TA  - ).*?(?=\n)','match', 'once');
    pmstruct(n).Volume = regexp(hits{n},'(?<=VI  - ).*?(?=\n)','match', 'once');
end

