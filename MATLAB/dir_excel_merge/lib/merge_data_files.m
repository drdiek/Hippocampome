function [dataMerged, highlightHCID1, highlightHCID2, highlightHCIDBoth, ...
          highlightExclusion1, highlightExclusion2, highlightExclusionBoth, ...
          highlightSTID1, highlightSTID2, highlightSTIDBoth] = merge_data_files(data1, data2)

    N = size(data1,1);
    dataMerged = data1;
    
    highlightSTID1 = [];
    highlightSTID2 = [];
    highlightSTIDBoth = [];
    
    highlightHCID1 = [];
    highlightHCID2 = [];
    highlightHCIDBoth = [];
    
    highlightExclusion1 = [];
    highlightExclusion2 = [];
    highlightExclusionBoth = [];
    
    for i = 1:N
        % compare and combine data from Hippocampome_ID column
        if (ischar(data1{i,1}) && ~ischar(data2{i,1}))
            if isnan(data2{i,1})
                dataMerged(i,1) = data1(i,1);
                strng = sprintf('Data from file #1 was added to the output file: line %d NMO ID %d HC ID %s', i, data1{i,4}, data1{i,1});
                disp(strng);
                highlightHCID1 = [highlightHCID1 i];
            else % data2{i,1} is finite
                strng = sprintf('At line #%d NMO ID %d,', i, dataMerged{i,4});
                strng = sprintf('%s the Hippocampome ID for dataFile#1 is %s and the Hippocampome ID for dataFile#2 is %d.', strng, data1{i,1}, data2{i,1});
                disp(strng);
                dataMerged{i,1} = sprintf('%s; %d', data1{i,1}, data2{i,1});
                highlightHCIDBoth = [highlightHCIDBoth i];
            end
        elseif (~ischar(data1{i,1}) && ischar(data2{i,1}))
            if isnan(data1{i,1})
                dataMerged(i,1) = data2(i,1);
                strng = sprintf('Data from file #2 was added to the output file: line %d NMO ID %d HC ID %s', i, data2{i,4}, data2{i,1});
                disp(strng);
                highlightHCID2 = [highlightHCID2 i];
            else % data1{i,1} is finite
                strng = sprintf('At line #%d NMO ID %d,', i, dataMerged{i,4});
                strng = sprintf('%s the Hippocampome ID for dataFile#1 is %d and the Hippocampome ID for dataFile#2 is %s.', strng, data1{i,1}, data2{i,1});
                disp(strng);
                dataMerged{i,1} = sprintf('%d; %s', data1{i,1}, data2{i,1});
                highlightHCIDBoth = [highlightHCIDBoth i];
            end
        elseif (ischar(data1{i,1}) && ischar(data2{i,1}))
            if (data1{i,1} ~= data2{i,1})
                strng = sprintf('At line #%d NMO ID %d,', i, dataMerged{i,4});
                strng = sprintf('%s the Hippocampome ID for dataFile#1 is %s and the Hippocampome ID for dataFile#2 is %s.', strng, data1{i,1}, data2{i,1});
                disp(strng);
                dataMerged{i,1} = sprintf('%s; %s', data1{i,1}, data2{i,1});
                highlightHCIDBoth = [highlightHCIDBoth i];
            end
        else % both data1{i,1} and data2{i,1} are numbers not character strings
            if (data1{i,1} ~= data2{i,1})
                if (isfinite(data1{i,1}) && isnan(data2{i,1}))
                    dataMerged(i,1) = data1(i,1);
                    strng = sprintf('Data from file #1 was added to the output file: line %d NMO ID %d HC ID %d', i, data1{i,4}, data1{i,1});
                    disp(strng);
                    highlightHCID1 = [highlightHCID1 i];
                elseif (isnan(data1{i,1}) && isfinite(data2{i,1}))
                    dataMerged(i,1) = data2(i,1);
                    strng = sprintf('Data from file #2 was added to the output file: line %d NMO ID %d HC ID %d', i, data2{i,4}, data2{i,1});
                    disp(strng);
                    highlightHCID2 = [highlightHCID2 i];
                elseif (isfinite(data1{i,1}) && isfinite(data2{i,1}))
                    strng = sprintf('At line #%d NMO ID %d,', i, dataMerged{i,4});
                    strng = sprintf('%s the Hippocampome ID for dataFile#1 is %d and the Hippocampome ID for dataFile#2 is %d.', strng, data1{i,1}, data2{i,1});
                    disp(strng);
                    dataMerged{i,1} = sprintf('%d; %d', data1{i,1}, data2{i,1});
                    highlightHCIDBoth = [highlightHCIDBoth i];
                end
            end % if (data1{i,1} ~= data2{i,1})
        end

        % compare and combine data from reason_for_exclusion column
        if ~strcmp(data1{i,2}, data2{i,2})
            if (sum(isfinite(data1{i,2})) && sum(isnan(data2{i,2})))
                dataMerged(i,2) = data1(i,2);
                strng = sprintf('Data from file #1 was added to the output file: line %d NMO ID %d exclusion %s', i, data1{i,4}, data1{i,2});
                disp(strng);
                highlightExclusion1 = [highlightExclusion1 i];
            elseif (sum(isnan(data1{i,2})) && sum(isfinite(data2{i,2})))
                dataMerged(i,2) = data2(i,2);
                strng = sprintf('Data from file #2 was added to the output file: line %d NMO ID %d exclusion %s', i, data2{i,4}, data2{i,2});
                disp(strng);
                highlightExclusion2 = [highlightExclusion2 i];
            elseif (~isempty(data1{i,2}) && ~isempty(data2{i,2}) && sum(isfinite(data1{i,2})) && sum(isfinite(data2{i,2})))
                strng = sprintf('At line #%d NMO ID %d,', i, dataMerged{i,4});
                strng = sprintf('%s the exclusion reason for dataFile#1 is %s and the exclusion reason for dataFile#2 is %s.', strng, data1{i,2}, data2{i,2});
                disp(strng);
                dataMerged{i,2} = sprintf('%s; %s', data1{i,2}, data2{i,2});
                highlightExclusionBoth = [highlightExclusionBoth i];
            end
        end % if ~= {i,2}

        % compare and combine data from Supertype_ID column
        if ~strcmp(data1{i,3}, data2{i,3})
            if (sum(isfinite(data1{i,3})) && sum(isnan(data2{i,3})))
                dataMerged(i,3) = data1(i,3);
                strng = sprintf('Data from file #1 was added to the output file: line %d NMO ID %d Supertype ID %s', i, data1{i,4}, data1{i,3});
                disp(strng);
                highlightSTID1 = [highlightSTID1 i];
            elseif (sum(isnan(data1{i,3})) && sum(isfinite(data2{i,3})))
                dataMerged(i,3) = data2(i,3);
                strng = sprintf('Data from file #2 was added to the output file: line %d NMO ID %d exclusion %s', i, data2{i,4}, data2{i,3});
                disp(strng);
                highlightSTID2 = [highlightSTID2 i];
            elseif (~isempty(data1{i,3}) && ~isempty(data2{i,3}) && sum(isfinite(data1{i,3})) && sum(isfinite(data2{i,3})))
                strng = sprintf('At line #%d NMO ID %d,', i, dataMerged{i,4});
                strng = sprintf('%s the Supertype ID for dataFile#1 is %s and the Supertype ID for dataFile#2 is %s.', strng, data1{i,3}, data2{i,3});
                disp(strng);
                dataMerged{i,3} = sprintf('%s; %s', data1{i,3}, data2{i,3});
                highlightSTIDBoth = [highlightSTIDBoth i];
            end
        end % if ~= {i,3}
    end % i
end % merge_data_files()