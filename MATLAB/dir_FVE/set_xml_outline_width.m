function xmlOutline = set_xml_outline_width(xmlOutline, nNodesPerOutline);
            
    nodeWidth = 0.75;
    
    outlineBuffer = 0.125;
    

    outlineWidth = ((2 * nNodesPerOutline - 1) * nodeWidth) + (2 * outlineBuffer);

    strng = sprintf('<Width>%f</Width>', outlineWidth);
    
    xmlOutline{4,1} = strng;
    
    strng = sprintf('<TxtWidth F="Width*1.000000">%f</TxtWidth>', outlineWidth);
    
    xmlOutline{11,1} = strng;
    
    strng = sprintf('<LineTo IX="2"><X F="Width*1.000000">%f</X>', outlineWidth);
    
    xmlOutline{40,1} = strng;
    
    strng = sprintf('<LineTo IX="3"><X F="Width*1.000000">%f</X>', outlineWidth);
    
    xmlOutline{43,1} = strng;
    
end % function set_xml_outline_width
