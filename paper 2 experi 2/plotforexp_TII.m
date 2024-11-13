clear all;
close all;
clc;
%%
load fault_experiment.mat
dt=5e-4;
time=0:dt:20;
%%
% %画误差1
% figure(1);
% axes1 = subplot('Position',[0.075 0.25 0.25 0.4]);
% hold on;
% grid on;
% e11=plot(time, error_SOIT2FNN(1,:),'color','#D95319','linewidth', 2.5);
% e12=plot(time, error_PID(1,:),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time, error_PFTSMC(1,:),'color','#0072BD','linewidth', 2.5);
% e14=plot(time, error_AFFTFTSMC(1,:),'color','#EDB120','linewidth', 2.5);
% e15=plot(time, error_NNFTFTSMC(1,:),'color','#4DBEEE','linewidth', 2.5);
% line([1,1],[-0.4,0.2],'linestyle','--','linewidth',2.5,'color','k')
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTSMC','NNFTFTSMC','Time Boundary'},'Numcolumns',6)
% % 创建 ylabel
% ylabel('Error of joint 1/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% % 设置其余坐标区属性
% set(axes1,'FontName','Times New Roman','FontSize',28,...
%     'LineWidth',1);
% %画误差2
% axes2 = subplot('Position',[0.41 0.25 0.25 0.4]);
% hold on;
% grid on;
% e21=plot(time, error_SOIT2FNN(2,:),'color','#D95319','linewidth', 2.5);
% e22=plot(time, error_PID(2,:),'color','#7E2F8E','linewidth', 2.5);
% e23=plot(time, error_PFTSMC(2,:),'color','#0072BD','linewidth', 2.5);
% e24=plot(time, error_AFFTFTSMC(2,:),'color','#EDB120','linewidth', 2.5);
% e25=plot(time, error_NNFTFTSMC(2,:),'color','#4DBEEE','linewidth', 2.5);
% line([1,1],[-0.4,0.4],'linestyle','--','linewidth',2.5,'color','k')
% % 创建 ylabel
% ylabel('Error of joint 2/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% % 设置其余坐标区属性
% set(axes2,'FontName','Times New Roman','FontSize',28,...
%     'LineWidth',1);
% %画误差3
% axes3 = subplot('Position',[0.735 0.25 0.25 0.4]);
% hold on;
% grid on;
% e31=plot(time, error_SOIT2FNN(3,:),'color','#D95319','linewidth', 2.5);
% e32=plot(time, error_PID(3,:),'color','#7E2F8E','linewidth', 2.5);
% e33=plot(time, error_PFTSMC(3,:),'color','#0072BD','linewidth', 2.5);
% e34=plot(time, error_AFFTFTSMC(3,:),'color','#EDB120','linewidth', 2.5);
% e35=plot(time, error_NNFTFTSMC(3,:),'color','#4DBEEE','linewidth', 2.5);
% line([1,1],[-0.5,0.5],'linestyle','--','linewidth',2.5,'color','k')
% % 创建 ylabel
% ylim=[-0.1 0.7];
% ylabel('Error of joint 3/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% % 设置其余坐标区属性
% set(axes3,'FontName','Times New Roman','FontSize',28,...
%     'LineWidth',1);
% %局部放大
% axes4=axes('Position',[0.12 0.29 0.075 0.1]);
% set(axes4,'FontName','Times New Roman','FontSize',20,...
%     'LineWidth',1,'YLim',[-0.01 0.01]);
% hold on;
% e11=plot(time(750:3750), error_SOIT2FNN(1,750:3750),'color','#D95319','linewidth', 2.5);
% e12=plot(time(750:3750), error_PID(1,750:3750),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time(750:3750), error_PFTSMC(1,750:3750),'color','#0072BD','linewidth', 2.5);
% e14=plot(time(750:3750), error_AFFTFTSMC(1,750:3750),'color','#EDB120','linewidth', 2.5);
% e15=plot(time(750:3750), error_NNFTFTSMC(1,750:3750),'color','#4DBEEE','linewidth', 2.5);
% line([1.5,1.5],[-0.01,0.01],'linestyle','--','linewidth',2.5,'color','k');
% 
% axes5=axes('Position',[0.22 0.29 0.075 0.1]);
% set(axes5,'FontName','Times New Roman','FontSize',20,...
%     'LineWidth',1,'YLim',[-0.01 0.01]);
% hold on;
% e11=plot(time(19000:21000), error_SOIT2FNN(1,19000:21000),'color','#D95319','linewidth', 2.5);
% e12=plot(time(19000:21000), error_PID(1,19000:21000),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time(19000:21000), error_PFTSMC(1,19000:21000),'color','#0072BD','linewidth', 2.5);
% e14=plot(time(19000:21000), error_AFFTFTSMC(1,19000:21000),'color','#EDB120','linewidth', 2.5);
% e15=plot(time(19000:21000), error_NNFTFTSMC(1,19000:21000),'color','#4DBEEE','linewidth', 2.5);
% 
% axes6=axes('Position',[0.455 0.29 0.075 0.1]);
% set(axes6,'FontName','Times New Roman','FontSize',20,...
%     'LineWidth',1,'YLim',[-0.01 0.01]);
% hold on;
% e11=plot(time(750:3750), error_SOIT2FNN(2,750:3750),'color','#D95319','linewidth', 2.5);
% e12=plot(time(750:3750), error_PID(2,750:3750),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time(750:3750), error_PFTSMC(2,750:3750),'color','#0072BD','linewidth', 2.5);
% e14=plot(time(750:3750), error_AFFTFTSMC(2,750:3750),'color','#EDB120','linewidth', 2.5);
% e15=plot(time(750:3750), error_NNFTFTSMC(2,750:3750),'color','#4DBEEE','linewidth', 2.5);
% line([1.5,1.5],[-0.01,0.01],'linestyle','--','linewidth',2.5,'color','k');
% 
% axes7=axes('Position',[0.555 0.29 0.075 0.1]);
% set(axes7,'FontName','Times New Roman','FontSize',20,...
%     'LineWidth',1,'YLim',[-0.01 0.01]);
% hold on;
% e11=plot(time(19000:21000), error_SOIT2FNN(2,19000:21000),'color','#D95319','linewidth', 2.5);
% e12=plot(time(19000:21000), error_PID(2,19000:21000),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time(19000:21000), error_PFTSMC(2,19000:21000),'color','#0072BD','linewidth', 2.5);
% e14=plot(time(19000:21000), error_AFFTFTSMC(2,19000:21000),'color','#EDB120','linewidth', 2.5);
% e15=plot(time(19000:21000), error_NNFTFTSMC(2,19000:21000),'color','#4DBEEE','linewidth', 2.5);
% 
% axes8=axes('Position',[0.78 0.4 0.075 0.1]);
% set(axes8,'FontName','Times New Roman','FontSize',20,...
%     'LineWidth',1,'YLim',[-0.01 0.01]);
% hold on;
% e11=plot(time(750:3750), error_SOIT2FNN(3,750:3750),'color','#D95319','linewidth', 2.5);
% e12=plot(time(750:3750), error_PID(3,750:3750),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time(750:3750), error_PFTSMC(3,750:3750),'color','#0072BD','linewidth', 2.5);
% e14=plot(time(750:3750), error_AFFTFTSMC(3,750:3750),'color','#EDB120','linewidth', 2.5);
% e15=plot(time(750:3750), error_NNFTFTSMC(3,750:3750),'color','#4DBEEE','linewidth', 2.5);
% line([1.5,1.5],[-0.01,0.01],'linestyle','--','linewidth',2.5,'color','k');
% 
% axes9=axes('Position',[0.88 0.4 0.075 0.1]);
% set(axes9,'FontName','Times New Roman','FontSize',20,...
%     'LineWidth',1,'YLim',[-0.01 0.01]);
% hold on;
% e11=plot(time(19000:21000), error_SOIT2FNN(3,19000:21000),'color','#D95319','linewidth', 2.5);
% e12=plot(time(19000:21000), error_PID(3,19000:21000),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time(19000:21000), error_PFTSMC(3,19000:21000),'color','#0072BD','linewidth', 2.5);
% e14=plot(time(19000:21000), error_AFFTFTSMC(3,19000:21000),'color','#EDB120','linewidth', 2.5);
% e15=plot(time(19000:21000), error_NNFTFTSMC(3,19000:21000),'color','#4DBEEE','linewidth', 2.5);

%%
% %画误差1
% figure(2);
% axes1 = subplot('Position',[0.075 0.25 0.25 0.4]);
% hold on;
% grid on;
% e11=plot(time, tau_SOIT2FNN(1,:),'color','#D95319','linewidth', 2.5);
% e12=plot(time, tau_PID(1,:),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time, tau_PFTSMC(1,:),'color','#0072BD','linewidth', 2.5);
% e14=plot(time, tau_AFFTFTSMC(1,:),'color','#EDB120','linewidth', 2.5);
% e15=plot(time, tau_NNFTFTSMC(1,:),'color','#4DBEEE','linewidth', 2.5);
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTSMC','NNFTFTSMC'},'Numcolumns',5)
% % 创建 ylabel
% ylabel('Torque of joint 1/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% % 设置其余坐标区属性
% set(axes1,'FontName','Times New Roman','FontSize',28,...
%     'LineWidth',1);
% %画误差2
% axes2 = subplot('Position',[0.41 0.25 0.25 0.4]);
% hold on;
% grid on;
% e21=plot(time, tau_SOIT2FNN(2,:),'color','#D95319','linewidth', 2.5);
% e22=plot(time, tau_PID(2,:),'color','#7E2F8E','linewidth', 2.5);
% e23=plot(time, tau_PFTSMC(2,:),'color','#0072BD','linewidth', 2.5);
% e24=plot(time, tau_AFFTFTSMC(2,:),'color','#EDB120','linewidth', 2.5);
% e25=plot(time, tau_NNFTFTSMC(2,:),'color','#4DBEEE','linewidth', 2.5);
% % 创建 ylabel
% ylabel('Torque of joint 2/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% % 设置其余坐标区属性
% set(axes2,'FontName','Times New Roman','FontSize',28,...
%     'LineWidth',1);
% %画误差3
% axes3 = subplot('Position',[0.735 0.25 0.25 0.4]);
% hold on;
% grid on;
% e31=plot(time, tau_SOIT2FNN(3,:),'color','#D95319','linewidth', 2.5);
% e32=plot(time, tau_PID(3,:),'color','#7E2F8E','linewidth', 2.5);
% e33=plot(time, tau_PFTSMC(3,:),'color','#0072BD','linewidth', 2.5);
% e34=plot(time, tau_AFFTFTSMC(3,:),'color','#EDB120','linewidth', 2.5);
% e35=plot(time, tau_NNFTFTSMC(3,:),'color','#4DBEEE','linewidth', 2.5);
% ylabel('Torque of joint 3/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% % 设置其余坐标区属性
% set(axes3,'FontName','Times New Roman','FontSize',28,...
%     'LineWidth',1);
%%
figure(2);
axes1 = subplot('Position',[0.075 0.25 0.25 0.4]);
hold on;
grid on;
uc1=plot(time, u_c(1,:),'color','#D95319','linewidth', 2.5);
un1=plot(time, u_n(1,:),'color','#7E2F8E','linewidth', 2.5);
legend({'u_c','u_n','Time Boundary'},'Numcolumns',3)
% 创建 ylabel
ylabel('Controller output of joint 1/rad','FontName','Times New Roman');
% 创建 xlabel
xlabel('Time/s','FontName','Times New Roman');
% 设置其余坐标区属性
set(axes1,'FontName','Times New Roman','FontSize',28,...
    'LineWidth',1,'YLim',[-400,400]);
%画误差2
axes2 = subplot('Position',[0.41 0.25 0.25 0.4]);
hold on;
grid on;
uc1=plot(time, u_c(2,:),'color','#D95319','linewidth', 2.5);
un1=plot(time, u_n(2,:),'color','#7E2F8E','linewidth', 2.5);
% 创建 ylabel
ylabel('Controller output of joint 2/rad','FontName','Times New Roman');
% 创建 xlabel
xlabel('Time/s','FontName','Times New Roman');
% 设置其余坐标区属性
set(axes2,'FontName','Times New Roman','FontSize',28,...
    'LineWidth',1,'YLim',[-400,400]);
%画误差3
axes3 = subplot('Position',[0.735 0.25 0.25 0.4]);
hold on;
grid on;
e31=plot(time, u_c(3,:),'color','#D95319','linewidth', 2.5);
e32=plot(time, u_n(3,:),'color','#7E2F8E','linewidth', 2.5);
ylabel('Controller output of joint 3/rad','FontName','Times New Roman');
% 创建 xlabel
xlabel('Time/s','FontName','Times New Roman');
% 设置其余坐标区属性
set(axes3,'FontName','Times New Roman','FontSize',28,...
    'LineWidth',1,'YLim',[-400,400]);


