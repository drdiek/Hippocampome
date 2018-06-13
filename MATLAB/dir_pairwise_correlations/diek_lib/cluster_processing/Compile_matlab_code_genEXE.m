function Compile_matlab_code_genEXE(Calc_function_name_m)

old_2dir=pwd;
Calc_function_name   =[Calc_function_name_m '_EXE'];
eval(['mcc -m -O all ' Calc_function_name_m '.m']);
eval(['!mv ' Calc_function_name_m ' ' Calc_function_name ]);
!rm -f *.c
!rm -f *.h
cd(old_2dir);
