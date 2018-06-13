function net = random_graph_WS(N, z, p, self_loops, multi_edges)
% def RandomGraph_WS(N, z, p, self_loops = False, multi_edges=False):
%     """Generates a random graph of the Watts-Strogtz type (non-directed).
%     1) Randomly selects a node = node1
%     2) Randomly deletes one of the edges of node1.
%     3) Randomly selects another vertex (node2) and makes a new edge
%     connection. node1 <--> node2
%     """
%     M = N*z     # Number of edges (connections)
%     E = M*p     # Number of rewired edges
%
% Written for Python by Gorka Zamora Lopez
%
% Adapted for Matlab by Diek W. Wheeler, Ph.D.
    
    % 1) INITIALIZE THE LATTICE:
    net = zeros(N,N);

    for i = 1:N
	
	for j = i-z:i+z+1
	
	    if (j ~= i)
		
		if (j < 0)
		
		    net(i,N+j) = 1;
		
		elseif (j >= N)
		    
		    net(i,j-N) = 1;
		
		else
		
		    net(i,j) = 1;
		
		end
	    
	    end % if (j ~= i)
	
	end % j loop
    
    end % i loop
    
    
    % INITIALIZE HELPERS
    
    outlist = [1:N];
    inlist = [1:N];
    counter = 1;

    
    % 2) RANDOMLY REWIRE M*p EDGES
    
    while (counter < E)
	
	% 2.1) REMOVE SOME EXISTING EDGE
        
	head = choice(outlist);      % Select randomly one node
	new_outlist = [];            % Find the list of its output
        
	for j = 1:N                  % neighbours.
        
	    if (net(head,j) ~= 0)
		new_outlist = [new_outlist j];
	    end
	    
	end % j loop
	 
	tail = choice(new_outlist); % Select randomly one of its neighbours ...
	net(head,tail) = 0;         % ... and remove the connection.
	net(tail,head) = 0;

	% 2.2) REWIRE 'HEAD' TO A NEW 'tail'
        
	new_tail = choice(inlist);  % Select a new tail for 'head'

	% Discard if head = tail
	if (head == new_tail & ~self_loops)
	    net(head,tail) = 1;     % Put again the unwired edge 
	    net(tail,head) = 1;     % For UNdirected graphs
	    ; % continue
	end

	% Put the new connection only if it does not exist yet
	
	if (net(head,new_tail) == 0 & ~multi_edges)
	    net(head,tail) = 1;
	    net(new_tail,head) = 1;    % For UNdirected graphs
	    counter = counter + 1;
	    % Discard if the new connection already existed
	else
	    net(head,tail) = 1;     % Put again the unwired edge
	    net(tail,head) = 1;     % For UNdirected graphs
	    ; % continue
	end
    
    end % while (counter < E)
    
    return	 

% end random_graph_WS()
