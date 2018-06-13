function isQuit = random_graph_param_check(N, M, self_loops, multi_edges)

    isQuit = 0;
    
    if (~self_loops)
	if (M > 0.5*N*(N-1))
	    disp(['Sorry, no Self-Loops allowed. Maximum number of ' ...
		  'edges is (1/2)*N*(N-1) = ' num2str(0.5*N*(N-1))]);
	    disp(' ');
	    isQuit = 1;
	end
    end
    
    if (~multi_edges)
	if (M > N^2)
	    disp(['Sorry, no Multi-Edges allowed. Maximum number ' ...
		  'of edges is N^2 = ' num2str(N^2)]);
	    disp(' ');
	    isQuit = 1;
	end
    end
    
    if (M > 0.5*(N^2))
	disp(['WARNING! you are creating more than 50% of total ' ...
	      'possible connections.']);
	disp(['For time savings, you should create a matrix out of ' ...
	      'ones and fill it with zeros']);
	disp(' ');
	isQuit = 1;
    end
    
