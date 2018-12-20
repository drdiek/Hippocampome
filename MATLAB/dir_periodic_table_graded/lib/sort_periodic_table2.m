function [tags, isExcit, AandDs] = sort_periodic_table2(label, isExcitatory, neurites)

    nNeurons = size(neurites,1);
    
    nParcels = size(neurites,2);
    
    AandDs = neurites;
    
    target = 3*ones(1,nParcels);
    
    idx = 1:nNeurons;
    
    numNeurons = nNeurons;
    
    for jNeuron = 1:nNeurons
        
        for iNeuron = jNeuron:nNeurons
            
            distance(iNeuron) = 0;

            for iParcel = 1:nParcels
                
                delta = (target(iParcel)-neurites(iNeuron,iParcel))^2;
                
                if (delta == 4) % purple <-> red or blue <-> white
                    
                    delta = 1;
                    
                end
                
                if (target(iParcel)*neurites(iNeuron,iParcel) == 2) % blue <-> red
                    
                    delta = 4;
                    
                end
                
                if ((target(iParcel)*neurites(iNeuron,iParcel) == 0) && delta == 9) % purple <-> white

                    delta = 4;
                    
                end
                    
                distance(iNeuron) = distance(iNeuron) + delta;
                
            end
            
            distance(iNeuron) = sqrt(distance(iNeuron));
                    
        end
    
        [sorted,idx] = sort(distance)
        
        if (jNeuron == 1)
        
            index(jNeuron) = idx(1)

        else
            
            i = 1;
        
            while (find(index==idx(i)))
                
                i = i + 1;
                
            end
            
            index(jNeuron) = idx(i)
        
        end
        
        target = neurites(index(jNeuron),:);
        
        AandDs(jNeuron,:) = target;
        
%         clear temp;
%         
%         for iNeuron = 1:jNeuron-1
%             
%             temp(iNeuron,:) = neurites(iNeuron,:);
%             
%         end
%         
%         for iNeuron = 1:numNeurons
%             
%             temp(nNeurons-numNeurons+iNeuron,:) = neurites(idx(iNeuron),:);
%             
%         end
%         
%         clear neurites
%         
%         neurites = temp;
        
        numNeurons = numNeurons - 1;
        
%         pause
        
    end % for jNeuron
    
    for iNeuron = 1:nNeurons
        
        tags{iNeuron} = label{index(iNeuron)};
        
        isExcit(iNeuron) = isExcitatory(index(iNeuron));
        
        AandDs(iNeuron,:) = neurites(index(iNeuron),:);
        
    end
    
end