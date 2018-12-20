function region_color_box(vTab, hTabStart, hTabEnd, regionCode)

    DG = 1;
    CA3 = 2;
    CA2 = 3;
    CA1 = 4;
    SUB = 5;
    EC = 6;

    regionColor = [ 91  45  10;  ... % DG
                   165 131 107;  ... % CA3
                   255 255   0;  ... % CA2
                   217 104  13;  ... % CA1
                   255 192   0;  ... % SUB
                     0 127   0]; ... % EC
%                    122 187  51;  ... % EC1 
%                     90 111  47]; ... % EC2
    
    regionColor = regionColor / 255;

    xx = [vTab-0.5 vTab-0.5 (vTab+0.05) (vTab+0.05)];
    yy = [hTabEnd hTabStart hTabStart hTabEnd];
    fill(xx,yy,regionColor(regionCode,:),'EdgeColor','None');

%     if (regionCode == EC)
%     
%         xx = [vTab-0.5 vTab-0.5 (vTab+0.05)];
%         yy = [hTabStart hTabEnd hTabEnd];
%         fill(xx,yy,regionColor(regionCode+1,:),'EdgeColor','None');
% 
%     end
    
end