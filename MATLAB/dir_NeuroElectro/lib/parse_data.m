function parsedData = parse_data(savedData, n)

    disp('parsing data ...');

    for i = 1:n
        
        txt = savedData{i};
        
        % find NeuroElectro Index
        idx = strfind(txt, ',');
        if ~isempty(idx)
            parsedData(i).index = str2num(txt(1:idx(1)-1));
            parsedData(i).title = txt(idx(1)+1:idx(2)-1);
            parsedData(i).pmid = str2num(txt(idx(2)+1:idx(3)-1));
            parsedData(i).pubYear = str2num(txt(idx(3)+1:idx(4)-1));
            parsedData(i).firstAuthor = txt(idx(4)+1:idx(5)-1);
            parsedData(i).lastAuthor = txt(idx(5)+1:idx(6)-1);
            parsedData(i).articleId = str2num(txt(idx(6)+1:idx(7)-1));
            parsedData(i).tableId = str2num(txt(idx(7)+1:idx(8)-1));
            parsedData(i).neuronName = txt(idx(8)+1:idx(9)-1);
            parsedData(i).neuronLongName = txt(idx(9)+1:idx(10)-1);
            parsedData(i).neuronPrefName = txt(idx(10)+1:idx(11)-1);
        end
        
%         % find NeuroElectro Index
%         txtLen = length(txt);
%         for j = 1:txtLen
%             if (double(txt(j)) >= 65 || double(txt(j)) == 32)
%                 mark = j;
%                 parsedData(i).index = txt(1:mark-1);
%                 txt = txt(mark:end);
%                 break;
%             end % if
%         end % j
% 
%         % find Article Title
%         idx = strfind(txt, '.');
%         parsedData(i).title = txt(1:idx(1)-1);
%         txt = txt(idx(1)+1:end);
% 
%         % find PMID
%         txtLen = length(txt);
%         for j = 1:txtLen
%             if (double(txt(j)) >= 65)
%                 mark = j;
%                 parsedData(i).pmid = txt(1:mark-1);
%                 txt = txt(mark:end);
%                 break;
%             end % if
%         end % j
%         
%         % find FirstAuthorLastAuthor
%         txtLen = length(txt);
%         for j = 1:txtLen
%             if (double(txt(j)) < 65)
%                 mark = j;
%                 parsedData(i).firstAuthorLastAuthor = txt(1:mark-1);
%                 txt = txt(mark:end);
%                 break;
%             end % if
%         end % j
%         
%         % find NeuroElectro Article ID
%         idx = strfind(txt, '.');
%         parsedData(i).articleId = txt(1:idx(1)-1);
%         txt = txt(idx(1)+1:end);
% 
%         % find NeuroElectro Table ID
%         txtLen = length(txt);
%         for j = 1:txtLen
%             if (double(txt(j)) >= 65)
%                 mark = j;
%                 parsedData(i).tableId = txt(1:mark-1);
%                 txt = txt(mark:end);
%                 break;
%             end % if
%         end % j
%         
%         % find Neuron Name
%         idx = strfind(txt, '[');
%         parsedData(i).neuronName = txt(1:idx(1)-1);
%         txt = txt(idx(1)+1:end);

    end % i
    
end % parse_data()