function [count]=motif3struct_wei(W)
%[I Q F]=motif3struct_wei(W); weighted structural motif metrics.
%
%Input: weighted graph W (all weights [0,1]).
%Output by node: total intensity I, total coherence Q, motif count F.
%Average intensity and coherence may be obtained as I./F and Q./F.
%
%Reference: Onnela et al. 2005, Phys Rev E 71:065103;
%
%Mika Rubinov, UNSW, 2007 (last modified July 2008)
%Christopher Rees, GMU, 2010


load newMotifLib Mot3 ID3
count=zeros(628,1);

n=length(W);                                %number of vertices in W
rowSumsSigns=sign(sum(W,2));

A=abs(W~=0);                                %adjacency matrix
As=A|A.';                                   %symmetrized adjacency

for u=1:n-2                               	%loop u 1:n-2
    %u
    V1=[false(1,u) As(u,u+1:n)];         	%v1: neibs of u (>u)

    for v1=find(V1)
        %v1
        V2=[false(1,u) As(v1,u+1:n)];       %v2: all neibs of v1 (>u)
        V2(V1)=0;                           %not already in V1        
        V2=([false(1,v1) As(u,v1+1:n)])|V2; %and all neibs of u (>v1)
        
        for v2=find(V2)          
            selfu = W(u,u);
            selfv1 = W(v1,v1);
            selfv2 = W(v2,v2);
            
            EorIu = rowSumsSigns(u);
            EorIv1 = rowSumsSigns(v1);
            EorIv2 = rowSumsSigns(v2);

                    % for testing only
                    if (EorIu == 0)
                        EorIu = 1;
                    end
                    if (EorIv1 == 0)
                        EorIv1 = 1;
                    end
                    if (EorIv2 == 0)
                        EorIv2 = 1;
                    end
            
            %u
            %v1
            %v2
            conn = [ EorIu EorIv1 EorIv2 selfu W(v1,u) W(v2,u) W(u,v1) selfv1 W(v2,v1) W(u,v2) W(v1,v2) selfv2; ];
            
            i = all(repmat(conn,size(Mot3,1),1)==Mot3,2);
            id = ID3(i);
 
            count(id,1)=count(id,1)+1;
        end
    end
end