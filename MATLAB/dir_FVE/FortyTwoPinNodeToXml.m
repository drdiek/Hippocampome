function FveToXml()

    %% load name of first neuronal type
    %
    [num txt raw] = xlsread('FVE_Table_3.xlsx');
    regionNames = txt(1,2:end);
    Cij = num;
    clear num txt raw;
        
    idx = find(Cij ~= 1);
    Cij(idx) = 0;

    N = length(regionNames);
    N = 1;
    
    plotOrder = [1];

    clusterNumber = [1];

    clusterOrder = [1];
    
    nClusterTabStops= [6];
    
    nNodesPerCluster = [1];
    
    nClusters = length(nNodesPerCluster);

    
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
    
    outlineColors = [DG_COLOR];
    

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
    

    xmlNode = importdata('FVE_XML_100-pin_node.txt');
    
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
    
    nodeConnectionsCounterBottom = ones(N,1);
    
    nodeConnectionsCounterTop = 19*ones(N,1);
    

    xmlConnections = {''; '<Connects>'};
    
    dlmcell('FVE_XML_demo.vdx', xmlHeader);
    
        dlmcell('FVE_XML_demo.vdx', xmlLayoutHeader, '-a');
            
        for iCluster = 1:nClusters
        
            % Add a cluster
            
            xClusterCurrent = xClusterStart + (nClusterTabStops(iCluster) * xClusterTab);
            
            dlmcell('FVE_XML_demo.vdx', xmlClusterHeader, '-a');
            
            strng = sprintf('<Shape ID="%d" Type="Group" Name="Group.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
            
            iObject = iObject + 1;
            
            xmlCluster{1,1} = strng;
            
            
            strng = sprintf('<PinX>%f</PinX>', xClusterCurrent);
            
            xmlCluster{2,1} = strng;
            
            strng = sprintf('<PinY>%f</PinY>', yClusterCurrent);
            
            xmlCluster{3,1} = strng;
            
            
            strng = sprintf('<Width>%f</Width>', (nNodesPerCluster(iCluster)+1) * xNodeTab);% + (2 * xNodeStart) + (xmlNodeWidth / 2));
            
            xmlCluster{4,1} = strng;
            
            strng = sprintf('<Height>%f</Height>', 1.0 * xmlNodeHeight);
            
            xmlCluster{5,1} = strng;
            
            
            dlmcell('FVE_XML_demo.vdx', xmlCluster, '-a');
            
                % Add an outline

                dlmcell('FVE_XML_demo.vdx', xmlOutlineHeader, '-a');
                
                
                xmlOutlineWidth = ((nNodesPerCluster(iCluster) - 1) * xNodeTab) + xmlNodeWidth + 0.25;
                

                strng = sprintf('<Shape ID="%d" Type="Shape" Name="Rectangle Fill:Chalk.%d"><XForm><Angle>-0</Angle>', iObject, iObject);

                iObject = iObject + 1;

                xmlOutline{1,1} = strng;

                strng = sprintf('<Width>%f</Width>', xmlOutlineWidth);
                
                xmlCluster{4,1} = strng;
                
                
                strng = sprintf('<TxtWidth F="Width*1.000000">3.5</TxtWidth>', xmlOutlineWidth);

                xmlOutline{11,1} = strng;


                strng = sprintf('<LineWeight>%f</LineWeight>', 3*lineWeight);

                xmlOutline{19,1} = strng;

                xmlOutline = set_xml_outline_width(xmlOutline, nNodesPerCluster(iCluster));

                strng = sprintf('<LineColor>%s</LineColor>', outlineColors(iCluster,:));

                xmlOutline{20,1} = strng;

                
                strng = sprintf('<LineTo IX="2"><X F="Width*1.000000">%f</X>', xmlOutlineWidth);
                
                xmlOutline{40,1} = strng;

                strng = sprintf('<LineTo IX="3"><X F="Width*1.000000">%f</X>', xmlOutlineWidth);

                xmlOutline{43,1} = strng;

                
                dlmcell('FVE_XML_demo.vdx', xmlOutline, '-a');

                xNodeCurrent = xNodeStart;

                for iClusterNode = 1:nNodesPerCluster(iCluster)

                    % Add a node
                
                    dlmcell('FVE_XML_demo.vdx', xmlNodeHeader, '-a');
                    
                    strng = sprintf('<Shape ID="%d" Type="Shape" Name="Rectangle Fill:Chalk.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
                    
                    nodeNumbers(plotOrder(iNode)) = iObject;
                    
                    iObject = iObject + 1;
                    
                    xmlNode{1,1} = strng;
                    
                    strng = sprintf('<PinX>%f</PinX>', xNodeCurrent);
                    
                    xmlNode{2,1} = strng;
                    
                    nodeTag = regionNames{plotOrder(iNode)};
                    
                    strng = sprintf('%s%s%s', xmlNodeTagHeader, nodeTag, xmlNodeTagFooter);
                    
                    xmlNode{xmlNodeLength-1,1} = strng;
                    
                    dlmcell('FVE_XML_demo.vdx', xmlNode, '-a');
                    
                    dlmcell('FVE_XML_demo.vdx', xmlNodeFooter, '-a');
                    

%                     i = plotOrder(iNode);
%                     
%                     lineCounter = 1;
%                         
%                     for j = 1:N
%                         
%                         if (Cij(i,j))
%                             
%                             if (lineCounter == 1)
%                             
%                                 % Add a line
%                                 
%                                 dlmcell('FVE_XML_demo.vdx', xmlLineHeader, '-a');
%                                 
%                                 strng = sprintf('<Shape ID="%d" Type="Shape" Name="Graphic.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
%                                 
%                                 xmlLine{1,1} = strng;
%                                 
%                                 strng = sprintf('<PinX>%f</PinX>', xNodeCurrent);
%                                 
%                                 xmlNode{2,1} = strng;
%                                 
%                                 strng = sprintf('<LineColor>%s</LineColor>', BLUE);
%                                 
%                                 xmlLine{31,1} = strng;
%                                 
%                                 strng = sprintf('<EndArrow>%d</EndArrow>', circleheadOpen);
%                                 
%                                 xmlLine{35,1} = strng;
%                                 
%                                 dlmcell('FVE_XML_demo.vdx', xmlLine, '-a');
%                                 
%                                 dlmcell('FVE_XML_demo.vdx', xmlLineFooter, '-a');
%                                 
%                                 
%                                 if (clusterNumber(i) < clusterNumber(j))
%                                     
%                                     iNodeConnectionsOutput = nodeConnectionsCounterBottom(i);
%                                     
%                                     nodeConnectionsCounterBottom(i) = nodeConnectionsCounterBottom(i) + 1;
%                                     
%                                     jNodeConnectionsInput = nodeConnectionsCounterTop(j);
%                                     
%                                     nodeConnectionsCounterTop(j) = nodeConnectionsCounterTop(j) + 1;
%                                     
%                                 elseif (clusterNumber(i) > clusterNumber(j))
%                                     
%                                     iNodeConnectionsOutput = nodeConnectionsCounterTop(i);
%                                     
%                                     nodeConnectionsCounterTop(i) = nodeConnectionsCounterTop(i) + 1;
%                                     
%                                     jNodeConnectionsInput = nodeConnectionsCounterBottom(j);
%                                     
%                                     nodeConnectionsCounterBottom(j) = nodeConnectionsCounterBottom(j) + 1;
%                                     
%                                 elseif (clusterOrder(i) < clusterOrder(j))
%                                     
%                                     iNodeConnectionsOutput = 39;
% 
%                                     jNodeConnectionsInput = 0; 
%                                     
%                                 else
%                                     
%                                     iNodeConnectionsOutput = 0;
% 
%                                     jNodeConnectionsInput = 39; 
%                                     
%                                 end
%                                 
%                                 
%                                 strng = sprintf('<Connect ToCell="Connections.Row_%d.X" FromSheet="%d" FromPart="9" ToSheet="%d" ToPart="%d"/>', iNodeConnectionsOutput, iObject, nodeNumbers(plotOrder(i)), 100+iNodeConnectionsOutput);
%                                 
%                                 xmlConnections{end+1,1} = strng;
%                                 
%                                 strng = sprintf('<Connect ToCell="Connections.Row_%d.X" FromSheet="%d" FromPart="12" ToSheet="%d" ToPart="%d"/>', jNodeConnectionsInput, iObject, nodeNumbers(plotOrder(j)), 100+jNodeConnectionsInput);
%                                 
%                                 xmlConnections{end+1,1} = strng;
%                                 
%                                 
%                                 iObject = iObject + 1;
%                                 
%                             end % if (lineCounter == 1)
%                             
%                             lineCounter = lineCounter + 1;
% 
%                         end % if Cij
%                         
%                     end % for j
                    
                    
                    xNodeCurrent = xNodeCurrent + xNodeTab;
                    
                    iNode = iNode + 1;

                end % for iClusterNode
                
                dlmcell('FVE_XML_demo.vdx', xmlOutlineFooter, '-a');
                
            dlmcell('FVE_XML_demo.vdx', xmlClusterFooter, '-a');
                
            yClusterCurrent = yClusterCurrent + yClusterTab;
                
        end % for iCluster
        
        if (1 == 1)
            
                    lineCounter = 1;
                        
                for i = 1:N
                    
                    for j = 1:N
                        
                        if (Cij(i,j))
                            
                            if (lineCounter == 1)
                            
                                % Add a line
                                
                                dlmcell('FVE_XML_demo.vdx', xmlLineHeader, '-a');
                                
                                strng = sprintf('<Shape ID="%d" Type="Shape" Name="Graphic.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
                                
                                xmlLine{1,1} = strng;
                                
                                strng = sprintf('<PinX>%f</PinX>', xNodeCurrent);
                                
                                xmlNode{2,1} = strng;
                                
                                strng = sprintf('<LineColor>%s</LineColor>', BLUE);
                                
                                xmlLine{31,1} = strng;
                                
                                strng = sprintf('<EndArrow>%d</EndArrow>', circleheadOpen);
                                
                                xmlLine{35,1} = strng;
                                

                                strng = sprintf('<LayerMem><LayerMember>1</LayerMember>');
                                
                                xmlLine{62,1} = strng;
                                
                                
                                dlmcell('FVE_XML_demo.vdx', xmlLine, '-a');
                                
                                dlmcell('FVE_XML_demo.vdx', xmlLineFooter, '-a');
                                
                                
                                if (clusterNumber(i) < clusterNumber(j))
                                    
                                    iNodeConnectionsOutput = nodeConnectionsCounterBottom(i);
                                    
                                    nodeConnectionsCounterBottom(i) = nodeConnectionsCounterBottom(i) + 1;
                                    
                                    jNodeConnectionsInput = nodeConnectionsCounterTop(j);
                                    
                                    nodeConnectionsCounterTop(j) = nodeConnectionsCounterTop(j) + 1;
                                    
                                elseif (clusterNumber(i) > clusterNumber(j))
                                    
                                    iNodeConnectionsOutput = nodeConnectionsCounterTop(i);
                                    
                                    nodeConnectionsCounterTop(i) = nodeConnectionsCounterTop(i) + 1;
                                    
                                    jNodeConnectionsInput = nodeConnectionsCounterBottom(j);
                                    
                                    nodeConnectionsCounterBottom(j) = nodeConnectionsCounterBottom(j) + 1;
                                    
                                elseif (clusterOrder(i) < clusterOrder(j))
                                    
                                    iNodeConnectionsOutput = 39;

                                    jNodeConnectionsInput = 0; 
                                    
                                else
                                    
                                    iNodeConnectionsOutput = 0;

                                    jNodeConnectionsInput = 39; 
                                    
                                end
                                
                                
                                strng = sprintf('<Connect ToCell="Connections.Row_%d.X" FromSheet="%d" FromPart="9" ToSheet="%d" ToPart="%d"/>', iNodeConnectionsOutput, iObject, nodeNumbers(plotOrder(i)), 100+iNodeConnectionsOutput);
                                
                                xmlConnections{end+1,1} = strng;
                                
                                strng = sprintf('<Connect ToCell="Connections.Row_%d.X" FromSheet="%d" FromPart="12" ToSheet="%d" ToPart="%d"/>', jNodeConnectionsInput, iObject, nodeNumbers(plotOrder(j)), 100+jNodeConnectionsInput);
                                
                                xmlConnections{end+1,1} = strng;
                                
                                
                                iObject = iObject + 1;
                                
                            end % if (lineCounter == 1)
                            
                            lineCounter = lineCounter + 1;

                        end % if Cij
                        
                    end % for j
                    
                end % for i
                
        end % if (1 == 0)
                    
        dlmcell('FVE_XML_demo.vdx', xmlLayoutFooter, '-a');
        
        xmlConnections{end+1,1} = '</Connects>';
        
        xmlConnections{end+1,1} = '';
        
        dlmcell('FVE_XML_demo.vdx', xmlConnections, '-a');
                    
    dlmcell('FVE_XML_demo.vdx', xmlFooter, '-a');
        
end
