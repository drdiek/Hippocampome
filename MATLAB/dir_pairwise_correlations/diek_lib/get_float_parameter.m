function prm = get_float_parameter(prm, min, descStr)

  reply = [];
  clc;
  
  strng = sprintf('The %s is %.3f.', descStr, prm);
  disp(strng);

  prm = get_new_float(prm, min);
  
end % get_cell_capacitance
