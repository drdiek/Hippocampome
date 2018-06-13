function FortyPinNode2Xml()

    %% load name of first neuronal type
    %
    
    DG_COLOR = '#5B2D0A';   % 91-45-10
    CA3_COLOR = '#A5836B';  % 165-131-107
    CA2_COLOR = '#FFFF00';  % 255-255-0
    CA1_COLOR = '#D9680D';  % 217-104-13
    SUB_COLOR = '#FFC000';  % 255-192-0
    EC_COLOR = '#5A6F2F';   % 90-111-47
    
    RED = '#FF0000';
    GREEN = '#008000';
    BLUE = '#0000FF';
    WHITE = '#FFFFFF';
    BLACK = '#000000';
    
    outlineColors = [DG_COLOR; CA3_COLOR; CA2_COLOR; CA1_COLOR; SUB_COLOR; EC_COLOR; DG_COLOR; CA3_COLOR; CA2_COLOR; CA1_COLOR; SUB_COLOR];
    

    lineWeight = 0.01388888888888889;
    
    xmlHeader = importdata('FVE_XML_header.txt');

    xmlFooter = importdata('FVE_XML_footer.txt');

    
    xmlLayoutHeader = {''; '<Shapes>'};
    
    xmlLayoutFooter = {''; '</Shapes>'};
    

    xmlCluster = importdata('FVE_XML_cluster.txt');

    xmlClusterHeader = {''};
    
    xmlClusterFooter = {''; '</Shape>'};
    

    xmlOutline = importdata('FVE_XML_outline.txt');

    xmlOutlineHeader = {''; '<Shapes>'; ''};
    
    xmlOutlineFooter = {''; '</Shapes>'};
    

    xmlNode = importdata('FVE_XML_40-pin_node.txt');
    
    xmlNodeLength = size(xmlNode,1);
    
    xmlNodeHeader = {''};
    
    xmlNodeFooter = {''};
    

    xmlLine = importdata('FVE_XML_line.txt');

    xmlLineHeader = {''};
    
    xmlLineFooter = {''};

    
    xmlNodeTagHeader = '<Char IX="0"><Font>0</Font><Color>0</Color><Style>0</Style><Size>0.1944444444444444</Size><ColorTrans>0</ColorTrans></Char><Para IX="0"><IndFirst>0</IndFirst><IndLeft>0</IndLeft><IndRight>-0</IndRight><SpLine>-1.2</SpLine><SpBefore>0</SpBefore><HorzAlign>1</HorzAlign></Para><Text><cp IX="0"/><pp IX="0"/>';
    xmlNodeTagFooter = '</Text>';

    
    xmlNodeWidth = 0.80;
    xmlNodeHeight = 0.50;
    
    xNodeStart = 0.5;
    xNodeTab = 2 * xmlNodeWidth;
        
    xClusterStart = 2*xNodeTab;
    xClusterCurrent = xClusterStart;
    xClusterTab = xmlNodeWidth;
    
    yClusterStart = 19.75;
    yClusterCurrent = yClusterStart;
    yClusterTab = -1.125*1.5;
    
    
    xWebCoords = xNodeStart + ([0:9] * xNodeTab) + (xmlNodeWidth / 2);
    
    yWebCoords = yClusterStart - ([0:9] * yClusterTab) + (yClusterTab / 2);
        
    
    arrowheadFilled = 4;
    arrowheadOpen = 16;
    circleheadFilled = 42;
    circleheadOpen = 41;

    endLineSizePotential = 3;
    endLineSizeKnown = 4;
    
    iObject = 1;
    
    iNode = 1;
    

                    % Add a node
                
                    dlmcell('FVE_XML_demo.vdx', xmlNodeHeader, '-a');
                    
                    strng = sprintf('<Shape ID="%d" Type="Shape" Name="Rectangle Fill:Chalk.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
                    
                    nodeNumbers(iNode) = iObject;
                    
                    iObject = iObject + 1;
                    
                    xmlNode{1,1} = strng;
                    
                    strng = sprintf('<PinX>%f</PinX>', iNode);
                    
                    xmlNode{2,1} = strng;
                    
                    nodeTag = '1';
                    
                    strng = sprintf('%s%s%s', xmlNodeTagHeader, nodeTag, xmlNodeTagFooter);
                    
                    xmlNode{xmlNodeLength-1,1} = strng;
                    
                    dlmcell('FVE_XML_demo.vdx', xmlNode, '-a');
                    
                    dlmcell('FVE_XML_demo.vdx', xmlNodeFooter, '-a');
                    

        dlmcell('FVE_XML_demo.vdx', xmlLayoutFooter, '-a');
        
                    
    dlmcell('FVE_XML_demo.vdx', xmlFooter, '-a');
        
end
