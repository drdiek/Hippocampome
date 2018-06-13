function HC_bits

    [bits_PoK, txt, raw] = xlsread('bits_pieces-of-knowledge.csv')

    [bits_PoE, txt, raw] = xlsread('bits_pieces-of-evidence.csv')

    clf

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
    
    regionColor = regionColor / 255;
    
    GRAY = [0.5 0.5 0.5];
    GRAY_DARK = [0.25 0.25 0.25];
    GRAY_MEDIUM = [0.375 0.375 0.375];
    GRAY_LIGHT = [0.75 0.75 0.75];

    bitsScale = (5 * bits_PoK(:,4)) + 25;
    
%     bitsScale = 36*ones(121,1);
    
    regionColor(1,:)
    
    bitsColor = ones(121,3);
    
    for i = 1:121

        if (i < 19)
        
            bitsColor(i,1:3) = regionColor(DG,:);
            
        elseif (i < 44)
            
            bitsColor(i,1:3) = regionColor(CA3,:);
   
        elseif (i < 49)
            
            bitsColor(i,1:3) = regionColor(CA2,:);
   
        elseif (i < 88)
            
            bitsColor(i,1:3) = regionColor(CA1,:);
   
        elseif (i < 91)
            
            bitsColor(i,1:3) = regionColor(SUB,:);
   
        else
            
            bitsColor(i,1:3) = regionColor(EC,:);
   
        end
        
    end
    
    figure(1);
    
%     scatter3(bits_PoK(:,1), bits_PoK(:,2), bits_PoK(:,3), bitsScale, bitsColor, 'fill');
%     hold on;
    
    axis([0 20 0 20 0 10]);
    
%     for i = 1:121
%         
%         if ((bits_PoK(i,1) <= 20) && (bits_PoK(i,2) <= 20))
% 
%             scatter3(0, bits_PoK(i,2), bits_PoK(i,3), 30, GRAY_LIGHT, 'fill', 'LineWidth', 2);
%             scatter3(bits_PoK(i,1), 0, bits_PoK(i,3), 30, GRAY_LIGHT, 'fill', 'LineWidth', 2);
%             scatter3(bits_PoK(i,1), bits_PoK(i,2), 0, 30, GRAY_LIGHT, 'fill', 'LineWidth', 2);
% %             plot(bits_PoK(i,1),bits_PoK(i,2),'o','MarkerEdgeColor',GRAY_LIGHT,'MarkerFaceColor',GRAY_LIGHT,'MarkerSize',3);
%             hold on;
%             
%         end
%         
%     end

    for i = 1:121
        
        if ((bits_PoK(i,1) <= 20) && (bits_PoK(i,2) <= 20))

            if (bits_PoK(i,5) == 1)
            
                scatter3(bits_PoK(i,1), bits_PoK(i,2), bits_PoK(i,3), bitsScale(i), bitsColor(i,1:3), 'fill', 'LineWidth', 2);
                hold on;
                
            else
            
                scatter3(bits_PoK(i,1), bits_PoK(i,2), bits_PoK(i,3), bitsScale(i), bitsColor(i,1:3), 'fill', 'LineWidth', 2);
                hold on;
        
            end
            
%             plot3([bits_PoK(i,1); bits_PoK(i,1)], [bits_PoK(i,2); bits_PoK(i,2)], [bits_PoK(i,3); 0], '--', 'LineWidth', 0.5, 'Color', bitsColor(i,1:3));
            p = patchline([bits_PoK(i,1); bits_PoK(i,1)], [bits_PoK(i,2); bits_PoK(i,2)], [bits_PoK(i,3); 0], 'linestyle', '-', 'edgecolor', bitsColor(i,1:3), 'linewidth', 2, 'edgealpha',0.2);
%             p = patchline(xs,ys,zs,'linestyle','--','edgecolor','g','linewidth',3,'edgealpha',0.2);
            hold on;
            
        end
        
    end

    title('Pieces of Knowledge');
    
    xlabel('Morphology');

    ylabel('Markers');

    zlabel('Electrophysiology');

    hold off;
    
%     figure(2);
%     
%     scatter(bits_PoK(:,2), bits_PoK(:,3), (10*bits_PoK(:,1)+50), bitsColor, 'LineWidth',2);%, 'fill')
% 
% %     scatter(bits(:,2),bits(:,3),bitsScale,bitsColor,'fill');
%     
%     title('Pieces of Knowledge');
%     
%     xlabel('Markers');
% 
%     zlabel('Electrophysiology');

    % plot3(bits(:,1),bits(:,2),bits(:,3))

    % pcolor(bits)
