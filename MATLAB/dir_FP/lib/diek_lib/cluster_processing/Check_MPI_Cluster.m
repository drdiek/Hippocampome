function [Nr_CPUs,Nr_Nodes,CPU_per_node]            = Check_MPI_Cluster;

[t,w]       = unix('lamnodes');
IDX         = find(w==':');
Nr_Nodes    = length(IDX);
for IDX_Node=1:Nr_Nodes
    cpu(IDX_Node) = str2num(w(IDX(IDX_Node)+1));
end
cpu(1) = cpu(1)-1; % First CPU of the Master node is the Mast Programm and does not do any compuatition 
Nr_CPUs =sum(cpu);
CPU_per_node =cpu;