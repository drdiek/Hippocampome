%NRRD Format File Reader
%version 1.1.0.1 (2.67 KB) by Jeff Mather
%Read imagery and metadata from .nrrd medical imaging format files

function [X, meta] = nrrdread(filename)
%NRRDREAD  Import NRRD imagery and metadata.
%   [X, META] = NRRDREAD(FILENAME) reads the image volume and associated
%   metadata from the NRRD-format file specified by FILENAME.
%
%   Current limitations/caveats:
%   * "Block" datatype is not supported.
%   * Only tested with "gzip" and "raw" file encodings.
%   * Very limited testing on actual files.
%   * I only spent a couple minutes reading the NRRD spec.
%
%   Read all the attributes of nrrd file.
%   See the format specification online:
%   http://teem.sourceforge.net/nrrd/format.html

% Copyright 2012 The MathWorks, Inc.

[mainFpath,mainFileName,mainFext] = fileparts( filename );
headerInfo = struct();

        % default value which can be overriden if content field is set
headerInfo.data = [];
attributeList = [];

% Open file.
fid = fopen(filename, 'rb');
assert(fid > 0, 'Could not open file.');
cleaner = onCleanup(@() fclose(fid));

% Magic line.
theLine = fgetl(fid);
assert(numel(theLine) >= 4, 'Bad signature in file.')
assert(isequal(theLine(1:4), 'NRRD'), 'Bad signature in file.')

% The general format of a NRRD file (with attached header) is:
% 
%     NRRD000X
%     <field>: <desc>
%     <field>: <desc>
%     # <comment>
%     ...
%     <field>: <desc>
%     <key>:=<value>
%     <key>:=<value>
%     <key>:=<value>
%     # <comment>
% 
%     <data><data><data><data><data><data>...

meta = struct([]);

