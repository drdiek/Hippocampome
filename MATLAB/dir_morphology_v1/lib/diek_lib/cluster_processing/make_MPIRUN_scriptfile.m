function [used_CPUs, scriptfilename] =make_MPIRUN_scriptfile(File_to_execute,Parameterfile_ID,Nr_CPUs,wished_number)

%dbstop in make_MPIRUN_scriptfile at 25
Priority_CPU =[];
if exist('Cluster_Definition_File_Cluster_Queues.mat')==2
    load('Cluster_Definition_File_Cluster_Queues')
    NR_Nodes    =size(struct_CPU_Node,2);
    for IDXNode=1:NR_Nodes
        CPUs(IDXNode)            =struct_CPU_Node{IDXNode}.NrCPU;
        Priority(IDXNode)        =struct_CPU_Node{IDXNode}.Priotity;
        Priority_CPU             =[Priority_CPU ones(CPUs(IDXNode),1)'.*Priority(IDXNode)];
    end
    if length(Priority_CPU )~= Nr_CPUs
        disp('The information in the File "Cluster_Definition_File_Cluster_Queues.mat" is not consitent with the MPI running enviroment')
        disp('Thus Priorities of certain CPU can not be considered')
        Priority_CPU = ones(1,Nr_CPUs);
    end
else
    disp('The File "Cluster_Definition_File_Cluster_Queues.mat" is not found')
    disp('Thus Priorities of certain CPU can not be considered')
    Priority_CPU = ones(1,Nr_CPUs);
end
consider_CPU        = ones(size(Priority_CPU));

if or(wished_number==Nr_CPUs,wished_number ==-1)
    wished_number=Nr_CPUs;
    disp(['All requested/available ' num2str(wished_number) ' CPU are included in the Clsuter'])
else
    if wished_number<Nr_CPUs
        disp(['You requested ('  num2str(wished_number) ') less CPUs than do exsit ('  num2str(Nr_CPUs) ')- Your requested number is included in the Cluster'])
        IDX_P1      = find(Priority_CPU==1);
        Diff_Nr_CPU = Nr_CPUs-wished_number;
        IDX_E       = length(IDX_P1);
        IDX_S       = max([1 IDX_E-Diff_Nr_CPU+1]);
        consider_CPU(IDX_P1(IDX_S:IDX_E))=0;
        act_NrCPUs  = sum(consider_CPU);
        IDX_P2      = find(Priority_CPU==2);
        Diff_Nr_CPU = act_NrCPUs-wished_number;
        if Diff_Nr_CPU>0
            IDX_E       = length(IDX_P2);
            IDX_S       = max([1 IDX_E-Diff_Nr_CPU+1]);   
            consider_CPU(IDX_P2(IDX_S:IDX_E))=0;
        end
      
    else 
        disp(['You requested ('  num2str(wished_number) ') more CPUs than do exsit ('  num2str(Nr_CPUs) ')- All existing CPUs are included in the Cluster'])
        wished_number=Nr_CPUs;
    end
end
used_CPUs   =sum(consider_CPU);

file_name_PMatlabGP_Controll    = ['execution_control_file__' File_to_execute '__' Parameterfile_ID '.ecf'];
sting_script1                   = ['c0 pcalc ' file_name_PMatlabGP_Controll ];
scriptfilename                  = ['MPIRUN_scriptfile_for__' File_to_execute '__' Parameterfile_ID '.txt'];
fid                             = fopen(scriptfilename,'w');
fprintf(fid,[sting_script1 ' \n']);
for IDX_CPU=1:length(consider_CPU)
    if consider_CPU(IDX_CPU)==1
        sting_script2                   = ['c' num2str(IDX_CPU) ' pcalc'];
        fprintf(fid,[sting_script2 ' \n']);
    end
end                  
fclose(fid);
