clear all;
close all;
clc;
dt=5e-4;
%%
TIME=0:dt:20;
load SOIT2FNN.mat;
index_SOIT2FNN=find(time.Value,1)-1;
error_SOIT2FNN=zeros(3,length(TIME));
tau_SOIT2FNN=zeros(3,length(TIME));
u_c=zeros(3,length(TIME));
u_n=zeros(3,length(TIME));
Sp=zeros(3,length(TIME));
for j=1:3
    error_SOIT2FNN(j,:)=eval(['q_e_',num2str(j-1),'.Value(',num2str(index_SOIT2FNN),':',num2str(index_SOIT2FNN+20/dt),')']);
    tau_SOIT2FNN(j,:)=eval(['tau_final_',num2str(j-1),'.Value(',num2str(index_SOIT2FNN),':',num2str(index_SOIT2FNN+20/dt),')']);
    u_c(j,:)=eval(['u_c_',num2str(j-1),'.Value(',num2str(index_SOIT2FNN),':',num2str(index_SOIT2FNN+20/dt),')']);
    u_n(j,:)=eval(['u_n_',num2str(j-1),'.Value(',num2str(index_SOIT2FNN),':',num2str(index_SOIT2FNN+20/dt),')']);
    Sp(j,:)=eval(['S_p_',num2str(j-1),'.Value(',num2str(index_SOIT2FNN),':',num2str(index_SOIT2FNN+20/dt),')']);
end
rule_number=rule_number.Value(index_SOIT2FNN:index_SOIT2FNN+20/dt);
load PID.mat;
index_PID=find(time.Value,1);
error_PID=zeros(3,length(TIME));
tau_PID=zeros(3,length(TIME));
for j=1:3
    error_PID(j,:)=eval(['q_e_',num2str(j-1),'.Value(',num2str(index_PID),':',num2str(index_PID+20/dt),')']);
    tau_PID(j,:)=eval(['tau_final_',num2str(j-1),'.Value(',num2str(index_PID),':',num2str(index_PID+20/dt),')']);
end
load PFTSMC.mat;
index_PFTSMC=find(time.Value,1)-1;
error_PFTSMC=zeros(3,length(TIME));
tau_PFTSMC=zeros(3,length(TIME));
for j=1:3
    error_PFTSMC(j,:)=eval(['q_e_',num2str(j-1),'.Value(',num2str(index_PFTSMC),':',num2str(index_PFTSMC+20/dt),')']);
    tau_PFTSMC(j,:)=eval(['tau_final_',num2str(j-1),'.Value(',num2str(index_PFTSMC),':',num2str(index_PFTSMC+20/dt),')']);
end
load AFFTFTSMC.mat;
index_AFFTFTSMC=find(time.Value,1)-1;
error_AFFTFTSMC=zeros(3,length(TIME));
tau_AFFTFTSMC=zeros(3,length(TIME));
for j=1:3
    error_AFFTFTSMC(j,:)=eval(['q_e_',num2str(j-1),'.Value(',num2str(index_AFFTFTSMC),':',num2str(index_AFFTFTSMC+20/dt),')']);
    tau_AFFTFTSMC(j,:)=eval(['tau_final_',num2str(j-1),'.Value(',num2str(index_AFFTFTSMC),':',num2str(index_AFFTFTSMC+20/dt),')']);
end
load NNFTSMC.mat;
index_NNFTFTSMC=find(time.Value,1)-1;
error_NNFTFTSMC=zeros(3,length(TIME));
tau_NNFTFTSMC=zeros(3,length(TIME));
for j=1:3
    error_NNFTFTSMC(j,:)=eval(['q_e_',num2str(j-1),'.Value(',num2str(index_NNFTFTSMC),':',num2str(index_NNFTFTSMC+20/dt),')']);
    tau_NNFTFTSMC(j,:)=eval(['tau_final_',num2str(j-1),'.Value(',num2str(index_NNFTFTSMC),':',num2str(index_NNFTFTSMC+20/dt),')']);
end
save fault_experiment.mat error_SOIT2FNN error_NNFTFTSMC error_AFFTFTSMC error_PID error_PFTSMC tau_SOIT2FNN tau_PID tau_NNFTFTSMC tau_AFFTFTSMC ...
    tau_PFTSMC u_c u_n Sp rule_number