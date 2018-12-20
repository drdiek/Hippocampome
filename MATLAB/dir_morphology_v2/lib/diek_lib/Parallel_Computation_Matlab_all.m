clear all

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%           Definitions Parameters
%--------------------------------------------------------------------------
File_to_execute      = 'rate_45_fre_125_45_all_data_gen_perm_all' %Do_computation_M'
Parameterfile_ID     = 'ID_002'
wished_Nr_CPUs       =  14;                      %Whished Nr of CPUs: if -1 maximal avaiable number otherwise the wished number of cpu is included in the MPI Cluster
Compuations_to_do    =  1:24;                   %Number of Compuations to be done
Nice_level           =  19;




%##########################################################################
%##########################################################################
%           Code 
%--------------------------------------------------------------------------

Filename_executable  =[File_to_execute '_EXE'];

[Nr_CPUs Nr_Nodes CPU_per_node]    = Check_MPI_Cluster;

%--------------------------------------------------------------------------
%Computation control file is generated
%--------------------------------------------------------------------------
[Parameterfile,file_name_PMatlabGP_Controll ] = ...
    make_execution_control_file(Compuations_to_do,Filename_executable,Parameterfile_ID,Nice_level);

%--------------------------------------------------------------------------
%MPIrun script file is generated % 
%--------------------------------------------------------------------------
[Used_CPUs Script_filename] =make_MPIRUN_scriptfile(Filename_executable,Parameterfile_ID,Nr_CPUs,wished_Nr_CPUs)



%--------------------------------------------------------------------------
%Matlab function which has to be executed is compiled
%--------------------------------------------------------------------------
Compile_matlab_code_genEXE(File_to_execute)


%--------------------------------------------------------------------------
%Start compuation
%--------------------------------------------------------------------------
unix_command    = ['mpirun ' Script_filename ];
[t Shell_output]= system(unix_command);

%**************************************************************************
%Compuation finished on all nodes    **************************************
%**************************************************************************
%**************************************************************************
