function [probAorB, probAorNotB, probNotAorB, probNotAorNotB] = prob_A_or_B(a, b, c, d)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2 x 2 Contingency Table
    % -----------------------------------------------
    % | Observed counts |      B      |    not B    |
    % --------------------------------------------------------------
    % |       A         |      a      |      b      |      a+b
    % --------------------------------------------------------------
    % |    not A        |      c      |      d      |      c+d
    % --------------------------------------------------------------
    %                   |     a+c     |     b+d     |   n=a+b+c+d
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % P(A OR B) = P(A) + P(B) - P(A AND B)
    %

    n = a + b + c + d;  

    probAorB = (a + b + c) / n;
    
    probAorNotB = (a + b + d) / n;
    
    probNotAorB = (a + c + d) / n;
    
    probNotAorNotB = (b + c + d) / n;
        
end