% Parse the file a line at a time.
while (~feof(fid))

  theLine = fgetl(fid);
  
  if (isempty(theLine) || feof(fid))
    % End of the header.
    break;
  end
  
       if ( foundKeyword( 'Content:', theLine ) )           
            headerInfo.content = strtrim( theLine( length('Content:')+1:end ) );
			content = strsplit(headerInfo.content, {'""',''''})
            if (strlength(content) == 0)
			 headerInfo.content = mainFileName;
			end
            attributeList = setfield (attributeList, 'Content', headerInfo.content);
			
        elseif ( foundKeyword('Type:', theLine ) )      
            headerInfo.type = strtrim( theLine( length('Type:')+1:end ) );
            Type  = headerInfo.type
            attributeList = setfield (attributeList, 'Type', Type);
            
        elseif ( foundKeyword('Endian:', theLine ) )    
            headerInfo.endian = strtrim( theLine( length('Endian:')+1:end ) );
            endian = headerInfo.endian
            attributeList = setfield (attributeList, 'endian', endian);
            
        elseif ( foundKeyword('Encoding:', theLine ) ) 
            headerInfo.encoding = strtrim( theLine( length('Encoding:')+1:end ) );
            encoding = headerInfo.encoding
            attributeList = setfield (attributeList, 'Encoding', encoding);
            
        elseif ( foundKeyword('Dimension:', theLine ) )
            headerInfo.dimension = sscanf( theLine( length('Dimension:')+1:end ), '%i' );
            dimension = headerInfo.dimension
            attributeList = setfield (attributeList, 'Dimension', dimension);
            
        elseif ( foundKeyword('Sizes:', theLine ) )    
            iSizes = sscanf( theLine(length('Sizes:')+1:end), '%i' );
            headerInfo.sizes = iSizes(:)';      % store as row vector
            sizes = headerInfo.sizes
            attributeList = setfield (attributeList, 'Sizes', sizes);
            
        elseif ( foundKeyword('Kinds:', theLine ) )    
            headerInfo.kinds = extractStringList( theLine(length('Kinds:')+1:end) ); 
           kinds = headerInfo.kinds
           attributeList = setfield (attributeList, 'Kinds', kinds);
     
	    elseif ( foundKeyword('Space:', theLine ) )
                headerInfo.space = strtrim( theLine( length('Space:')+1:end ) );
                internal_spacedimension = nrrd_getSpaceDimensions(headerInfo.space);
            space = headerInfo.space;
            %end
            attributeList = setfield (attributeList, 'Space', space);
			
        elseif ( foundKeyword('Space Dimension:', theLine) )
                headerInfo.spacedimension = sscanf( theLine( length('Space Dimension:')+1:end), '%i' );
                internal_spacedimension = headerInfo.spacedimension;
             space_dimension =headerInfo.spacedimension; 
             attributeList = setfield (attributeList, 'SpaceDimension', space_dimension);
			 
        elseif ( foundKeyword('Space Directions:', theLine ))           
            space_dir_tmp = strrep( theLine(length('Space Directions:')+1:end), 'none', '' );        
            SD_data = extractNumbersWithout( space_dir_tmp, {'(',')',','} );     
            headerInfo.spacedirections = reshape(SD_data(:), [internal_spacedimension, internal_spacedimension]); 
            space_direction =sprintf('(%d %d %d) (%d %d %d) (%d %d %d)',headerInfo.spacedirections);
            attributeList = setfield (attributeList, 'SpaceDirection', space_direction); 
			
        elseif ( foundKeyword('Space Units:', theLine ) )
            space_units_tmp = strrep( theLine(length('Space Units:')+1:end), 'none', '');        
            headerInfo.spaceunits = extract_spaceunits_list( space_units_tmp );
            space_units = sprintf('%s \t',headerInfo.spaceunits{:}); 
            attributeList = setfield (attributeList, 'SpaceUnits', space_units); 
			
        elseif ( foundKeyword('Space Origin:', theLine ) )    
            iSO = extractNumbersWithout( theLine(length('Space Origin:')+1:end), {'(',')',','} );
            headerInfo.spaceorigin = iSO(:);
            space_origin = sprintf('%d \t',headerInfo.spaceorigin); 
            attributeList = setfield (attributeList, 'SpaceOrigin', space_origin); 
			
       elseif ( foundKeyword('Thickness:', theLine ) )   
            sThicknesses = extractStringList( theLine(length('Thickness:')+1:end) ); % fixed bug with extractStringList where 2 entries are present
            iThicknesses = [];
            lenThicknesses = length( sThicknesses );
            for iI=1:lenThicknesses
                iThicknesses = [iThicknesses, str2num( sThicknesses{iI} ) ];
            end
            headerInfo.thickness = iThicknesses;
            thickness = headerInfo.thickness
            attributeList = setfield (attributeList, 'Thickness', thickness);
			
        elseif ( foundKeyword('Line Skip:', theLine) || foundKeyword('LineSkip', theLine) )     
            if foundKeyword('Line Skip:', theLine)
                headerInfo.lineskip = sscanf( theLine( length('Line Skip:')+1:end ), '%d' );
            else
                headerInfo.lineskip = sscanf( theLine( length('LineSkip:')+1:end ), '%d' );
            end
           attributeList = setfield (attributeList, 'Lineskip', headerInfo.lineskip);
		   
        elseif ( foundKeyword('Byte Skip:', theLine) || foundKeyword('ByteSkip:', theLine) )    
            if foundKeyword('Byte Skip:', theLine)
                headerInfo.byteskip = sscanf( theLine( length('Byte Skip:')+1:end ), '%d' );
            else
                headerInfo.byteskip = sscanf( theLine( length('ByteSkip:')+1:end ), '%d' );
            end
             attributeList = setfield (attributeList, 'Byteskip', headerInfo.byteskip);
			 
        elseif ( foundKeyword( 'Min:', theLine ) )          
            headerInfo.min = strtrim( theLine( length('Min:')+1:end ) );
            attributeList = setfield (attributeList, 'Min', headerInfo.min);
			
        elseif ( foundKeyword( 'Max:', theLine ) )          
            headerInfo.max = strtrim( theLine( length('Max:')+1:end ) );
            attributeList = setfield (attributeList, 'Max', headerInfo.max);
			
        elseif ( foundKeyword( 'OldMin:', theLine ) )          
            headerInfo.oldmin = strtrim( theLine( length('OldMin:')+1:end ) );
            attributeList = setfield (attributeList, 'OldMin', headerInfo.oldmin);
			
        elseif ( foundKeyword( 'OldMax:', theLine ) )          
            headerInfo.oldmax = strtrim( theLine( length('OldMax:')+1:end ) );
            attributeList = setfield (attributeList, 'OldMax', headerInfo.oldmax);
			
        elseif ( foundKeyword( 'SampleUnits:', theLine ) )          
            headerInfo.sampleunits = strtrim( theLine( length('SampleUnits:')+1:end ) );
            attributeList = setfield (attributeList, 'SampleUnits', headerInfo.sampleunits);
			
        elseif ( foundKeyword( 'AxisMin:', theLine ) )          
            headerInfo.axismin = strtrim( theLine( length('AxisMin:')+1:end ) );
            attributeList = setfield (attributeList, 'Axismin', headerInfo.axismin);
			
        elseif ( foundKeyword( 'AxisMax:', theLine ) )          
            headerInfo.axismax = strtrim( theLine( length('AxisMax:')+1:end ) );
            attributeList = setfield (attributeList, 'AxisMax', headerInfo.axismax);
			
        elseif ( foundKeyword( 'Centers:', theLine ) )          
            headerInfo.centers = strtrim( theLine( length('Centers:')+1:end ) );
            attributeList = setfield (attributeList, 'Centers', headerInfo.centers);
        
		elseif ( foundKeyword( 'Labels:', theLine ) )          
            headerInfo.labels = strtrim( theLine( length('Labels:')+1:end ) );
            attributeList = setfield (attributeList, 'Labels', headerInfo.labels);
        
		elseif ( foundKeyword( 'Units:', theLine ) )          
            headerInfo.units = strtrim( theLine( length('Units:')+1:end ) );
            attributeList = setfield (attributeList, 'Units', headerInfo.units);
        
		elseif ( foundKeyword( 'Spacings:', theLine ) )          
            headerInfo.spacings = strtrim( theLine( length('Spacings:')+1:end ) );
            attributeList = setfield (attributeList, 'Spacings', headerInfo.spacings);
        end


   if (isequal(theLine(1), '#'))
      % Comment line.
      continue;
   end


  % "fieldname:= value" or "fieldname: value" or "fieldname:value"
  parsedLine = regexp(theLine, ':=?\s*', 'split','once');
  
  assert(numel(parsedLine) == 2, 'Parsing error')
  
  field = lower(parsedLine{1});
  value = parsedLine{2};
  
  if (contains(field, '['))
      field (strfind(field,'[')) = '';
  end
  if (contains(field, ']'))
      field (strfind(field,']')) = '';
  end
  field(isspace(field)) = '';
  meta(1).(field) = value;
  
end

datatype = getDatatype(meta.type);

% Get the size of the data.
assert(isfield(meta, 'sizes') && ...
       isfield(meta, 'dimension') && ...
       isfield(meta, 'encoding') && ...
       isfield(meta, 'endian'), ...
       'Missing required metadata fields.')

dims = sscanf(meta.sizes, '%d');
ndims = sscanf(meta.dimension, '%d');
assert(numel(dims) == ndims);

disp(attributeList)

data = readData(fid, meta, datatype);
data = adjustEndian(data, meta);

% Reshape and get into MATLAB's order.
X = reshape(data, dims');
X = permute(X, [2 3 1]);

end


function datatype = getDatatype(metaType)

% Determine the datatype
switch (metaType)
 case {'signed char', 'int8', 'int8_t'}
  datatype = 'int8';
  
 case {'uchar', 'unsigned char', 'uint8', 'uint8_t'}
  datatype = 'uint8';

 case {'short', 'short int', 'signed short', 'signed short int', ...
       'int16', 'int16_t'}
  datatype = 'int16';
  
 case {'ushort', 'unsigned short', 'unsigned short int', 'uint16', ...
       'uint16_t'}
  datatype = 'uint16';
  
 case {'int', 'signed int', 'int32', 'int32_t'}
  datatype = 'int32';
  
 case {'uint', 'unsigned int', 'uint32', 'uint32_t'}
  datatype = 'uint32';
  
 case {'longlong', 'long long', 'long long int', 'signed long long', ...
       'signed long long int', 'int64', 'int64_t'}
  datatype = 'int64';
  
 case {'ulonglong', 'unsigned long long', 'unsigned long long int', ...
       'uint64', 'uint64_t'}
  datatype = 'uint64';
  
 case {'float'}
  datatype = 'single';
  
 case {'double'}
  datatype = 'double';
  
 otherwise
  assert(false, 'Unknown datatype')
end
end


function data = readData(fidIn, meta, datatype)

switch (meta.encoding)
 case {'raw'}
  
  data = fread(fidIn, inf, [datatype '=>' datatype]);
  
 case {'gzip', 'gz'}

  tmpBase = tempname();
  tmpFile = [tmpBase '.gz'];
  fidTmp = fopen(tmpFile, 'wb');
  assert(fidTmp > 3, 'Could not open temporary file for GZIP decompression')
  
  tmp = fread(fidIn, inf, 'uint8=>uint8');
  fwrite(fidTmp, tmp, 'uint8');
  fclose(fidTmp);
  
  gunzip(tmpFile)
  
  fidTmp = fopen(tmpBase, 'rb');
  cleaner = onCleanup(@() fclose(fidTmp));
  
  meta.encoding = 'raw';
  data = readData(fidTmp, meta, datatype);
  system(['del ' tmpFile]) 
  system(['del ' tmpBase])
  
 case {'txt', 'text', 'ascii'}
  
  data = fscanf(fidIn, '%f');
  data = cast(data, datatype);
  
 otherwise
  assert(false, 'Unsupported encoding')
end
end


function data = adjustEndian(data, meta)

[~,~,endian] = computer();

needToSwap = (isequal(endian, 'B') && isequal(lower(meta.endian), 'little')) || ...
             (isequal(endian, 'L') && isequal(lower(meta.endian), 'big'));
         
if (needToSwap)
    data = swapbytes(data);
end
end


function su_ca = extract_spaceunits_list( fieldValue )
fv_trimmed = strtrim( fieldValue );
su_ca = strsplit(fv_trimmed, '"');                              % units are delimited by double quotes
su_ca = su_ca(~ ( strcmp(su_ca, '') | strcmp(su_ca, ' ') ) );   % remove empty or blank space strings
for i = 1:length(su_ca)
    su_ca{i} = strtrim( su_ca{i} );
end
end


function iNrs = extractNumbersWithout( inputString, withoutTokens )

auxStr = inputString;

for iI=1:length( withoutTokens )
    
    auxStr = strrep( auxStr, withoutTokens{iI}, ' ' );
    
end
iNrs = sscanf( auxStr, '%f' );
end 


function fk = foundKeyword( keyWord, cs )
lenKeyword = length( keyWord );
fk = (lenKeyword <= length(cs)) && strcmpi( cs(1:lenKeyword), keyWord);
end

function sd = nrrd_getSpaceDimensions(spacedescriptor)
if any(strcmpi(spacedescriptor,...
        {'right-anterior-superior', 'RAS',...
        'left-anterior-superior', 'LAS',...
        'left-posterior-superior', 'LPS',...
        'scanner-xyz',...
        '3D-right-handed',...
        '3D-left-handed'}...
        ))
    sd = 3;
    
elseif any(strcmpi(spacedescriptor,...
        {'right-anterior-superior-time', 'RAST',...
        'left-anterior-superior-time', 'LAST',...
        'left-posterior-superior-time', 'LPST', ...
        'scanner-xyz-time', ...
        '3D-right-handed-time', ...
        '3D-left-handed-time'}...
        ))
    sd = 4;
    
else
    sd = -1;
    % Unrecognized nrrd space descriptor (grace under fire)
end
end
% Turn space-separated list into cell array of strings. 
function sl = extractStringList( strList )
sl = strsplit(strtrim(strList)); % This fixes it
end
