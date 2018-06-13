function convert(nColors)

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
    
    figure(3)
    for k=1:ncolors; 
        cbh(k) = uicontrol('Style','checkbox','String',int2str(k), ...
            'Value',0,'Position',[30 20*k 130 20],        ...
            'Callback',{@checkBoxCallback,k});
    end
    
    whiteColors = [];%[1:8 11:13 16];%
    
    for i = 1:length(whiteColors)
        
        map(whiteColors(i),1:3) = [1, 1, 1];
        
    end
    
    figure, imshow(X_no_dither,map);
    
    title(fileName);

end


function checkBoxCallback(hObject,eventData,checkBoxId)

    value = get(hObject,'Value');

    if value
        switch checkBoxId
            case 1
                fprintf('handle cb 1\n');
            case 2
                fprintf('handle cb 2\n');
            otherwise
                fprintf('do nothing\n');
        end
    end
end
