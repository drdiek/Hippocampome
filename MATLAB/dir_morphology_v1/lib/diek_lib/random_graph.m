function matrix = random_graph(N, M, self_loops, multi_edges)
% def RandomGraph(N, M, self_loops = False, multi_edges = False):
%     This function generates a completely random network
%     with N nodes and M edges.
%     PARAMETERS:
%         - N: number of nodes.
%         - M: number of connections
%         - self_loops: 'True' or 'False' if self connections
%                         are allowed or not. (Diagonal elements
%                         of the matrix)
%         - multi_edges: 'True' or 'False' if more than one
%                         connections are allowed between two
%                         nodes.      
%     ALGORITHM:
%         1) Initiate the matrix with zeros.
%             (I create the list of nodes (outlist = range(N) ) to later
%              randomly choose one node, but this depends on your
%              way of finding the random number. This is just the way in Python)
%         2) while number of connections < M:
%             2.1) randomly choose two vertices
%             2.2) connect them (mat[i][j] = 1 AND mat[j][i] = 1)
%                 if the conditions are satisfied.
% Written for Python by Gorka Zamora Lopez
%
% Adapted for Matlab by Diek W. Wheeler, Ph.D.
    
%   # 1) SOME PROTECTIONS:    
    if (random_graph_param_check(N, M, self_loops, multi_edges))
	matrix = [NaN];
	return;
    end

%   # 2) DECLARE THE MATRIX AND HELPERS
    matrix = zeros(N,N);
    outlist = [1:N];
    inlist = [1:N];
    counter = 1;
    
%   # 3) GENERATE THE MATRIX
    while (counter <= M)
	head = choice(outlist);
	tail = choice(inlist);
	
        if ((head == tail) & ~self_loops) % Choose new head and tail
            ; % continue                  % if they happened to be equal
	end
	
        if ((matrix(head,tail) == 0) & ~multi_edges)
            matrix(head,tail) = 1;      % Put edges in BOTH directions
            matrix(tail,head) = 1;
            counter = counter + 1;
	end
    end
    
%    return;
    
% end random_graph()
