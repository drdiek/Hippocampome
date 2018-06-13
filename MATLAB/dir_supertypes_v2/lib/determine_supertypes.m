function determine_supertypes(rawData,numData)
    
    load('./lib/constants.mat');
    
    nSkipRows = 23;
    
    supertypeIds = rawData(:,SUPERTYPE_ID_COL);
    nSupertypeIds = size(supertypeIds,1);

    neuronalTypes = rawData(:,NEURONAL_TYPE_COL);
    
    % find entries in the Supertype_ID column that are not character strings
    for i = 1:nSupertypeIds
        if ~ischar(supertypeIds{i})
            nSupertypeIdStrings = i-1;
            break;
        end % if
    end % i

    supertypeDescriptors = rawData(:,SUPERTYPE_DESCRIPTOR_COL);
    
    supertypePatterns = numData(:,S_DG_COL:SOMPOS_COL);
    nSupertypePatterns = size(supertypePatterns,1);

    nDigits = size(supertypePatterns,2);

    if (nSupertypePatterns > nSupertypeIdStrings)
        for i = nSupertypeIdStrings+1:nSupertypePatterns
            [isMatch, idx] = ismember(supertypePatterns(i,:),supertypePatterns(1:nSupertypeIdStrings,:),'rows');
            if isMatch
                strng = sprintf('\nThe pattern in row %d matches the supertype %s: %s.', i+nSkipRows, supertypeIds{idx}, supertypeDescriptors{idx});
                disp(strng);
            else
                strng = sprintf('\nThere is no matching supertype for the pattern in row %d.', i+nSkipRows);
                disp(strng);
                nMax = 0;
                for j = 1:nSupertypeIdStrings
                    % calculate the Hamming distance between the new pattern and the old jth pattern
                    n(j) = 0;
                    for k = 1:nDigits
                        if (supertypePatterns(i,k) == supertypePatterns(j,k))
                            n(j) = n(j) + 1;
                        end
                    end % k
                    
                    % check if the jth pattern has the smallest Hamming distance to the new pattern
                    if (n(j) > nMax)
                        nMax = n(j);
                    end
                end % j
                
                % find all old patterns with the same smallest Hamming distance to the new pattern
                idx = find(n == nMax);
                
                for j = 1:length(idx)
                    strng = sprintf('The closest match to the pattern in row %d is the type %s: the supertype %s: %s.', ...
                        i+nSkipRows, neuronalTypes{idx(j)}, supertypeIds{idx(j)}, supertypeDescriptors{idx(j)});
                    disp(strng);
                end % j
            end
        end % i
    end
    
    reply = input('\nHit <ENTER> to continue: ');
    
end % determine_supertypes()