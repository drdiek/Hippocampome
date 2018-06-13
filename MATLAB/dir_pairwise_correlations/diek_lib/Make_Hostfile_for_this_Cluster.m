wished_Nr_CPUs       = -1; %Whished Nr of CPUs: if -1 maximal avaiable number otherwise the wished number of cpu is included in the MPI Cluster


% Node architecure should be defined by the administrator

% Master Node -------------------------------------------------------------
struct_CPU_Node{1}.NrCPU    =1;                 % NrCPU equal the number of CPU used to compute - the m,aster process will be started in addtion
struct_CPU_Node{1}.IP       =['141.5.6.181'];   
struct_CPU_Node{1}.Priotity =1;                 % 3=must be included 2=should be included 1= should not bee included

% Slave Nodes -------------------------------------------------------------
struct_CPU_Node{2}.NrCPU    =1;
struct_CPU_Node{2}.IP       =['141.5.6.182'];   % Slave 1
struct_CPU_Node{2}.Priotity =1;                 % 3=must be included 2=should be included 1= should not bee included

struct_CPU_Node{3}.NrCPU    =2;
struct_CPU_Node{3}.IP       =['141.5.6.183'];   % Slave 2
struct_CPU_Node{3}.Priotity =2;                 % 3=must be included 2=should be included 1= should not bee included

struct_CPU_Node{4}.NrCPU    =2;
struct_CPU_Node{4}.IP       =['141.5.6.184'];   % Slave 3
struct_CPU_Node{4}.Priotity =2;                 % 3=must be included 2=should be included 1= should not bee included

struct_CPU_Node{5}.NrCPU    =2;
struct_CPU_Node{5}.IP       =['141.5.6.185'];   % Slave 4
struct_CPU_Node{5}.Priotity =2;                 % 3=must be included 2=should be included 1= should not bee included

struct_CPU_Node{6}.NrCPU    =2;
struct_CPU_Node{6}.IP       =['141.5.6.186'];   % Slave 5
struct_CPU_Node{6}.Priotity =2;                 % 3=must be included 2=should be included 1= should not bee included

struct_CPU_Node{7}.NrCPU    =2;
struct_CPU_Node{7}.IP       =['141.5.6.187'];   % Slave 6
struct_CPU_Node{7}.Priotity =2;                 % 3=must be included 2=should be included 1= should not bee included

struct_CPU_Node{8}.NrCPU    =2;
struct_CPU_Node{8}.IP       =['141.5.6.188'];   % Slave 7
struct_CPU_Node{8}.Priotity =2;                 % 3=must be included 2=should be included 1= should not bee included


disp('**************************************************************************')
disp('Automatic Generation of the MPI Hostfile')
disp('**************************************************************************')

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Lame MPI hostfile is generated 
%--------------------------------------------------------------------------
[Nr_CPUs NrNodes]           = Make_LameMPI_Hostfile(wished_Nr_CPUs,struct_CPU_Node);

save('Cluster_Definition_File_Cluster_Queues','struct_CPU_Node','Nr_CPUs','NrNodes')
disp('--------------------------------------------------------------------------')
disp(['The Cluster consists of ' num2str(NrNodes) ' Nodes'])
disp(['with together ' num2str(Nr_CPUs) ' CPUs'])
disp('--------------------------------------------------------------------------')
disp('--------------------------------------------------------------------------')

%**************************************************************************
%WHAT NEXT   **************************************************************
%**************************************************************************
%**************************************************************************
disp('**************************************************************************')
disp('*******************  WHATs NEXT  *****************************************')
disp('**************************************************************************')

disp('1) Run "lamehalt"')
disp('2) Run "lameboot  MPI_Lame_hostfile_auto.txt"')
disp('3) Run "lamnodes"')
