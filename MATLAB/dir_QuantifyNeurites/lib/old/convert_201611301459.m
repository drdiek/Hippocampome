function convert()

    nColors = 16;
    
    pngFileNames = dir('*.png');
    nPngFileNames = length(pngFileNames);
    for i=1:nPngFileNames
        allPngFileNames{i,1} = pngFileNames(i).name;
    end
        
    nAllPngFileNames = length(allPngFileNames);
 
    if (nAllPngFileNames == 1)
        fileName = allPngFileNames{1};
    elseif (nAllPngFileNames > 1)
        [fileName, reply] = menu_file_name(allPngFileNames);
        if strcmp(reply, '!')
            return
        end
    end

%     fileName = 'BC2_SO_As.png';
    
    rgb=imread(fileName);
    
    figure(1);
    
    clf;
    
    imshow(rgb);
    
    [X_no_dither,map]= rgb2ind(rgb,nColors,'nodither');
    
    figure(2), imshow(X_no_dither,map);
    
    title(fileName);
    
       
    figure(3), imshow(X_no_dither,map);
    title(fileName);
    
    toggleCheckBox = zeros(nColors,1);
    
    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please enter a selection from the menu below ');
        disp(strng);

        for i = 1:nColors
        
            strng = sprintf('        %2d) Toggle removing color #%d: %s', i, i, bin2str(toggleCheckBox(i)));
            disp(strng);

        end
        
%         strng = sprintf(' 2) Toggle removing color #%d: %s', 2, bin2str(toggleCheckBox(2)));
%         disp(strng);
% 
%         strng = sprintf(' 3) Toggle removing color #%d: %s', 3, bin2str(toggleCheckBox(3)));
%         disp(strng);

        disp('         p) Plot figure');

        disp('         !) Exit');
        
        reply = lower(input('\nYour selection: ', 's'));

        whos
        pause
        
        isEnterSwitch = 1;
        for i = 1:nColors
            if (str2double(reply) == i)
                toggleCheckBox(i) = ~toggleCheckBox(i);
                isEnterSwitch = 0;
                reply = [];
            end
        end
        
        if isEnterSwitch
            switch reply
                
                %             for i = 1:nColors
                %                 case int2str(i)
                %                     toggleCheckBox(i) = ~toggleCheckBox(i);
                %                     reply = [];
                %             end
                
                %             case '1'
                %                 toggleCheckBox(1) = ~toggleCheckBox(1);
                %                 reply = [];
                %
                %             case '2'
                %                 toggleCheckBox(2) = ~toggleCheckBox(2);
                %                 reply = [];
                %
                %             case '3'
                %                 toggleCheckBox(3) = ~toggleCheckBox(3);
                %                 reply = [];
                %
                %             case '4'
                %                 toggleCheckBox(4) = ~toggleCheckBox(4);
                %                 reply = [];
                %
                %             case '5'
                %                 toggleCheckBox(5) = ~toggleCheckBox(5);
                %                 reply = [];
                %
                %             case '6'
                %                 toggleCheckBox(6) = ~toggleCheckBox(6);
                %                 reply = [];
                %
                %             case '7'
                %                 toggleCheckBox(7) = ~toggleCheckBox(7);
                %                 reply = [];
                %
                %             case '8'
                %                 toggleCheckBox(8) = ~toggleCheckBox(8);
                %                 reply = [];
                %
                %             case '9'
                %                 toggleCheckBox(9) = ~toggleCheckBox(9);
                %                 reply = [];
                %
                %             case '10'
                %                 toggleCheckBox(10) = ~toggleCheckBox(10);
                %                 reply = [];
                %
                %             case '11'
                %                 toggleCheckBox(11) = ~toggleCheckBox(11);
                %                 reply = [];
                %
                %             case '12'
                %                 toggleCheckBox(12) = ~toggleCheckBox(12);
                %                 reply = [];
                %
                %             case '13'
                %                 toggleCheckBox(13) = ~toggleCheckBox(13);
                %                 reply = [];
                %
                %             case '14'
                %                 toggleCheckBox(14) = ~toggleCheckBox(14);
                %                 reply = [];
                %
                %             case '15'
                %                 toggleCheckBox(15) = ~toggleCheckBox(15);
                %                 reply = [];
                %
                %             case '16'
                %                 toggleCheckBox(16) = ~toggleCheckBox(16);
                %                 reply = [];
                %
                case 'p'
                    figure(1);
                    [X_no_dither,map]= rgb2ind(rgb,nColors,'nodither');
                    whiteColors = find(toggleCheckBox == 1);
                    for i = 1:length(whiteColors)
                        map(whiteColors(i),1:3) = [1, 1, 1];
                    end
                    figure(3), imshow(X_no_dither,map);
                    title(fileName);
                    reply = [];
                    
                case '!'
                    %exit
                    
                otherwise
                    reply = [];
                    
            end % switch
        
        end % if isEnterSwitch
            
    end % while loop

    clean_exit()% exit
    
end
