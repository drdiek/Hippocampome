function matrix = random_nets(N, M, self_loops, multi_edges)
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
            ; % continue             % if they happened to be equal
	end
	
        if ((matrix(head,tail) == 0) & ~multi_edges)
            matrix(head,tail) = 1;      % Put edges in BOTH directions
            matrix(tail,head) = 1;
            counter = counter + 1;
	end
    end
    
%    return;
    
% end random_nets()


% def RandomDigraph(N, M, self_loops=False, multi_edges=False):
    
%     # 1) SOME PROTECTIONS:    
%     if not self_loops:
%         assert M < N*(N-1), 'Sorry, no Self-Loops allowed. Maximum number \
% of edges is N*(N-1)'

%     if not multi_edges:
%         assert M < N**2, 'Sorry, no Multi-Edges allowed. Maximum number \
% of edges is N^2'

%     if M > 0.5*(N**2):
%         print 'WARNING! you are creating more than 50% of total possible connections.'
%         print 'For time savings, you should create a matrix out of ones and fill it with zeros'

%     # 2) DECLARE THE MATRIX AND HELPERS    
%     matrix = zeros((N,N), Int)
%     outlist = range(N)          # [0, 1, 2 ... N]
%     inlist = range(N)           # [0, 1, 2 ... N]
%     counter = 1

%     # 3) GENERATE THE MATRIX
%     while counter <= M:
%         head = choice(outlist)
%         tail = choice(inlist)

%         if head == tail and not self_loops:
%             continue

%         if matrix[head][tail] == 0 and not multi_edges:
%             matrix[head][tail] = 1
%             counter += 1
%         else: continue

%     return matrix


% def RandomGraph_WS(N, z, p, self_loops = False, multi_edges=False):
%     """Generates a random graph of the Watts-Strogtz type (non-directed).
%     1) Randomly selects a node = node1
%     2) Randomly deletes one of the edges of node1.
%     3) Randomly selects another vertex (node2) and makes a new edge
%     connection. node1 <--> node2
%     """
%     M = N*z     # Number of edges (connections)
%     E = M*p     # Number of rewired edges

%     # 1) INITIALIZE THE LATTICE
%     NET = zeros((N,N), Int)
%     for i in range(N):
%         for j in range(i-z, i+z+1):
%             if j != i:
%                 if j < 0:
%                     NET[i][N+j] = 1
%                 elif j >= N:
%                     NET[i][j-N] = 1
%                 else:
%                     NET[i][j] = 1

%     # INITIALIZE HELPERS
%     outlist = arange(N)         # [0, 1, 2 ... N]
%     inlist = arange(N)          # [0, 1, 2 ... N]
%     counter = 1

%     # 2) RANDOMLY REWIRE M*p EDGES
%     while counter < E:
%         # 2.1) REMOVE SOME EXISTING EDGES
%         head = choice(outlist)      # Select randomly one node.
%         new_outlist = []            # Find the list of its output
%         for j in range(N):          # neighbours.
%             if NET[head][j] != 0:
%                 new_outlist.append(j)

%         tail = choice(new_outlist)  # Select randomly one of its neighbours ...
%         NET[head][tail] = 0         # ... and remove the connection.
%         NET[tail][head] = 0


%         # 2.2) REWIRE 'HEAD' TO A NEW 'tail'
%         new_tail = choice(inlist)   # Select a new tail for 'head'

%         # Discard if head = tail
%         if head == new_tail and not self_loops:
%             NET[head][tail] = 1     # Put again the unwired edge 
%             NET[tail][head] = 1     # For UNdirected graphs
%             continue

%         # Put the new connection only if it does not exist yet
%         if NET[head][new_tail] == 0 and not multi_edges:
%             NET[head][new_tail] = 1
%             NET[new_tail][head] = 1     # For UNdirected graphs
%             counter +=1

%         # Discard if the new connection already existed
%         else:
%             NET[head][tail] = 1     # Put again the unwired edge
%             NET[tail][head] = 1     # For UNdirected graphs
%             continue

%     return NET


% def RandomDigraph_WS(N, z, p, self_loops = False, multi_edges=False): #Matrix version
%     """Generates a random digraph of the Watts-Strogtz type. It rewires only
%     one of the directions in a connection.
%     1) Randomly selects a node = node1
%     2) Randomly deletes one of it arcs (but keep the reciprocal untouch)
%     3) Randomly selects another vertex (node2) and makes a single directed
%     connection node1 --> node2
%     """
%     M = 2*N*z       # Number of arcs (connections)
%     E = M*p         # Number of rewired edges
%     # 1) INITIALIZE THE LATTICE
%     NET = zeros((N,N), Int)
%     for i in range(N):
%         for j in range(i-z, i+z+1):
%             if j != i:
%                 if j < 0:
%                     NET[i][N+j] = 1
%                 elif j >= N:
%                     NET[i][j-N] = 1
%                 else:
%                     NET[i][j] = 1

%     # INITIALIZE HELPERS
%     outlist = arange(N)
%     inlist = arange(N)
%     counter = 1

%     # 2) RANDOMLY REWIRE M*p EDGES
%     while counter < E:
%         # 2.1) REMOVE SOME EXISTING EDGE
%         head = choice(outlist)      # Select randomly one node
%         new_outlist = []            # Find the list of its output
%         for j in range(N):          # neighbours.
%             if NET[head][j] != 0:
%                 new_outlist.append(j)

%         tail = choice(new_outlist)  # Select one of its neighbours...
%         NET[head][tail] = 0         # ... and remove arc.

%         # 2.2) REWIRE 'HEAD' TO A NEW tail
%         new_tail = choice(inlist)   # Select a new tail for 'head'

%         # Discard if head = tail
%         if head == new_tail and not self_loops:
%             NET[head][tail] = 1     # Put again the unwired edge 
%             continue

%         # Put the new connection only if it does not exist yet            
%         if NET[head][new_tail] == 0 and not multi_edges:
%             NET[head][new_tail] = 1
%             counter +=1

%         # Discard if the new connection already existed
%         else:
%             NET[head][tail] = 1     # Put again the unwired edge
%             continue

%     return NET
