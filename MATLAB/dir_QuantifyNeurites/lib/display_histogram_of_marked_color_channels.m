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
                        
end % display_histogram_of_marked_color_channels()
