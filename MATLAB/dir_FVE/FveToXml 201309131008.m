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
    
    plotOrder = [35; 22; 23; 21; 17; 18; 20; 33; 34; 19; 14; 15; 16; 29; 28; 24; 25; 10; 11; 12; 13; 32; 7; 31; 30; 26; 9; 8; 6; 27; 5; 3; 4; 2; 1];

    lineWeight = 0.01388888888888889;
    
    DG_COLOR = '#5B2D0A';   % 91-45-10
    CA3_COLOR = '#A5836B';  % 165-131-107
    CA2_COLOR = '#FFFF00';  % 255-255-0
    CA1_COLOR = '#D9680D';  % 217-104-13
    SUB_COLOR = '#FFC000';  % 255-192-0
    EC_COLOR = '#5A6F2F';   % 90-111-47
    
    xmlHeader = importdata('FVE_XML_header.txt');

    xmlFooter = importdata('FVE_XML_footer.txt');

    xmlCluster = importdata('FVE_XML_cluster.txt');

    xmlOutline = importdata('FVE_XML_outline.txt');

    xmlShapeFooter = {''; '</Shape>'};
    
    xmlShapesHeader = {''; '<Shapes>'; ''};
    
    xmlShapesFooter = {''; '</Shapes>'};
    
    iObject = 1;
    

    dlmcell('FVE_XML_demo.vdx', xmlHeader);
    
        % Add a cluster
    
        dlmcell('FVE_XML_demo.vdx', {''}, '-a');
    
        dlmcell('FVE_XML_demo.vdx', xmlShapesHeader, '-a');
        
        dlmcell('FVE_XML_demo.vdx', {''}, '-a');
    
        strng = sprintf('<Shape ID="%d" Type="Group" Name="Group.%d"><XForm><Angle>-0</Angle>', iObject, iObject);

        iObject = iObject + 1;
        
        xmlCluster{1,1} = strng;
        
