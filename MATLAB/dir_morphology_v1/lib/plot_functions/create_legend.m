function [vTab, hTab] = create_legend(vTab, hTab, displayFontSize, line_width, ...
                                      isIncludeKnownNegNeuriteLocations, isIncludeFlaggedDuplicates)

    GRAY = [0.5 0.5 0.5];
    PURPLE = [0.5 0 0.5];

    text(vTab, hTab, 'Black (+) = excitatory', 'HorizontalAlignment', 'left', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'k'); % black

    vTab = vTab + 1;

    text(vTab, hTab, 'Gray (-) = inhibitory', 'HorizontalAlignment', 'left', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'Color', GRAY); % gray

    vTab = vTab + 2;

    text(vTab, hTab, 'p = projecting neuron', 'HorizontalAlignment', 'left', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'k'); % black

    vTab = vTab + 2;

    hold on;
    %    vTab = 4;
    xx = [vTab vTab (vTab+1) (vTab+1)];
    yy = [(hTab-1) hTab hTab (hTab-1)];
    fill(xx,yy,'r');
    line([vTab+0.5, vTab+0.5], [hTab-0.95, hTab-0.05], 'linewidth', line_width, 'color', 'w');  
    vTab = vTab + 0.5;
    hTab = hTab - 1.5;
    text(vTab, hTab, '= axons present', 'HorizontalAlignment', 'left', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'r');

    vTab = vTab + 0.5;
    hTab = hTab + 1.5;
    xx = [vTab vTab (vTab+1) (vTab+1)];
    yy = [(hTab-1) hTab hTab (hTab-1)];
    fill(xx,yy,'b');
    line([vTab+0.05, vTab+0.95], [hTab-0.5, hTab-0.5], 'linewidth', line_width, 'color', 'w');  
    vTab = vTab + 0.5;
    hTab = hTab - 1.5;
    text(vTab, hTab, '= dendrites present', 'HorizontalAlignment', 'left', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'b');

    vTab = vTab + 0.5;
    hTab = hTab + 1.5;
    xx = [vTab vTab (vTab+1) (vTab+1)];
    yy = [(hTab-1) hTab hTab (hTab-1)];
    fill(xx,yy,PURPLE);
    line([vTab+0.5, vTab+0.5], [hTab-0.95, hTab-0.05], 'linewidth', line_width, 'color', 'w');  
    line([vTab+0.05, vTab+0.95], [hTab-0.5, hTab-0.5], 'linewidth', line_width, 'color', 'w');  
    vTab = vTab + 0.5;
    hTab = hTab - 1.5;
    text(vTab, hTab, '= both present', 'HorizontalAlignment', 'left', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'Color', PURPLE);

    vTab = vTab + 2;

    text(vTab, hTab, '* = single reference packet', 'HorizontalAlignment', 'left', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'k'); % black


    if isIncludeKnownNegNeuriteLocations

        vTab = vTab + 0.5;
        hTab = hTab + 1.5;
        line([vTab+0.05, vTab+0.95], [hTab-0.95, hTab+0.05], 'linewidth', line_width/2, 'color', 'r');  
        line([vTab+0.05, vTab+0.95], [hTab+0.05, hTab-0.95], 'linewidth', line_width/2, 'color', 'r');  
        vTab = vTab + 0.5;
        hTab = hTab - 1.5;
        text(vTab, hTab, '= axons absent', 'HorizontalAlignment', 'left', ...
             'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'r');

        vTab = vTab + 0.5;
        hTab = hTab + 1.5;
        line([vTab+0.05, vTab+0.95], [hTab-0.95, hTab+0.05], 'linewidth', line_width/2, 'color', 'b');  
        line([vTab+0.05, vTab+0.95], [hTab+0.05, hTab-0.95], 'linewidth', line_width/2, 'color', 'b');  
        vTab = vTab + 0.5;
        hTab = hTab - 1.5;
        text(vTab, hTab, '= dendrites absent', 'HorizontalAlignment', 'left', ...
             'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'b');

        vTab = vTab + 0.5;
        hTab = hTab + 1.5;
        line([vTab+0.05, vTab+0.95], [hTab-0.95, hTab+0.05], 'linewidth', line_width/2, 'color', PURPLE);
        line([vTab+0.05, vTab+0.95], [hTab+0.05, hTab-0.95], 'linewidth', line_width/2, 'color', PURPLE);
        vTab = vTab + 0.5;
        hTab = hTab - 1.5;
        text(vTab, hTab, '= both absent', 'HorizontalAlignment', 'left', ...
             'Rotation', 90, 'FontSize', displayFontSize, 'Color', PURPLE);

    end % if isIncludeKnownNegNeuriteLocations


    if isIncludeFlaggedDuplicates

        vTab = vTab + 1.5;
        hTab = 0;
        text(vTab, hTab, 'a,b,c,... = label identical patterns', 'HorizontalAlignment', 'left', ...
             'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'k');

    end

end