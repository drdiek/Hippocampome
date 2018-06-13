function postCheckText = checkText(preCheckText)

%     if (strfind(preCheckText, 'packet') || strfind(preCheckText, 'et al') || strfind(preCheckText, '@@') || strfind(preCheckText, 'microm') || ...
%             strfind(preCheckText, 'rat') || strfind(preCheckText, 'slice') || strfind(preCheckText, 'mouse') || strfind(preCheckText, 'mice'))
        
    nOmissions = 0;

    nOmissions = nOmissions + length(strfind(preCheckText, 'packet'));
    
    nOmissions = nOmissions + length(strfind(preCheckText, 'et al'));
    
    nOmissions = nOmissions + length(strfind(preCheckText, '@@'));
    
    nOmissions = nOmissions + length(strfind(preCheckText, 'microm'));
    
    nOmissions = nOmissions + length(strfind(preCheckText, 'rat'));
    
    nOmissions = nOmissions + length(strfind(preCheckText, 'slice'));
    
    nOmissions = nOmissions + length(strfind(preCheckText, 'mouse'));
    
    nOmissions = nOmissions + length(strfind(preCheckText, 'mice'));
    
    nOmissions = nOmissions + length(strfind(preCheckText, 'to be mined'));
    
    if (nOmissions > 0)
 
        postCheckText = [];
        
    else
        
        postCheckText = sprintf('%s.', preCheckText);
        
    end

end