%         strng = sprintf('<PinX>%f</PinX>', 2);
%         
%         xmlCluster{2,1} = strng;
%         
%         strng = sprintf('<PinY>%f</PinY>', 19);
%         
%         xmlCluster{3,1} = strng;

        dlmcell('FVE_XML_demo.vdx', xmlCluster, '-a');
        
            % Add a cluster outline
    
            dlmcell('FVE_XML_demo.vdx', {''}, '-a');
            
            dlmcell('FVE_XML_demo.vdx', xmlShapesHeader, '-a');
            
            dlmcell('FVE_XML_demo.vdx', {''}, '-a');
        
            strng = sprintf('<Shapes><Shape ID="%d" Type="Shape" Name="Rectangle Fill:Chalk.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
        
            iObject = iObject + 1;
        
            xmlOutline{1,1} = strng;

%             strng = sprintf('<PinX>%f</PinX>', 1.75);
%             
%             xmlOutline{2,1} = strng;
% 
%             strng = sprintf('<LineColor>%s</LineColor>', DG_COLOR);
%             
%             xmlOutline{20,1} = strng;

            dlmcell('FVE_XML_demo.vdx', xmlOutline, '-a');
            
                % Add a node
            
                dlmcell('FVE_XML_demo.vdx', {''}, '-a');
        
                xmlNode = importdata('FVE_XML_node.txt');
                
                strng = sprintf('<Shape ID="%d" Type="Shape" Name="Rectangle Fill:Chalk.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
                
                iObject = iObject + 1;
                
                xmlNode{1,1} = strng;
        
                dlmcell('FVE_XML_demo.vdx', xmlNode, '-a');  

            dlmcell('FVE_XML_demo.vdx', xmlOutlineFooter, '-a');

        dlmcell('FVE_XML_demo.vdx', {''}, '-a');
    
        dlmcell('FVE_XML_demo.vdx', xmlClusterFooter, '-a');


%         % Add a cluster
%     
%         strng = sprintf('<Shape ID="%d" Type="Group" Name="Group.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
% 
%         iObject = iObject + 1;
%         
%         xmlCluster{1,1} = strng;
%         
%         strng = sprintf('<PinX>%f</PinX>', 10);
%         
%         xmlCluster{2,1} = strng;
%         
%         strng = sprintf('<PinY>%f</PinY>', 19);
%         
%         xmlCluster{3,1} = strng;
% 
%         dlmcell('FVE_XML_demo.vdx', xmlCluster, '-a');
%         
%         dlmcell('FVE_XML_demo.vdx', {''}, '-a');
%         
%             % Add a cluster outline
%     
%             strng = sprintf('<Shapes><Shape ID="%d" Type="Shape" Name="Rectangle Fill:Chalk.%d"><XForm><Angle>-0</Angle>', iObject, iObject);
%         
%             iObject = iObject + 1;
%         
%             xmlOutline{1,1} = strng;
% 
%             strng = sprintf('<PinX>%f</PinX>', 1.75);
%             
%             xmlOutline{2,1} = strng;
% 
%             strng = sprintf('<LineColor>%s</LineColor>', CA1_COLOR);
%             
%             xmlOutline{20,1} = strng;
% 
%             dlmcell('FVE_XML_demo.vdx', xmlOutline, '-a');
% 
%             dlmcell('FVE_XML_demo.vdx', xmlOutlineFooter, '-a');
% 
%         dlmcell('FVE_XML_demo.vdx', {''}, '-a');
%     
%         dlmcell('FVE_XML_demo.vdx', xmlClusterFooter, '-a');


   
   

%             strng = sprintf('<PinX>%f</PinX>', 9);
%             
%             xmlOutline{3,1} = strng;
% 
%             strng = sprintf('<LineColor>%s</LineColor>', CA1_COLOR);
%             
%             xmlOutline{21,1} = strng;
% 
%             dlmcell('FVE_XML_demo.vdx', xmlOutline, '-a');
% 
%             dlmcell('FVE_XML_demo.vdx', xmlOutlineFooter, '-a');

%         dlmcell('FVE_XML_demo.vdx', xmlClusterFooter, '-a');

    
    dlmcell('FVE_XML_demo.vdx', {''}, '-a');
    
    dlmcell('FVE_XML_demo.vdx', xmlFooter, '-a');
    
    return
    
    
    fid = fopen('FVE_original.xml', 'w');
    
    fprintf(fid, 'digraph hdg {\n\n');
	fprintf(fid, '\trankdir=LR;\n');
    fprintf(fid, '\toutputorder="edgesfirst";\n');
	fprintf(fid, '\tsize="10,7.5";\n\n');
    fprintf(fid, '\tnode [shape = record, color = black];\n\n');
    
    
    fprintf(fid, '\tsubgraph cluster_1011 {\n');
%     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

        fprintf(fid, '\tsubgraph cluster_11 {\n');
        %     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
        %     fprintf(fid, '\t\tpenwidth=2.0;\n');
        fprintf(fid, '\t\tcolor = white;\n\n');
        
        fprintf(fid, '\t\tnode35[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,35});
        
        fprintf(fid, '\t\tnode22[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,22});
        
        fprintf(fid, '\t\tnode23[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,23});
        
        fprintf(fid, '\tnode35:e -> node22:w [arrowhead=none, color=black];\n');
        
        fprintf(fid, '\tnode22:e -> node23:w [arrowhead=none, color=white];\n');
        
%         fprintf(fid, '\t\trank = same; 35; 22; 23;\n\n'); 
        
        fprintf(fid, '\t}\n\n');
        
        
        fprintf(fid, '\tsubgraph cluster_10 {\n');
        %     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
        %     fprintf(fid, '\t\tpenwidth=2.0;\n');
        fprintf(fid, '\t\tcolor = white;\n\n');
        
        fprintf(fid, '\t\tnode21[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,21});
        
        fprintf(fid, '\t\tnode17[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,17});
        
        fprintf(fid, '\t\tnode18[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,18});
        
        fprintf(fid, '\tnode21:e -> node17:w [arrowhead=none, color=black];\n');
        
        fprintf(fid, '\tnode17:e -> node18:w [arrowhead=none, color=white];\n');
        
        fprintf(fid, '\t}\n\n');
        
        
        fprintf(fid, '\t{node22:n -> node21:s [arrowhead=none, color=white];}\n');
    
    
    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_9 {\n');
%     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode20[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,20});
    
    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_8 {\n');
%     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode33[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,33});
    
    fprintf(fid, '\t\tnode34[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,34});
        
    fprintf(fid, '\t\tnode19[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,19});
        
    fprintf(fid, '\t\tnode14[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,14});
    
    fprintf(fid, '\t\tnode15[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,15});
        
    fprintf(fid, '\t\tnode16[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,16});
        
    fprintf(fid, '\tnode33:e -> node34:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\tnode34:e -> node19:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\tnode19:e -> node14:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\tnode14:e -> node15:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\tnode15:e -> node16:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\t}\n\n');

    
%     fprintf(fid, '\t{node18:s -> node16:n [arrowhead=none, color=white];}\n');
    
    
    fprintf(fid, '\tsubgraph cluster_7 {\n');
%     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode29[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,29});
    
    fprintf(fid, '\t\tnode28[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,28});
        
    fprintf(fid, '\t\tnode24[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,24});
        
    fprintf(fid, '\t\tnode25[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,25});
    
    fprintf(fid, '\t\tnode10[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,10});
        
    fprintf(fid, '\t\tnode11[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,11});
        
    fprintf(fid, '\t\tnode12[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,12});
        
    fprintf(fid, '\t\tnode13[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,13});
        
    fprintf(fid, '\tnode29:e -> node28:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\tnode28:e -> node24:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\tnode24:e -> node25:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\tnode25:e -> node10:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\tnode10:e -> node11:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\tnode11:e -> node12:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\tnode12:e -> node13:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_6 {\n');
%     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode32[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,32});
    
    fprintf(fid, '\t\tnode7[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,7});
        
    fprintf(fid, '\tnode32:e -> node7:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_5 {\n');
%     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode31[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,31});
    
    fprintf(fid, '\t\tnode30[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,30});
        
    fprintf(fid, '\t\tnode26[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,26});
        
    fprintf(fid, '\t\tnode9[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,9});
    
    fprintf(fid, '\t\tnode8[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,8});
        
    fprintf(fid, '\t\tnode6[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,6});
        
    fprintf(fid, '\tnode31:e -> node30:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\tnode30:e -> node26:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\tnode26:e -> node9:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\tnode9:e -> node8:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\tnode8:e -> node6:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_4 {\n');
%     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode27[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,27});
    
    fprintf(fid, '\t\tnode5[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,5});
        
    fprintf(fid, '\tnode27:e -> node5:w [arrowhead=none, color=white];\n');

    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_3 {\n');
%     fprintf(fid, '\t\tlabel = "Type 2 unique inputs";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode3[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,3});
    
    fprintf(fid, '\t\tnode4[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,4});
    
    fprintf(fid, '\tnode3:e -> node4:w [arrowhead=none, color=black];\n');

    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_2 {\n');
%     fprintf(fid, '\t\tlabel = "Common inputs";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode2[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,2});
    
    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_1 {\n');
%     fprintf(fid, '\t\tlabel = "DG granule cell unique inputs";\n');
%     fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = white;\n\n');

    fprintf(fid, '\t\tnode1[style=filled, fillcolor=white, label = "%s", color = "purple", penwidth=2.0];\n\n', regionNames{1,1});

    fprintf(fid, '\t}\n\n');

    
    fclose(fid);return;
    
    
    penDescStr = '[arrowhead=none,color=black,penwidth=1.0]';

    
    for i = 1:5
        
        for j = 1:5
            
            if (Cij(i,j))
                
                fprintf(fid, '\tnode%d -> node%d %s;\n', plotOrder(i), plotOrder(j), penDescStr);
                
            end
            
        end % for j
        
    end % for i
    
%     penDescStrPosKnown = {'[arrowhead=empty,arrowsize=4.0,color=red,penwidth=2.0]'};
%     
%     penDescStrNeg = {'[arrowhead=odot,arrowsize=2.0,color=blue,penwidth=1.0]'};
% 
%     penDescStrNegKnown = {'[arrowhead=dot,arrowsize=4.0,color=blue,penwidth=2.0]'};
% 
%     iNode = 1;
% 
%     for i=nType1InputsUnique:-1:1
%         
%         if (nodeSign(iNode))
%             if (type1InputsUniqueKnown(i))
%                 fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', iNode, nNodesInput+1, penDescStrPosKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', iNode, nNodesInput+1, penDescStrPos{1});
%             end
%         else
%             if (type1InputsUniqueKnown(i))
%                 fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', iNode, nNodesInput+1, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', iNode, nNodesInput+1, penDescStrNeg{1});
%             end
%         end
%         iNode = iNode + 1;
%         
%     end
%        
%     
%     for i=nInputsCommon:-1:1
%     
%         if (nodeSign(iNode))
%             if (inputsCommonKnown(i,1))
%                 fprintf(fid, '\tnode%d:ne -> node%d:nw %s;\n', iNode, nNodesInput+1, penDescStrPosKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:ne -> node%d:nw %s;\n', iNode, nNodesInput+1, penDescStrPos{1});
%             end
%         else
%             if (inputsCommonKnown(i,1))
%                 fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+1, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+1, penDescStrNeg{1});
%             end
%         end
%         if (nodeSign(iNode))
%             if (inputsCommonKnown(i,2))
%                 fprintf(fid, '\tnode%d:ne -> node%d:nw %s;\n', iNode, nNodesInput+2, penDescStrPosKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:ne -> node%d:nw %s;\n', iNode, nNodesInput+2, penDescStrPos{1});
%             end
%         else
%             if (inputsCommonKnown(i,2))
%                 fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNeg{1});
%             end
%         end
%         iNode = iNode + 1;
%         
%     end
%     
%     
%     for i=nType2InputsUnique:-1:1
%         
%         if (nodeSign(iNode))
%             if (type2InputsUniqueKnown(i))
%                 fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', iNode, nNodesInput+2, penDescStrPosKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', iNode, nNodesInput+2, penDescStrPos{1});
%             end
%         else
%             if (type2InputsUniqueKnown(i))
%                 fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNeg{1});
%             end
%         end
%         iNode = iNode + 1;
%         
%     end
%     
%     
%     iNode = iNode + 2;
%     
%     
%     for i=nType1OutputsUnique:-1:1
%         
%         if (nodeSign(nNodesInput+1))
%             if (type1OutputsUniqueKnown(i))
%                 fprintf(fid, '\tnode%d:ne -> node%d:w %s;\n', nNodesInput+1, iNode, penDescStrPosKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:ne -> node%d:w %s;\n', nNodesInput+1, iNode, penDescStrPos{1});
%             end
%         else
%             if (type1OutputsUniqueKnown(i))
%                 fprintf(fid, '\tnode%d:ne -> node%d:w %s;\n', nNodesInput+1, iNode, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:ne -> node%d:w %s;\n', nNodesInput+1, iNode, penDescStrNeg{1});
%             end
%         end
%         iNode = iNode + 1;
%         
%     end
%        
%     for i=nOutputsCommon:-1:1
%     
%         if (nodeSign(nNodesInput+1))
%             if (outputsCommonKnown(i,1))
%                 fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', nNodesInput+1, iNode, penDescStrPosKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', nNodesInput+1, iNode, penDescStrPos{1});
%             end
%         else
%             if (outputsCommonKnown(i,1))
%                 fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', nNodesInput+1, iNode, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', nNodesInput+1, iNode, penDescStrNeg{1});
%             end
%         end
%         if (nodeSign(nNodesInput+2))
%             if (outputsCommonKnown(i,2))
%                 fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', nNodesInput+2, iNode, penDescStrPosKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', nNodesInput+2, iNode, penDescStrPos{1});
%             end
%         else
%             if (outputsCommonKnown(i,2))
%                 fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', nNodesInput+2, iNode, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', nNodesInput+2, iNode, penDescStrNeg{1});
%             end
%         end
%         iNode = iNode + 1;
%         
%     end
%     
%     for i=nType2OutputsUnique:-1:1
%         
%         if (nodeSign(nNodesInput+2))
%             if (type2outputsUniqueKnown(i))
%                 fprintf(fid, '\tnode%d:se -> node%d:w %s;\n', nNodesInput+2, iNode, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:se -> node%d:w %s;\n', nNodesInput+2, iNode, penDescStrNeg{1});
%             end
%         else
%             if (type2outputsUniqueKnown(i))
%                 fprintf(fid, '\tnode%d:se -> node%d:w %s;\n', nNodesInput+2, iNode, penDescStrNegKnown{1});
%             else
%                 fprintf(fid, '\tnode%d:se -> node%d:w %s;\n', nNodesInput+2, iNode, penDescStrNeg{1});
%             end
%         end
%         iNode = iNode + 1;
%         
%     end
% 
%     
    fprintf(fid, '\n}');
    
    fclose(fid);
    
    copyfile('FVE_original.gv','C:\Users\Diek\Dropbox\FVE_original.gv','f');
    
    
end
