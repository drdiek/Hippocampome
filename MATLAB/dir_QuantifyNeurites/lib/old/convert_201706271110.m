function convert()

    addpath data lib
    
    nColors = 16;
    directory = './data/';
    suffix = 'png';
    
    [fileName] = get_file_name(directory, suffix);
      
    [base, layer, neurite] = parse_file_name(fileName);
    
    if ~strcmp(fileName, '!')
        
        [rgb, isRemoveColor, isCarouselMode, X, map, hMark] = initialize_figure(fileName, nColors);

        reply = [];
        
        nLayers = 0;
        
        % main loop to display menu choices and accept input
        % terminates when user chooses to exit
        while (isempty(reply))
            %% display menu %%
            
            clc;
            
            hMarkNo = length(find(hMark > 0));
            
            strng = sprintf('Please enter a selection from the menu below ');
            disp(strng);
            
            for i = 1:nColors
                strng = sprintf('        %2d) Remove color #%d?: %s', i, i, bin2str(isRemoveColor(i)));
                disp(strng);
            end
            
            disp('         c) Carousel mode (type ''m'' to mark color channel)');
            
            disp('         e) Export to an Excel file');
            
            disp('         f) Flip all toggles');
            
            strng = sprintf('         h) Display histogram of the %d marked color channels', hMarkNo);
            disp(strng);
            
            disp('         l) Load a new .PNG figure file');
            
            strng = sprintf('         m) Set all %d marked color-channel responses to NO', hMarkNo);
            disp (strng);
            
            disp('         n) Set all 16 responses to NO');
            
            disp('         p) Plot figure');
            
            disp('         s) Save figure and inverted figure');
            
            disp('         x) Execute conversion of figure to a histogram');
            
            disp('         !) Exit');
            
            reply = lower(input('\nYour selection: ', 's'));
            
            isEnterSwitch = 1;
            for i = 1:nColors
                if (str2double(reply) == i)
                    isRemoveColor(i) = ~isRemoveColor(i);
                    isEnterSwitch = 0;
                    reply = [];
                end
            end
            
            if isEnterSwitch
                
                switch reply
                    
                    case ''
                        disp('YO');
                        reply = [];
                    
                    case 'c' % carousel mode
                        savedResponses = isRemoveColor;
                        isRemoveColor = ones(nColors,1);
                        hMark = zeros(nColors,1);
                        
                        h = imhist(X, map);
                        
                        for i = 1:nColors
                            isRemoveColor(i) = ~isRemoveColor(i);
                            isCarouselMode = i;
                            [X, map] = update_figures(rgb, nColors, isRemoveColor, isCarouselMode);
                            ch = getkey;

                            if (ch == 109) % 'm'
                                hMark(i) = h(i);
                            end
                            
                            isRemoveColor(i) = ~isRemoveColor(i);                            
                        end
                        
                        nPixelsTotal = display_histogram_of_marked_color_channels(hMark);
                        
                        isRemoveColor = ~hMark;
                        isCarouselMode = 0;

                        reply = [];
                        
                    case 'e' % export to an Excel file
                        nLayers = nLayers + 1;
                        nPixelsExport(nLayers) = nPixelsTotal;
                        subregionsExport(nLayers) = menu_subregion();
                        export_to_excel(nColors, nPixelsExport, subregionsExport, base, layer, neurite, isRemoveColor);
                        reply = [];
                        
                    case 'f' % flip all toggles
                        for i = 1:nColors
                            isRemoveColor(i) = ~isRemoveColor(i);
                        end
                        reply = [];
                        
                    case 'h' % display histogram of marked color channels
                        nPixelsTotal = display_histogram_of_marked_color_channels(hMark);
                        reply = [];
                        
                    case 'l' % load new .PNG figure file
                        [fileName] = get_file_name(directory, suffix);
                        
                        [base, layer, neurite] = parse_file_name(fileName);
                        
                        [rgb, isRemoveColor, isCarouselMode, X, map, hMark] = initialize_figure(fileName, nColors);

                        reply = [];
                        
                    case 'm' % set all marked responses to NO
                        isRemoveColor = ~hMark;
                        reply = [];
                        
                    case 'n' % set all 16 responses to NO
                        isRemoveColor = zeros(nColors,1);
                        reply = [];
                        
                    case 'p' % plot figure
                        [X, map] = update_figures(rgb, nColors, isRemoveColor, isCarouselMode);
                        reply = [];
                        
                    case 's' % save figure and its inverse
                        idx = find(isRemoveColor == 0);
                        nOutColors = length(idx);
                        tagline = {'', '_inverted'};
                        [X, map] = update_figures(rgb, nColors, isRemoveColor, isCarouselMode);
                        
                        for i = 1:2
                        
                            outFileName = sprintf('%s_%s_%dcolors_%s_%dcolors%s.png', base, layer, nColors, neurite, nOutColors, tagline{i});
                            figure(1);
                            orient(gcf, 'portrait');
                            print(gcf, '-dpng', outFileName);
                            
                            isRemoveColor = ~isRemoveColor;
                            [X, map] = update_figures(rgb, nColors, isRemoveColor, isCarouselMode);
                        
                        end % i
                                                
                        reply = [];
                        
                    case 'x' % Execute conversion of figure to a histogram
                        idx = find(isRemoveColor == 0);
                        nOutColors = length(idx);
                        
                        nPixelsTotal = display_histogram_of_marked_color_channels(hMark);
                        
                        listFileName = sprintf('%s_%s_%dcolors_%s_%dcolors_list.txt', base, layer, nColors, neurite, nOutColors);
                        fid = fopen(listFileName, 'w');
                        for i = 1:nColors
                            if ~isRemoveColor(i)
                                fprintf(fid, '%d\n', i);
                            end
                        end
                        fclose(fid);
                        
                        reply = [];
                        
                    case '!'
                        %exit
                        
                    otherwise
                        reply = [];
                        
                end % switch
                
            end % if isEnterSwitch
            
        end % while loop

    end % if ~strcmp(fileName, '!')
        
    clean_exit()% exit
    
end % convert()

function nPixelsTotal = display_histogram_of_marked_color_channels(hMark)

    markIdx = find(hMark > 0);
    nMarkIdx = length(markIdx);
    if (nMarkIdx == 0)
        disp(' ');
        disp('There are no marked color channels to display');
        pause
    else
        disp(' ');
        for i = 1:nMarkIdx
            strng = sprintf('pixel count for color channel #%2d = %d', markIdx(i), hMark(markIdx(i)));
            disp(strng);
        end
        nPixelsTotal = sum(hMark(markIdx));
        disp(' ');
        disp(['pixel count total = ', num2str(nPixelsTotal)]);
        
        figure(2);
        clf;
        bar(hMark, 0.8, 'b')
        xlabel('Color Channel #');
        ylabel('Pixel Counts');
        pause
    end
                        
end % display_histogram_of_marked_color_channels
