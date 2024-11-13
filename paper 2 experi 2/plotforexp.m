clear all;
close all;
clc;
%%
load fault_experiment.mat
dt=5e-4;
time=0:dt:20;
%%
%画误差1
% figure1=figure('WindowState','maximized');
% clf; %清空图窗
% axes1 = axes('Parent',figure1,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% e11=plot(time, error_SOIT2FNN(1,:),'color','#D95319','linewidth', 2.5);
% e12=plot(time, error_PID(1,:),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time, error_PFTSMC(1,:),'color','#0072BD','linewidth', 2.5);
% e14=plot(time, error_AFFTFTSMC(1,:),'color','#EDB120','linewidth', 2.5);
% e15=plot(time, error_NNFTFTSMC(1,:),'color','#4DBEEE','linewidth', 2.5);
% hold on;
% line([1.5,1.5],[-0.4,0.2],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Error predefined-time threshold $T_p+T_e=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTSMC','NNFTFTSMC'},'Numcolumns',2)
% % 创建 ylabel
% ylabel('Error of joint 1/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('time/s','FontName','Times New Roman');
% grid(axes1,'on');
% hold(axes1,'off');
% % 设置其余坐标区属性
% set(axes1,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp1 = BaseZoom();
% zp1.plot;
% zp2 = BaseZoom();
% zp2.plot;
%%
% figure1=figure('WindowState','maximized');
% clf; %清空图窗
% axes1 = axes('Parent',figure1,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% e11=plot(time, error_SOIT2FNN(2,:),'color','#D95319','linewidth', 2.5);
% e12=plot(time, error_PID(2,:),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time, error_PFTSMC(2,:),'color','#0072BD','linewidth', 2.5);
% e14=plot(time, error_AFFTFTSMC(2,:),'color','#EDB120','linewidth', 2.5);
% e15=plot(time, error_NNFTFTSMC(2,:),'color','#4DBEEE','linewidth', 2.5);
% hold on;
% line([1.5,1.5],[-0.2,0.2],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Error predefined-time threshold $T_p+T_e=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTSMC','NNFTFTSMC'},'Numcolumns',2)
% % 创建 ylabel
% ylabel('Error of joint 1/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('time/s','FontName','Times New Roman');
% grid(axes1,'on');
% hold(axes1,'off');
% % 设置其余坐标区属性
% set(axes1,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp1 = BaseZoom();
% zp1.plot;
% zp2 = BaseZoom();
% zp2.plot;
%%
% figure1=figure('WindowState','maximized');
% clf; %清空图窗
% axes1 = axes('Parent',figure1,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% e11=plot(time, error_SOIT2FNN(3,:),'color','#D95319','linewidth', 2.5);
% e12=plot(time, error_PID(3,:),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time, error_PFTSMC(3,:),'color','#0072BD','linewidth', 2.5);
% e14=plot(time, error_AFFTFTSMC(3,:),'color','#EDB120','linewidth', 2.5);
% e15=plot(time, error_NNFTFTSMC(3,:),'color','#4DBEEE','linewidth', 2.5);
% hold on;
% line([1.5,1.5],[-0.3,0.3],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Error predefined-time threshold $T_p+T_e=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTSMC','NNFTFTSMC'},'Numcolumns',2)
% % 创建 ylabel
% ylabel('Error of joint 1/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('time/s','FontName','Times New Roman');
% grid(axes1,'on');
% hold(axes1,'off');
% % 设置其余坐标区属性
% set(axes1,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp1 = BaseZoom();
% zp1.plot;
% zp2 = BaseZoom();
% zp2.plot;
%%
% figure1=figure('WindowState','maximized');
% clf; %清空图窗
% axes1 = axes('Parent',figure1,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% e11=plot(time, tau_SOIT2FNN(3,:),'color','#D95319','linewidth', 2.5);
% e12=plot(time, tau_PID(3,:),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time, tau_PFTSMC(3,:),'color','#0072BD','linewidth', 2.5);
% e14=plot(time, tau_AFFTFTSMC(3,:),'color','#EDB120','linewidth', 2.5);
% e15=plot(time, tau_NNFTFTSMC(3,:),'color','#4DBEEE','linewidth', 2.5);
% hold on;
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTSMC','NNFTFTSMC'},'Numcolumns',2)
% % 创建 ylabel
% ylabel('Torque of joint 1/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes1,'on');
% hold(axes1,'off');
% % 设置其余坐标区属性
% set(axes1,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% %%
% figure1=figure('WindowState','maximized');
% clf; %清空图窗
% axes1 = axes('Parent',figure1,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% e11=plot(time, tau_SOIT2FNN(3,:),'color','#D95319','linewidth', 2.5);
% e12=plot(time, tau_PID(3,:),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time, tau_PFTSMC(3,:),'color','#0072BD','linewidth', 2.5);
% e14=plot(time, tau_AFFTFTSMC(3,:),'color','#EDB120','linewidth', 2.5);
% e15=plot(time, tau_NNFTFTSMC(3,:),'color','#4DBEEE','linewidth', 2.5);
% hold on;
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTSMC','NNFTFTSMC'},'Numcolumns',2)
% % 创建 ylabel
% ylabel('Torque of joint 3/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes1,'on');
% hold(axes1,'off');
% % 设置其余坐标区属性
% set(axes1,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
%%
%%
% figure7=figure('WindowState','maximized');
% clf;
% axes7=axes('Parent',figure7,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% uc1=plot(time, u_c(1,:),'color','#D95319','linewidth', 2.5);
% un1=plot(time, u_n(1,:),'color','#7E2F8E','linewidth', 2.5);
% legend({'u_c','u_n'})
% ylabel('Controller Output of joint 1/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes7,'on');
% hold(axes7,'off');
% % 设置其余坐标区属性
% set(axes7,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% %%
% figure8=figure('WindowState','maximized');
% clf;
% axes8=axes('Parent',figure8,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% uc2=plot(time, u_c(2,:),'color','#D95319','linewidth', 2.5);
% un2=plot(time, u_n(2,:),'color','#7E2F8E','linewidth', 2.5);
% legend({'u_c','u_n'})
% % 设置其余坐标区属性
% ylabel('Controller Output of joint 2/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes8,'on');
% hold(axes8,'off');
% set(axes8,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% %%
% figure9=figure('WindowState','maximized');
% clf;
% axes9=axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% uc3=plot(time, u_c(3,:),'color','#D95319','linewidth', 2.5);
% un3=plot(time, u_n(3,:),'color','#7E2F8E','linewidth', 2.5);
% ylabel('Controller Output of joint 3/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes9,'on');
% hold(axes9,'off');
% % 设置其余坐标区属性
% legend({'u_c','u_n'})
% set(axes9,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
%
% figure11=figure('WindowState','maximized');
% clf;
% axes11=axes('Parent',figure11,'Position',[0,0.1,1.14,0.8],'OuterPosition',[0,0,1.14,0.8]);
% grid on;
% hold on;
% rule1=plot(time, rule_number,'color','#D95319','linewidth', 2.5);
% ylabel('Total number of rules','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes11,'on');
% hold(axes11,'off');
% line([1,1],[0,10],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Error predefined-time threshold $T_p+T_e=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% % 设置其余坐标区属性
% set(axes11,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
AECI=0;
AAIC=0;
for i=1:3
    AAIC=AAIC+sum(abs(tau_PID(i,3001:end)-tau_PID(i,3000:end-1)))*5e-4;
end
AECI=AECI/3
AAIC=AAIC/3