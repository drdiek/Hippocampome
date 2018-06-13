function add_highlights(fileName, data1, data2, dataMerged)
% Code based on work by Thomas Koelen on 8 May 2015

    % Connect to Excel
    Excel = actxserver('excel.application');
    % Get Workbook object
    WB = Excel.Workbooks.Open(fullfile(pwd, fileName), 0, false);
    
    % Set the color of cells updated from data file #1 of Sheet 1 to Orange
    for i = 1:length(data1.HCID)
        cellNoStr = sprintf('A%d', data1.HCID(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 45;
    end
    
    % Set the color of cells updated from data file #2 of Sheet 1 to Yellow
    for i = 1:length(data2.HCID)
        cellNoStr = sprintf('A%d', data2.HCID(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 6;
    end
    
    % Set the color of cells updated from both data files of Sheet 1 to Red
    for i = 1:length(dataMerged.HCID)
        cellNoStr = sprintf('A%d', dataMerged.HCID(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 3;
    end
    
    % Set the color of cells updated from data file #1 of Sheet 1 to Orange
    for i = 1:length(data1.exclusion)
        cellNoStr = sprintf('B%d', data1.exclusion(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 45;
    end
    
    % Set the color of cells updated from data file #2 of Sheet 1 to Yellow
    for i = 1:length(data2.exclusion)
        cellNoStr = sprintf('B%d', data2.exclusion(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 6;
    end
    
    % Set the color of cells updated from both data files of Sheet 1 to Red
    for i = 1:length(dataMerged.exclusion)
        cellNoStr = sprintf('B%d', dataMerged.exclusion(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 3;
    end
    
    % Set the color of cells updated from data file #1 of Sheet 1 to Orange
    for i = 1:length(data1.STID)
        cellNoStr = sprintf('C%d', data1.STID(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 45;
    end
    
    % Set the color of cells updated from data file #2 of Sheet 1 to Yellow
    for i = 1:length(data2.STID)
        cellNoStr = sprintf('C%d', data2.STID(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 6;
    end
    
    % Set the color of cells updated from both data files of Sheet 1 to Red
    for i = 1:length(dataMerged.STID)
        cellNoStr = sprintf('C%d', dataMerged.STID(i));
        WB.Worksheets.Item(1).Range(cellNoStr).Interior.ColorIndex = 3;
    end
    
    % Save Workbook
    WB.Save();
    % Close Workbook
    WB.Close();
    % Quit Excel
    Excel.Quit();

end % add_highlights()