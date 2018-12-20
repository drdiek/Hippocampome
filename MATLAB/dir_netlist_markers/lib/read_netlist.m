function [txt, raw] = read_netlist(netlistFileName)

    strng = sprintf('\nLoading netlist file ...');
    disp(strng);
    [num, txt, raw] = xlsread(netlistFileName, 'netlist');%, 'A20:AK169');
    
end % read_netlist()