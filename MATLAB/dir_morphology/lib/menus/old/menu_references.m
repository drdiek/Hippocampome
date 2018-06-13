function menu_references(csvFileName)

%     csvLoadedText = ['unloaded';
%                      'loaded  '];
    
%     isCsvLoadedReferences = 1;

%     cellsConvertedText = ['unconverted';
%                           'converted  ']; 

%     areCellsConvertedReferencess = 0;

%     savedText = ['unsaved';
%                  'saved  '];

%     areNotataionsSaved = 0;

%     computedText = ['uncomputed';
%                     'computed  '];

%     parsedtext = ['unparsed';
%                   'parsed  '];

%     areNotationsParsed = 0;

%     reply = [];
    
%     % main loop to display menu choices and accept input
%     % terminates when user chooses to exit
%     while (isempty(reply))

%         clc;
%         strng = sprintf('Please enter a selection from the menu below ');
%         strng = sprintf('%s(current values in parentheses): \n', strng);
%         disp(strng);

%         strng = sprintf('    1) csv file {csvFileName} (');
%         strng = sprintf('%s%s', strng, deblank(csvFileName));
%         strng = sprintf('%s)', strng);
%         disp(strng);

%         strng = sprintf('   2) Load references csv file {cellsReferences} (');
%         strng = sprintf('%s%s', strng, ...
%                         deblank(csvLoadedText(isCsvLoadedReferences+1,:)));
%         strng = sprintf('%s)', strng);
%         disp(strng);

%         strng = sprintf('   3) Convert references cells data to Rij {Rij} (');
%         strng = sprintf('%s%s', strng, ...
%                         deblank(csvLoadedText(isCsvLoadedReferences+1,:)));
%         strng = sprintf('%s,%s)', strng, ...
%                         deblank(cellsConvertedText(areCellsConvertedReferences+1,:)));
%         disp(strng);

%         % if cells are converted, display more menu choices
%         if (areCellsConvertedReferences)

%             strng = sprintf('    p) Parse references notations (');
%             strng = sprintf('%s%s)', strng, deblank(parsedText(areReferencesParsed+1,:)));
%             disp(strng);

%             if (areReferencesParsed)

%                 strng = sprintf('    s) Save parsed notations (');
%                 strng = sprintf('%s%s', strng, deblank(savedText(areNotationsSaved+1,:)));            
%                 strng = sprintf('%s)', strng);
%                 disp(strng);

%             end
            
%         end % if areCellsConverted
        
%         disp('    !) Exit');
        
%         reply = input('\nYour selection: ', 's');

%         switch reply
               
%             case '1'
%                 [csvFileName, isCsvLoadedReferences] = get_csv_file_name(csvFileName);
%                 reply = [];

%             case '2'
%                 [cellsReferences, isCsvLoadedReferences] = ...
%                     load_csvFile(csvFileName);

%                 current_references_data(cellsReferenes); 
%                 reply = [];

%             case '3'
%                 [referenceIds, notesInterpretations, areCellsConvertedReferences] = cells2rij(cellsReferences);
%                 reply = [];

%             case 'p'
%                 if areCellsConvertedReferences
%                     [notations] = parse_notations(referenceIds, notesInterpretations);
%                 end
%                 reply = [];

%             case 's'
%                 if areReferencesParsed
%                     [areNotataionsSaved] = save_notations(notations);
%                 end
%                 reply = [];

%             case '!'
%                 ; % exit
                
%             otherwise
%                 reply = [];
        
%         end % switch
        
%     end % while loop

    [cellsReferences, isCsvLoadedReferences] = load_csvFile(csvFileName);

cellsReferences
pause

    current_references_data;

    [referenceIds, notesInterpretations, areCellsConvertedReferences] ...
        = cells2rij(cellsReferences)

    [notations] = parse_notations(referenceIds, notesInterpretations);

    [areNotataionsSaved] = save_notations(notations);
    
    % For record keeping, display in the command window the version of
    %   MATLAB being run.

    strng = sprintf('\nMATLAB Version %s.\n\nFinis.\n', version);
    disp(strng);

end % references_menu()


