function XML_node_generator()

    xmlNodeHeader = importdata('FVE_XML_node_header.txt');

    xmlNodeFooter = importdata('FVE_XML_node_footer.txt');

    
    dlmcell('FVE_XML_100-pin_node.txt', xmlNodeHeader);
    

    connectionIdNo = 0;
    
    lineNo = 1;
    
    deltaH = 0.5 / 51;
        
    
    for width = 0:1
        
        widthStep = 0.75 * width;
        
        for iHeight = 1:50
            
            strng = sprintf('<Connection ID="%d">', connectionIdNo);
            
            xmlNode{lineNo,1} = strng;
            
            lineNo = lineNo + 1;
            
            strng = sprintf('<X F="Width*%.6f">%.2f</X>', width, widthStep);
            
            xmlNode{lineNo,1} = strng;
            
            lineNo = lineNo + 1;
            
            strng = sprintf('<Y F="Height*1.000000">%.16f</Y>', iHeight * deltaH);
            
            xmlNode{lineNo,1} = strng;
            
            lineNo = lineNo + 1;
            
            strng = sprintf('<Type>0</Type>');
            
            xmlNode{lineNo,1} = strng;
            
            lineNo = lineNo + 1;
            
            strng = sprintf('</Connection>');
            
            xmlNode{lineNo,1} = strng;
            
            lineNo = lineNo + 1;
            
            
            connectionIdNo = connectionIdNo + 1;
            
        end % for height
        
    end % for width
    
    
    dlmcell('FVE_XML_100-pin_node.txt', xmlNode, '-a');
    
    dlmcell('FVE_XML_100-pin_node.txt', xmlNodeFooter, '-a');
    
end
