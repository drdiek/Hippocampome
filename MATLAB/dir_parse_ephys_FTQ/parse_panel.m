function iFTQ_substrng = parse_panel(iFTQ_strng)

    iFTQ_upper_strng = upper(iFTQ_strng(1));
                
    iFTQ_upper_ascii = double(iFTQ_upper_strng);
    
    iFTQ_upper = iFTQ_upper_ascii - double('A') + 1;
    
    iFTQ_substrng = sprintf('%02d', iFTQ_upper);
    
end