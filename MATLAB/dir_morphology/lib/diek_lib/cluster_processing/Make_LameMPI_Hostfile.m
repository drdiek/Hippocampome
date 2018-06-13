function [real_Nr_CPUs, NR_Nodes]= Make_LameMPI_Hostfile(Nr_CPUs,struct_CPU_Node)


%dbstop in Make_LameMPI_Hostfile at 8

      
      
struct_CPU_Node{1}.NrCPU = struct_CPU_Node{1}.NrCPU;
NR_Nodes    =size(struct_CPU_Node,2);
for IDXNode=1:NR_Nodes
    CPUs(IDXNode)            =struct_CPU_Node{IDXNode}.NrCPU;
    Priority(IDXNode)        =struct_CPU_Node{IDXNode}.Priotity;
end
real_Nr_CPUs =sum(CPUs);
if Nr_CPUs==-1
   Nr_CPUs= real_Nr_CPUs;
end
if real_Nr_CPUs==Nr_CPUs
    disp(['All requested ' num2str(real_Nr_CPUs) ' CPU are included in the Clsuter'])
else
    if real_Nr_CPUs>Nr_CPUs
        disp(['You requested ('  num2str(Nr_CPUs) ') more CPUs than do exsit ('  num2str(real_Nr_CPUs) ')- Your requested number is included in the Cluster'])
        diff=real_Nr_CPUs-Nr_CPUs;
        P1  =-1;
        while and(diff>0,~isempty(P1 ))
            P1              =find(Priority==1);
            if ~isempty(P1)
                P1              =P1(1);
                Priority(P1)    =0;
                CPUs(P1)        =max([CPUs(P1)-diff 0]);
                real_Nr_CPUs    =sum(CPUs);
                diff            =real_Nr_CPUs-Nr_CPUs;
            end
            
        end
        diff=real_Nr_CPUs-Nr_CPUs;
        P1  =-1;
        while and(diff>0,~isempty(P1 ))
            P1              =find(Priority==2);
            if ~isempty(P1)
                P1              =P1(1);
                Priority(P1)    =0;
                CPUs(P1)        =max([CPUs(P1)-diff 0]);
                real_Nr_CPUs    =sum(CPUs);
                diff            =real_Nr_CPUs-Nr_CPUs;
            end
            
        end
        
    else 
        disp(['You requested ('  num2str(Nr_CPUs) ') more CPUs than do exsit ('  num2str(real_Nr_CPUs) ')- All existing CPUs are included in the Cluster'])
        Nr_CPUs == real_Nr_CPUs;
    end
    
end 
CPUs(1) = 1+CPUs(1);
oldir=pwd;
%cd(HomeDir)
scriptfilename                  = ['MPI_Lame_hostfile_auto.txt'];
fid                             = fopen(scriptfilename,'w');
for IDXNode=1:NR_Nodes
    Nodename            =struct_CPU_Node{IDXNode}.IP;
    Node_Nr_CPU         =CPUs(IDXNode);
    if Node_Nr_CPU >0
        string_script  =[Nodename ' cpu=' num2str(Node_Nr_CPU)];
        fprintf(fid,[string_script ' \n']);
    end
   
end
 fclose(fid);
% !lamhalt
% eval(['!lamboot ' scriptfilename])
% a=unix(['lamboot ' scriptfilename])
% cd(oldir)