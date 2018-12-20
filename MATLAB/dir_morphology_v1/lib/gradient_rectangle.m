function gradient_rectangle(minX,minY,deltaX,deltaY,color1,color2,nSteps)

    dX = deltaX / nSteps;
    
%                 rectangle('Position', [vTAB+0.5-r hTab+0.5-r 2*r 2*r], 'Curvature',[1,1], 'EdgeColor', LIGHT_GRAY, ...
%                     'FaceColor', LIGHT_GRAY);

    deltaR = color2(1) - color1(1);
        
    deltaG = color2(2) - color1(2);
        
    deltaB = color2(3) - color1(3);

    dR = deltaR / nSteps;
        
    dG = deltaG / nSteps;
        
    dB = deltaB / nSteps;
        
    for i = 0:nSteps-1
      
        currentColor = [color1(1)+(i*dR) color1(2)+(i*dG) color1(3)+(i*dB)];
        
        rectangle('Position', [minX+(i*dX) minY dX deltaY], 'FaceColor', currentColor, 'EdgeColor', currentColor, 'linewidth', 0.001);
        
    end
    
    line ([minX, minX], [minY, minY+deltaY], 'color', [0 0 0], 'linewidth', 0.5);
    line ([minX, minX+deltaX], [minY+deltaY, minY+deltaY], 'color', [0 0 0], 'linewidth', 0.5);
    line ([minX+deltaX, minX+deltaX], [minY+deltaY, minY], 'color', [0 0 0], 'linewidth', 0.5);
    line ([minX+deltaX, minX], [minY, minY], 'color', [0 0 0], 'linewidth', 0.5);    
    
end % function gradient_rectangle