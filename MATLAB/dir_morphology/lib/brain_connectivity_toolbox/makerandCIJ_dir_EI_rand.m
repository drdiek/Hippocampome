function [CIJ] = makerandCIJ_dir_EI_rand(allM, allD)

% inputs:
%           allM - list & counts of 4 types of monomers
%           allD - list & counts of 26 types of monomers
% output:
%           CIJ = directed random connection matrix
%
% Generates a random directed binary connection matrix, with the correct
% numbers of monomers and dimers randomly placed
%
% Olaf Sporns, Indiana University, 2007/2008
% Christopher Rees, George Mason University, 2010

NeNO = length(allM{1});
NiNO = length(allM{2});
NeYES = length(allM{3});
NiYES = length(allM{4});
N = NeNO + NiNO + NeYES + NiYES;

CIJ = zeros(N,N);

for a=1:NeYES
    CIJ(allM{3}(a),allM{3}(a)) = 1;
end
for b=1:NiYES
    CIJ(allM{4}(b),allM{4}(b)) = -1;
end


for k=1:26
    switch(k)
        case 1
            for z = 1:size(allD{k},2)
                randIndices1 = randperm(length(allM{1}));
                node1 = allM{1}(randIndices1(1));
                node2 = allM{1}(randIndices1(2));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices1 = randperm(length(allM{1}));
                    node1 = allM{1}(randIndices1(1));
                    node2 = allM{1}(randIndices1(2));
                end
                
                CIJ(node1,node2) = 1;
            end
        case 2
            for z = 1:size(allD{k},2)
                randIndices1 = randperm(length(allM{1}));
                randIndices2 = randperm(length(allM{2}));
                node1 = allM{1}(randIndices1(1));
                node2 = allM{2}(randIndices2(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices1 = randperm(length(allM{1}));
                    randIndices2 = randperm(length(allM{2}));
                    node1 = allM{1}(randIndices1(1));
                    node2 = allM{2}(randIndices2(1));
                end
                
                CIJ(node1,node2) = 1;
            end

        case 3
            for z = 1:size(allD{k},2)
                randIndices1 = randperm(length(allM{1}));
                randIndices3 = randperm(length(allM{3}));
                node1 = allM{1}(randIndices1(1));
                node2 = allM{3}(randIndices3(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices1 = randperm(length(allM{1}));
                    randIndices3 = randperm(length(allM{3}));
                    node1 = allM{1}(randIndices1(1));
                    node2 = allM{3}(randIndices3(1));
                end
                
                CIJ(node1,node2) = 1;
            end
        case 4
            for z = 1:size(allD{k},2)
                randIndices1 = randperm(length(allM{1}));
                randIndices4 = randperm(length(allM{4}));
                node1 = allM{1}(randIndices1(1));
                node2 = allM{4}(randIndices4(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices1 = randperm(length(allM{1}));
                    randIndices4 = randperm(length(allM{4}));
                    node1 = allM{1}(randIndices1(1));
                    node2 = allM{4}(randIndices4(1));
                end
                
                CIJ(node1,node2) = 1;
            end
            
        case 5
            for z = 1:size(allD{k},2)
                randIndices2 = randperm(length(allM{2}));
                randIndices1 = randperm(length(allM{1}));
                node1 = allM{2}(randIndices2(1));
                node2 = allM{1}(randIndices1(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices2 = randperm(length(allM{2}));
                    randIndices1 = randperm(length(allM{1}));
                    node1 = allM{2}(randIndices2(1));
                    node2 = allM{1}(randIndices1(1));
                end
                
                CIJ(node1,node2) = -1;
            end            
        case 6
            for z = 1:size(allD{k},2)
                randIndices2 = randperm(length(allM{2}));
                node1 = allM{2}(randIndices2(1));
                node2 = allM{2}(randIndices2(2));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices2 = randperm(length(allM{2}));
                    node1 = allM{2}(randIndices2(1));
                    node2 = allM{2}(randIndices2(2));
                end
                
                CIJ(node1,node2) = -1;
            end 
        case 7
            for z = 1:size(allD{k},2)
                randIndices2 = randperm(length(allM{2}));
                randIndices3 = randperm(length(allM{3}));
                node1 = allM{2}(randIndices2(1));
                node2 = allM{3}(randIndices3(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices2 = randperm(length(allM{2}));
                    randIndices3 = randperm(length(allM{3}));
                    node1 = allM{2}(randIndices2(1));
                    node2 = allM{3}(randIndices3(1));
                end
                
                CIJ(node1,node2) = -1;
            end
        case 8
            for z = 1:size(allD{k},2)
                randIndices2 = randperm(length(allM{2}));
                randIndices4 = randperm(length(allM{4}));
                node1 = allM{2}(randIndices2(1));
                node2 = allM{4}(randIndices4(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices2 = randperm(length(allM{2}));
                    randIndices4 = randperm(length(allM{4}));
                    node1 = allM{2}(randIndices2(1));
                    node2 = allM{4}(randIndices4(1));
                end
                
                CIJ(node1,node2) = -1;
            end            
            
        case 9
            for z = 1:size(allD{k},2)
                randIndices3 = randperm(length(allM{3}));
                randIndices1 = randperm(length(allM{1}));
                node1 = allM{3}(randIndices3(1));
                node2 = allM{1}(randIndices1(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices3 = randperm(length(allM{3}));
                    randIndices1 = randperm(length(allM{1}));
                    node1 = allM{3}(randIndices3(1));
                    node2 = allM{1}(randIndices1(1));
                end
                
                CIJ(node1,node2) = 1;
            end    
        case 10
            for z = 1:size(allD{k},2)
                randIndices3 = randperm(length(allM{3}));
                randIndices2 = randperm(length(allM{2}));
                node1 = allM{3}(randIndices3(1));
                node2 = allM{2}(randIndices2(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices3 = randperm(length(allM{3}));
                    randIndices2 = randperm(length(allM{2}));
                    node1 = allM{3}(randIndices3(1));
                    node2 = allM{2}(randIndices2(1));
                end
                
                CIJ(node1,node2) = 1;
            end
        case 11
            for z = 1:size(allD{k},2)
                randIndices3 = randperm(length(allM{3}));
                node1 = allM{3}(randIndices3(1));
                node2 = allM{3}(randIndices3(2));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices3 = randperm(length(allM{3}));
                    node1 = allM{3}(randIndices3(1));
                    node2 = allM{3}(randIndices3(2));
                end
                
                CIJ(node1,node2) = 1;
            end
        case 12
            for z = 1:size(allD{k},2)
                randIndices3 = randperm(length(allM{3}));
                randIndices4 = randperm(length(allM{4}));
                node1 = allM{3}(randIndices3(1));
                node2 = allM{4}(randIndices4(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices3 = randperm(length(allM{3}));
                    randIndices4 = randperm(length(allM{4}));
                    node1 = allM{3}(randIndices3(1));
                    node2 = allM{4}(randIndices4(1));
                end
                
                CIJ(node1,node2) = 1;
            end           
            
        case 13
            for z = 1:size(allD{k},2)
                randIndices4 = randperm(length(allM{4}));
                randIndices1 = randperm(length(allM{1}));
                node1 = allM{4}(randIndices4(1));
                node2 = allM{1}(randIndices1(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices4 = randperm(length(allM{4}));
                    randIndices1 = randperm(length(allM{1}));
                    node1 = allM{4}(randIndices4(1));
                    node2 = allM{1}(randIndices1(1));
                end
                
                CIJ(node1,node2) = -1;
            end    
        case 14
            for z = 1:size(allD{k},2)
                randIndices4 = randperm(length(allM{4}));
                randIndices2 = randperm(length(allM{2}));
                node1 = allM{4}(randIndices4(1));
                node2 = allM{2}(randIndices2(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices4 = randperm(length(allM{4}));
                    randIndices2 = randperm(length(allM{2}));   
                    node1 = allM{4}(randIndices4(1));
                    node2 = allM{2}(randIndices2(1));
                end
                    CIJ(node1,node2) = -1;
            end    
        case 15
            for z = 1:size(allD{k},2)
                randIndices4 = randperm(length(allM{4}));
                randIndices3 = randperm(length(allM{3}));
                node1 = allM{4}(randIndices4(1));
                node2 = allM{3}(randIndices3(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices4 = randperm(length(allM{4}));
                    randIndices3 = randperm(length(allM{3}));
                    node1 = allM{4}(randIndices4(1));
                    node2 = allM{3}(randIndices3(1));
                end
                
                CIJ(node1,node2) = -1;
            end    
        case 16
            for z = 1:size(allD{k},2)
                randIndices4 = randperm(length(allM{4}));
                node1 = allM{4}(randIndices4(1));
                node2 = allM{4}(randIndices4(2));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices4 = randperm(length(allM{4}));
                    node1 = allM{4}(randIndices4(1));
                    node2 = allM{4}(randIndices4(2));
                end
                
                CIJ(node1,node2) = -1;
            end                
            
        case 17
            for z = 1:size(allD{k},2)
                randIndices1 = randperm(length(allM{1}));
                node1 = allM{1}(randIndices1(1));
                node2 = allM{1}(randIndices1(2));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices1 = randperm(length(allM{1}));
                    node1 = allM{1}(randIndices1(1));
                    node2 = allM{1}(randIndices1(2));
                end
                
                CIJ(node1,node2) = 1;
                CIJ(node2,node1) = 1;
            end    
        case 18
            for z = 1:size(allD{k},2)
                randIndices2 = randperm(length(allM{2}));
                node1 = allM{2}(randIndices2(1));
                node2 = allM{2}(randIndices2(2));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices2 = randperm(length(allM{2}));
                    node1 = allM{2}(randIndices2(1));
                    node2 = allM{2}(randIndices2(2));
                end
                
                CIJ(node1,node2) = -1;
                CIJ(node2,node1) = -1;
            end  
        case 19
            for z = 1:size(allD{k},2)
                randIndices3 = randperm(length(allM{3}));
                node1 = allM{3}(randIndices3(1));
                node2 = allM{3}(randIndices3(2));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices3 = randperm(length(allM{3}));
                    node1 = allM{3}(randIndices3(1));
                    node2 = allM{3}(randIndices3(2));
                end
                
                CIJ(node1,node2) = 1;
                CIJ(node2,node1) = 1;
            end
        case 20
            for z = 1:size(allD{k},2)
                randIndices4 = randperm(length(allM{4}));
                node1 = allM{4}(randIndices4(1));
                node2 = allM{4}(randIndices4(2));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices4 = randperm(length(allM{4}));
                    node1 = allM{4}(randIndices4(1));
                    node2 = allM{4}(randIndices4(2));
                end
                
                CIJ(node1,node2) = -1;
                CIJ(node2,node1) = -1;
            end                 

        case 21
            for z = 1:size(allD{k},2)
                randIndices1 = randperm(length(allM{1}));
                randIndices2 = randperm(length(allM{2}));
                node1 = allM{1}(randIndices1(1));
                node2 = allM{2}(randIndices2(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices1 = randperm(length(allM{1}));
                    randIndices2 = randperm(length(allM{2}));
                    node1 = allM{1}(randIndices1(1));
                    node2 = allM{2}(randIndices2(1));
                end
                
                CIJ(node1,node2) = 1;
                CIJ(node2,node1) = -1;
            end  
        case 22
            for z = 1:size(allD{k},2)
                randIndices1 = randperm(length(allM{1}));
                randIndices3 = randperm(length(allM{3}));
                node1 = allM{1}(randIndices1(1));
                node2 = allM{3}(randIndices3(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices1 = randperm(length(allM{1}));
                    randIndices3 = randperm(length(allM{3}));
                    node1 = allM{1}(randIndices1(1));
                    node2 = allM{3}(randIndices3(1));
                end

                CIJ(node1,node2) = 1;
                CIJ(node2,node1) = 1;                
            end             
        case 23
            for z = 1:size(allD{k},2)
                randIndices1 = randperm(length(allM{1}));
                randIndices4 = randperm(length(allM{4}));
                node1 = allM{1}(randIndices1(1));
                node2 = allM{4}(randIndices4(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices1 = randperm(length(allM{1}));
                    randIndices4 = randperm(length(allM{4}));
                    node1 = allM{1}(randIndices1(1));
                    node2 = allM{4}(randIndices4(1));
                end
                
                CIJ(node1,node2) = 1;
                CIJ(node2,node1) = -1;
            end
            
        case 24
            for z = 1:size(allD{k},2)
                randIndices2 = randperm(length(allM{2}));
                randIndices3 = randperm(length(allM{3}));
                node1 = allM{2}(randIndices2(1));
                node2 = allM{3}(randIndices3(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices2 = randperm(length(allM{2}));
                    randIndices3 = randperm(length(allM{3}));
                    node1 = allM{2}(randIndices2(1));
                    node2 = allM{3}(randIndices3(1));
                end
                
                CIJ(node1,node2) = -1;
                CIJ(node2,node1) = 1;
            end             
        case 25
            for z = 1:size(allD{k},2)
                randIndices2 = randperm(length(allM{2}));
                randIndices4 = randperm(length(allM{4}));
                node1 = allM{2}(randIndices2(1));
                node2 = allM{4}(randIndices4(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices2 = randperm(length(allM{2}));
                    randIndices4 = randperm(length(allM{4}));
                    node1 = allM{2}(randIndices2(1));
                    node2 = allM{4}(randIndices4(1));
                end
                
                CIJ(node1,node2) = -1;
                CIJ(node2,node1) = -1;
            end 
        case 26
            for z = 1:size(allD{k},2)
                randIndices3 = randperm(length(allM{3}));
                randIndices4 = randperm(length(allM{4}));
                node1 = allM{3}(randIndices3(1));
                node2 = allM{4}(randIndices4(1));
                while (CIJ(node1,node2) ~= 0 || CIJ(node2,node1) ~= 0)
                    randIndices3 = randperm(length(allM{3}));
                    randIndices4 = randperm(length(allM{4}));
                    node1 = allM{3}(randIndices3(1));
                    node2 = allM{4}(randIndices4(1));
                end
                
                CIJ(node1,node2) = 1;
                CIJ(node2,node1) = -1;
            end             
    end
end

end



