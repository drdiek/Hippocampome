function createValidSwapClassList()
    swapClasses = {...
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [1 2 3 4 9 10 11 12]...
        [1 2 3 4 9 11]...
        [1 2 3 4 9]...
        1;...

        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [1 2 3 4 9 10 11 12]...
        [1 2 3 4 10 12]...
        [1 2 3 4 10]...
        2;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [1 2 3 4 9 10 11 12]...
        [1 2 3 4 9 11]...
        [1 2 3 4 11]...
        3;...
             
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [1 2 3 4 9 10 11 12]...
        [1 2 3 4 10 12]...
        [1 2 3 4 12]...
        4;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [5 6 7 8 13 14 15 16]...
        [5 6 7 8 13 15]...
        [5 6 7 8 13]...
        5;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [5 6 7 8 13 14 15 16]...
        [5 6 7 8 14 16]...
        [5 6 7 8 14]...
        6;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [5 6 7 8 13 14 15 16]...
        [5 6 7 8 13 15]...
        [5 6 7 8 15]...
        7;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [5 6 7 8 13 14 15 16]...
        [5 6 7 8 14 16]...
        [5 6 7 8 16]...
        8;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [1 2 3 4 9 10 11 12]...
        [1 3 9 10 11 12]...
        [1 9 10 11 12]...
        9;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [1 2 3 4 9 10 11 12]...
        [2 4 9 10 11 12]...
        [2 9 10 11 12]...
        10;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [1 2 3 4 9 10 11 12]...
        [1 3 9 10 11 12]...
        [3 9 10 11 12]...
        11;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [1 2 3 4 9 10 11 12]...
        [2 4 9 10 11 12]...
        [4 9 10 11 12]...
        12;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [5 6 7 8 13 14 15 16]...
        [5 7 13 14 15 16]...
        [5 13 14 15 16]...
        13;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [5 6 7 8 13 14 15 16]...
        [6 8 13 14 15 16]...
        [6 13 14 15 16]...
        14;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [5 6 7 8 13 14 15 16]...
        [5 7 13 14 15 16]...
        [7 13 14 15 16]...
        15;...
        
        [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]...
        [5 6 7 8 13 14 15 16]...
        [6 8 13 14 15 16]...
        [8 13 14 15 16]...
        16;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [17 20 21 29]...
        [17 20 21 29]...
        [17 20 21]...
        17;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [18 22 26 30]...
        [18 22 26 30]...
        [18 22 26]...
        18;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [19 23 25 31]...
        [19 23 25 31]...
        [19 23 25]...
        19;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [17 20 29]...
        [17 20 29]...
        [17 20 29]...
        20;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [17 21 29]...
        [17 21 29]...
        [17 21 29]...
        21;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [18 22 26 30]...
        [18 22 26 30]...
        [18 22 30]...
        22;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [19 23 25 31]...
        [19 23 25 31]...
        [19 23 31]...
        23;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [24 27 28 32]...
        [24 27 28 32]...
        [24 27 28]...
        24;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [19 23 25 31]...
        [19 23 25 31]...
        [19 25 31]...
        25;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [18 22 26 30]...
        [18 22 26 30]...
        [18 26 30]...
        26;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [24 27 32]...
        [24 27 32]...
        [24 27 32]...
        27;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [24 28 32]...
        [24 28 32]...
        [24 28 32]...
        28;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [17 20 21 29]...
        [17 20 21 29]...
        [20 21 29]...
        29;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [18 22 26 30]...
        [18 22 26 30]...
        [22 26 30]...
        30;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [19 23 25 31]...
        [19 23 25 31]...
        [23 25 31]...
        31;...
        
        [17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]...
        [24 27 28 32]...
        [24 27 28 32]...
        [27 28 32]...
        32;...
    };

    % cell1_mtype cell2_mtype backconn numericID
    monomers2dimers = [ ...
        1 1 0 1;...
        1 2 0 2;...
        1 3 0 3;...
        1 4 0 4;...
        2 1 0 5;...
        2 2 0 6;...
        2 3 0 7;...
        2 4 0 8;...
        3 1 0 9;...
        3 2 0 10;...
        3 3 0 11;...
        3 4 0 12;...
        4 1 0 13;...
        4 2 0 14;...
        4 3 0 15;...
        4 4 0 16;...
        1 1 1 17;...
        1 2 1 18;...
        1 3 1 20;...
        1 4 1 22;...
        2 1 1 19;...
        2 2 1 24;...
        2 3 1 25;...
        2 4 1 27;...
        3 1 1 21;...
        3 2 1 26;...
        3 3 1 29;...
        3 4 1 30;...
        4 1 1 23;...
        4 2 1 28;...
        4 3 1 31;...
        4 4 1 32;...
    ];
        
    
    save validSwapClassLib swapClasses monomers2dimers;
end