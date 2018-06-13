function allInputsOutputsToGv()

    load overlap.mat
    load parcellation.mat
    load Cij.mat Cij cellAbbrevs cellSubregions cellADcodes cellProjecting cellLabels cellEorIs cellUniqueIds
    load CijKnownClassLinks.mat
    load CijKnownNegClassLinks.mat
    load CijAxonSomaOverlap.mat
    load isInclude.mat
    
    
    %% load name of first neuronal type
    %
    [num txt raw] = xlsread('type1.xlsx');
    type1Name = txt;
    idx = find(type1Name{1,1} == ')');
    type1NameStr = type1Name{1,1}(1:idx);
    clear num txt raw;
        
    %% load name of second neuronal type
    %
    [num txt raw] = xlsread('type2.xlsx');
    type2Name = txt;
    idx = find(type2Name{1,1} == ')');
    type2NameStr = type2Name{1,1}(1:idx);
    clear num txt raw;
        

    %% load unique inputs of first neuronal type
    %
    [num txt raw] = xlsread('type1-inputs-unique.xlsx');
    type1InputsUnique = txt;
    nType1InputsUnique = size(type1InputsUnique,1);
    type1InputsUniqueKnown = num;
    clear num txt raw;
        
    %% load unqiue outputs of first neuronal type
    %
    [num txt raw] = xlsread('type1-outputs-unique.xlsx');
    type1OutputsUnique = txt;
    nType1OutputsUnique = size(type1OutputsUnique,1);
    type1OutputsUniqueKnown = num;
    clear num txt raw;

    
    %% load unique inputs of second neuronal type
    %
    [num txt raw] = xlsread('type2-inputs-unique.xlsx');
    type2InputsUnique = txt;
    nType2InputsUnique = size(type2InputsUnique,1);
    type2InputsUniqueKnown = num;
    clear num txt raw;
        
    %% load unqiue outputs of second neuronal type
    %
    [num txt raw] = xlsread('type2-outputs-unique.xlsx');
    type2OutputsUnique = txt;
    nType2OutputsUnique = size(type2OutputsUnique,1);
    type2OutputsUniqueKnown = num;
    clear num txt raw;

    
    %% load all common inputs
    %
    [num txt raw] = xlsread('inputs-common.xlsx');
    inputsCommon = txt;
    nInputsCommon = size(inputsCommon,1);
    inputsCommonKnown = num;
    clear num txt raw;
        
    %% load all common outputs
    %
    [num txt raw] = xlsread('outputs-common.xlsx');
    outputsCommon = txt;
    nOutputsCommon = size(outputsCommon,1);
    outputsCommonKnown = num;
    clear num txt raw;

            
    fid = fopen('inputs-outputs.gv', 'w');
    
    fprintf(fid, 'digraph hdg {\n\n');
	fprintf(fid, '\trankdir=LR;\n');
	fprintf(fid, '\tsize="10,7.5";\n\n');
    fprintf(fid, '\tnode [shape=ellipse, fixedsize=true, width=5.0, fontsize=20];\n\n');
    
    
    nNodesInput = nType1InputsUnique+nInputsCommon+nType2InputsUnique;
    nNodesOutput = nType1OutputsUnique+nOutputsCommon+nType2OutputsUnique;
    
    iNode = 1;
    
    fprintf(fid, '\tsubgraph cluster_1 {\n');
    fprintf(fid, '\t\tlabel = "%s unique inputs";\n', type1NameStr);
    fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = black;\n\n');

        fprintf(fid, '\tsubgraph cluster_1_1 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');
        
        for i = nType1InputsUnique:-2:1
            
            idx = find(type1InputsUnique{i,1} == ')');
            type1InputsUniqueStr = type1InputsUnique{i,1}(1:idx);
            
            if (find(type1InputsUnique{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type1InputsUniqueStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type1InputsUniqueStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
    
        fprintf(fid, '\t}\n\n');


        fprintf(fid, '\tsubgraph cluster_1_2 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        
        for i = nType1InputsUnique-1:-2:1
            
            idx = find(type1InputsUnique{i,1} == ')');
            type1InputsUniqueStr = type1InputsUnique{i,1}(1:idx);
            
            if (find(type1InputsUnique{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type1InputsUniqueStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type1InputsUniqueStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
    
        fprintf(fid, '\t}\n\n');

    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_2 {\n');
    fprintf(fid, '\t\tlabel = "Common inputs";\n');
    fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = black;\n\n');

        fprintf(fid, '\tsubgraph cluster_2_1 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nInputsCommon:-2:1
            
            idx = find(inputsCommon{i,1} == ')');
            inputsCommonStr = inputsCommon{i,1}(1:idx);
            
            if (find(inputsCommon{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, inputsCommonStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, inputsCommonStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');

        
        fprintf(fid, '\tsubgraph cluster_2_2 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nInputsCommon-1:-2:1
            
            idx = find(inputsCommon{i,1} == ')');
            inputsCommonStr = inputsCommon{i,1}(1:idx);
            
            if (find(inputsCommon{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, inputsCommonStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, inputsCommonStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');
        
    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_3 {\n');
    fprintf(fid, '\t\tlabel = "%s unique inputs";\n', type2NameStr);
    fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = black;\n\n');

        fprintf(fid, '\tsubgraph cluster_3_1 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nType2InputsUnique:-2:1
            
            idx = find(type2InputsUnique{i,1} == ')');
            type2InputsUniqueStr = type2InputsUnique{i,1}(1:idx);
            
            if (find(type2InputsUnique{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type2InputsUniqueStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type2InputsUniqueStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');

        
        fprintf(fid, '\tsubgraph cluster_3_2 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nType2InputsUnique-1:-2:1
            
            idx = find(type2InputsUnique{i,1} == ')');
            type2InputsUniqueStr = type2InputsUnique{i,1}(1:idx);
            
            if (find(type2InputsUnique{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type2InputsUniqueStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type2InputsUniqueStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');
        
    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_4 {\n');
%     fprintf(fid, '\t\tlabel = "Types 1 & 2";\n');
    fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = black;\n\n');

    if (find(type1Name{1,1} == '+'))
        fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type1NameStr);
        nodeSign(iNode) = 1;
    else
        fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type1NameStr);
        nodeSign(iNode) = 0;
    end
    iNode = iNode + 1;
    
    if (find(type2Name{1,1} == '+'))
        fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type2NameStr);
        nodeSign(iNode) = 1;
    else
        fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type2NameStr);
        nodeSign(iNode) = 0;
    end
    iNode = iNode + 1;
    
    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_5 {\n');
    fprintf(fid, '\t\tlabel = "%s unique outputs";\n', type1NameStr);
    fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = black;\n\n');

        fprintf(fid, '\tsubgraph cluster_5_1 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nType1OutputsUnique:-2:1
            
            idx = find(type1OutputsUnique{i,1} == ')');
            type1OutputsUniqueStr = type1OutputsUnique{i,1}(1:idx);
            
            if (find(type1OutputsUnique{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type1OutputsUniqueStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type1OutputsUniqueStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');

    
        fprintf(fid, '\tsubgraph cluster_5_2 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nType1OutputsUnique-1:-2:1
            
            idx = find(type1OutputsUnique{i,1} == ')');
            type1OutputsUniqueStr = type1OutputsUnique{i,1}(1:idx);
            
            if (find(type1OutputsUnique{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type1OutputsUniqueStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type1OutputsUniqueStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');
    
    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_6 {\n');
    fprintf(fid, '\t\tlabel = "Common outputs";\n');
    fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = black;\n\n');

        fprintf(fid, '\tsubgraph cluster_6_1 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nOutputsCommon:-2:1
            
            idx = find(outputsCommon{i,1} == ')');
            outputsCommonStr = outputsCommon{i,1}(1:idx);
            
            if (find(outputsCommon{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, outputsCommonStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, outputsCommonStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');

        
        fprintf(fid, '\tsubgraph cluster_6_2 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nOutputsCommon-1:-2:1
            
            idx = find(outputsCommon{i,1} == ')');
            outputsCommonStr = outputsCommon{i,1}(1:idx);
            
            if (find(outputsCommon{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, outputsCommonStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, outputsCommonStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');
        
    fprintf(fid, '\t}\n\n');

    
    fprintf(fid, '\tsubgraph cluster_7 {\n');
    fprintf(fid, '\t\tlabel = "%s unique outputs";\n', type2NameStr);
    fprintf(fid, '\t\tpenwidth=2.0;\n');
    fprintf(fid, '\t\tcolor = black;\n\n');

        fprintf(fid, '\tsubgraph cluster_7_1 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nType2OutputsUnique:-2:1
            
            idx = find(type2OutputsUnique{i,1} == ')');
            type2OutputsUniqueStr = type2OutputsUnique{i,1}(1:idx);
            
            if (find(type2OutputsUnique{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type2OutputsUniqueStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type2OutputsUniqueStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');
     
        
        fprintf(fid, '\tsubgraph cluster_7_2 {\n');
        fprintf(fid, '\t\tlabel = "";\n');
        fprintf(fid, '\t\tcolor = white;\n\n');

        for i = nType2OutputsUnique-1:-2:1
            
            idx = find(type2OutputsUnique{i,1} == ')');
            type2OutputsUniqueStr = type2OutputsUnique{i,1}(1:idx);
            
            if (find(type2OutputsUnique{i,1} == '+'))
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "red", penwidth=2.0];\n\n', iNode, type2OutputsUniqueStr);
                nodeSign(iNode) = 1;
            else
                fprintf(fid, '\t\tnode%d[style=filled, fillcolor=white, label = "%s", color = "blue", penwidth=2.0];\n\n', iNode, type2OutputsUniqueStr);
                nodeSign(iNode) = 0;
            end
            iNode = iNode + 1;
            
        end
        
        fprintf(fid, '\t}\n\n');
     
    fprintf(fid, '\t}\n\n');

    
    %%%%%
    
    
    penDescStrPos = {'[arrowhead=normal,arrowsize=2.0,color=red,penwidth=1.0]'};
    
    penDescStrPosKnown = {'[arrowhead=empty,arrowsize=4.0,color=red,penwidth=2.0]'};
    
    penDescStrNeg = {'[arrowhead=odot,arrowsize=2.0,color=blue,penwidth=1.0]'};

    penDescStrNegKnown = {'[arrowhead=dot,arrowsize=4.0,color=blue,penwidth=2.0]'};

    iNode = 1;

    for i=nType1InputsUnique:-1:1
        
        if (nodeSign(iNode))
            if (type1InputsUniqueKnown(i))
                fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', iNode, nNodesInput+1, penDescStrPosKnown{1});
            else
                fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', iNode, nNodesInput+1, penDescStrPos{1});
            end
        else
            if (type1InputsUniqueKnown(i))
                fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', iNode, nNodesInput+1, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', iNode, nNodesInput+1, penDescStrNeg{1});
            end
        end
        iNode = iNode + 1;
        
    end
       
    
    for i=nInputsCommon:-1:1
    
        if (nodeSign(iNode))
            if (inputsCommonKnown(i,1))
                fprintf(fid, '\tnode%d:ne -> node%d:nw %s;\n', iNode, nNodesInput+1, penDescStrPosKnown{1});
            else
                fprintf(fid, '\tnode%d:ne -> node%d:nw %s;\n', iNode, nNodesInput+1, penDescStrPos{1});
            end
        else
            if (inputsCommonKnown(i,1))
                fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+1, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+1, penDescStrNeg{1});
            end
        end
        if (nodeSign(iNode))
            if (inputsCommonKnown(i,2))
                fprintf(fid, '\tnode%d:ne -> node%d:nw %s;\n', iNode, nNodesInput+2, penDescStrPosKnown{1});
            else
                fprintf(fid, '\tnode%d:ne -> node%d:nw %s;\n', iNode, nNodesInput+2, penDescStrPos{1});
            end
        else
            if (inputsCommonKnown(i,2))
                fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNeg{1});
            end
        end
        iNode = iNode + 1;
        
    end
    
    
    for i=nType2InputsUnique:-1:1
        
        if (nodeSign(iNode))
            if (type2InputsUniqueKnown(i))
                fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', iNode, nNodesInput+2, penDescStrPosKnown{1});
            else
                fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', iNode, nNodesInput+2, penDescStrPos{1});
            end
        else
            if (type2InputsUniqueKnown(i))
                fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNeg{1});
            end
        end
        iNode = iNode + 1;
        
    end
    
    
    fprintf(fid, '\tnode%d:s -> node%d:n %s;\n', iNode, nNodesInput+2, penDescStrPosKnown{1});

    iNode = iNode + 1;

    fprintf(fid, '\tnode%d:se -> node%d:sw %s;\n', iNode, nNodesInput+2, penDescStrNeg{1});

    iNode = iNode + 1;
    
    
    
    for i=nType1OutputsUnique:-1:1
        
        if (nodeSign(nNodesInput+1))
            if (type1OutputsUniqueKnown(i))
                fprintf(fid, '\tnode%d:ne -> node%d:w %s;\n', nNodesInput+1, iNode, penDescStrPosKnown{1});
            else
                fprintf(fid, '\tnode%d:ne -> node%d:w %s;\n', nNodesInput+1, iNode, penDescStrPos{1});
            end
        else
            if (type1OutputsUniqueKnown(i))
                fprintf(fid, '\tnode%d:ne -> node%d:w %s;\n', nNodesInput+1, iNode, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:ne -> node%d:w %s;\n', nNodesInput+1, iNode, penDescStrNeg{1});
            end
        end
        iNode = iNode + 1;
        
    end
       
    for i=nOutputsCommon:-1:1
    
        if (nodeSign(nNodesInput+1))
            if (outputsCommonKnown(i,1))
                fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', nNodesInput+1, iNode, penDescStrPosKnown{1});
            else
                fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', nNodesInput+1, iNode, penDescStrPos{1});
            end
        else
            if (outputsCommonKnown(i,1))
                fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', nNodesInput+1, iNode, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', nNodesInput+1, iNode, penDescStrNeg{1});
            end
        end
        if (nodeSign(nNodesInput+2))
            if (outputsCommonKnown(i,2))
                fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', nNodesInput+2, iNode, penDescStrPosKnown{1});
            else
                fprintf(fid, '\tnode%d:e -> node%d:nw %s;\n', nNodesInput+2, iNode, penDescStrPos{1});
            end
        else
            if (outputsCommonKnown(i,2))
                fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', nNodesInput+2, iNode, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:e -> node%d:sw %s;\n', nNodesInput+2, iNode, penDescStrNeg{1});
            end
        end
        iNode = iNode + 1;
        
    end
    
    for i=nType2OutputsUnique:-1:1
        
        if (nodeSign(nNodesInput+2))
            if (type2outputsUniqueKnown(i))
                fprintf(fid, '\tnode%d:se -> node%d:w %s;\n', nNodesInput+2, iNode, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:se -> node%d:w %s;\n', nNodesInput+2, iNode, penDescStrNeg{1});
            end
        else
            if (type2outputsUniqueKnown(i))
                fprintf(fid, '\tnode%d:se -> node%d:w %s;\n', nNodesInput+2, iNode, penDescStrNegKnown{1});
            else
                fprintf(fid, '\tnode%d:se -> node%d:w %s;\n', nNodesInput+2, iNode, penDescStrNeg{1});
            end
        end
        iNode = iNode + 1;
        
    end

    
    fprintf(fid, '\n}');
    
    fclose(fid);
    
    copyfile('inputs-outputs.gv','C:\Users\Diek\Dropbox\inputs-outputs.gv','f');
    
    
end
