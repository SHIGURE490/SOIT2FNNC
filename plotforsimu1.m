clear all;
close all;
clc;

load SOIT2FNN.mat;
load AFFTFTSMC.mat;
load NNFTFTSMC.mat;
load PFTSMC_simu_formal.mat;
load pid_simu_formal.mat;
load added_FTC.mat;
load added_FTC2.mat;
% load SOIT2FNN_2.mat
kp=[300 250 100];
dt=5e-4;
time=0:dt:20;
time1 = 0:1e-3:20;
%%
% %%画误差1
% figure1=figure('WindowState','maximized');
% clf; %清空图窗
% axes1 = axes('Parent',figure1,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% e11=plot(time, error_SOIT2FNN(1,:),'color','#D95319','linewidth', 2.5);
% e12=plot(time, error_pid(1,:),'color','#7E2F8E','linewidth', 2.5);
% e13=plot(time, -error_PFTSMC(1,:),'color','#0072BD','linewidth', 2.5);
% e14=plot(time, -error_AFFTFTSMC(1,:),'color','#EDB120','linewidth', 2.5);
% e15=plot(time, error_NNFTFTSMC(1,:),'color','#4DBEEE','linewidth', 2.5);
% e16=plot(time1, -error_FAFTFTC(1,:),'color','#77AC30','linewidth', 2.5);
% e17=plot(time1, -error_AFFTSMC(1,:),'color','#A2142F','linewidth', 2.5);
% hold on;
% line([1,1],[-0.6,0.6],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Error predefined-time threshold $T_p+T_e=1s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTC','NNFTFTC','FAFTFTC','AFFTSMC'},'Numcolumns',2)
% % 创建 ylabel
% ylabel('Error of joint 1/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes1,'on');
% hold(axes1,'off');
% % 设置其余坐标区属性
% set(axes1,'FontName','Times New Roman','FontSize',30,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp1 = BaseZoom();
% zp1.plot;
% zp2 = BaseZoom();
% zp2.plot;
%%
%画误差2
% figure2=figure('WindowState','maximized');
% clf; %清空图窗
% axes2 = axes('Parent',figure2,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% e21=plot(time, error_SOIT2FNN(2,:),'color','#D95319','linewidth', 2.5);
% e22=plot(time, error_pid(2,:),'color','#7E2F8E','linewidth', 2.5);
% e23=plot(time, -error_PFTSMC(2,:),'color','#0072BD','linewidth', 2.5);
% e24=plot(time, -error_AFFTFTSMC(2,:),'color','#EDB120','linewidth', 2.5);
% e25=plot(time, error_NNFTFTSMC(2,:),'color','#4DBEEE','linewidth', 2.5);
% e26=plot(time1, -error_FAFTFTC(2,:),'color','#77AC30','linewidth', 2.5);
% e27=plot(time1, -error_AFFTSMC(2,:),'color','#A2142F','linewidth', 2.5);
% line([1,1],[-0.6,0.6],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Error predefined-time threshold $T_p+T_e=1s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTC','NNFTFTC','FAFTFTC','AFFTSMC'},'Numcolumns',2)
% % 创建 ylabel
% ylabel('Error of joint 2/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes2,'on');
% hold(axes2,'off');
% % 设置其余坐标区属性
% set(axes2,'FontName','Times New Roman','FontSize',30,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp21 = BaseZoom();
% zp21.plot;
% zp22 = BaseZoom();
% zp22.plot;
%%
%画误差3
% figure3=figure('WindowState','maximized');
% clf; %清空图窗
% axes3 = axes('Parent',figure3,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% e31=plot(time, error_SOIT2FNN(3,:),'color','#D95319','linewidth', 2.5);
% e32=plot(time, error_pid(3,:),'color','#7E2F8E','linewidth', 2.5);
% e33=plot(time, -error_PFTSMC(3,:),'color','#0072BD','linewidth', 2.5);
% e34=plot(time, -error_AFFTFTSMC(3,:),'color','#EDB120','linewidth', 2.5);
% e35=plot(time, error_NNFTFTSMC(3,:),'color','#4DBEEE','linewidth', 2.5);
% e26=plot(time1, -error_FAFTFTC(3,:),'color','#77AC30','linewidth', 2.5);
% e27=plot(time1, -error_AFFTSMC(3,:),'color','#A2142F','linewidth', 2.5);
% line([1,1],[-0.4,0.8],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Error predefined-time threshold $T_p+T_e=1s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTC','NNFTFTC','FAFTFTC','AFFTSMC'},'Numcolumns',2)
% % 创建 ylabel
% ylim([-0.4 0.8]);
% ylabel('Error of joint 3/rad','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes3,'on');
% hold(axes3,'off');
% % 设置其余坐标区属性
% set(axes3,'FontName','Times New Roman','FontSize',30,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp31 = BaseZoom();
% zp31.plot;
% zp32 = BaseZoom();
% zp32.plot;
%
figure4=figure('WindowState','maximized');
clf; %清空图窗
axes4 = axes('Parent',figure4,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
grid on;
hold on;
tau11=plot(time, tau_SOIT2FNN(1,:),'color','#D95319','linewidth', 1);
tau12=plot(time, tau_pid(1,:),'color','#7E2F8E','linewidth', 1);
tau13=plot(time, tau_PFTSMC(1,:),'color','#0072BD','linewidth', 1);
tau14=plot(time, tau_AFFTFTSMC(1,:),'color','#EDB120','linewidth', 1);
tau15=plot(time, tau_NNFTFTSMC(1,:),'color','#4DBEEE','linewidth', 1);
tau16=plot(time1, tau_FAFTFTC(1,:),'color','#77AC30','linewidth', 1);
tau17=plot(time1, tau_AFFTSMC(1,:),'color','#A2142F','linewidth', 1);
legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTC','NNFTFTC','FAFTFTC','AFFTSMC'},'Numcolumns',2)
ylabel('Torque of joint 1/N \cdot m','FontName','Times New Roman');
% 创建 xlabel
xlabel('Time/s','FontName','Times New Roman');
set(axes4,'FontName','Times New Roman','FontSize',30,...
    'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
grid(axes4,'on');
hold(axes4,'off');
zp31 = BaseZoom();
zp31.plot;
zp32 = BaseZoom();
zp32.plot;
% % 设置其余坐标区属性

% %
% figure5=figure('WindowState','maximized');
% clf; %清空图窗
% axes5 = axes('Parent',figure5,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% tau21=plot(time, tau_SOIT2FNN(2,:),'color','#D95319','linewidth', 1);
% tau22=plot(time, tau_pid(2,:),'color','#7E2F8E','linewidth', 1);
% tau23=plot(time, tau_PFTSMC(2,:),'color','#0072BD','linewidth', 1);
% tau24=plot(time, tau_AFFTFTSMC(2,:),'color','#EDB120','linewidth', 1);
% tau25=plot(time, tau_NNFTFTSMC(2,:),'color','#4DBEEE','linewidth', 1);
% tau26=plot(time1, tau_FAFTFTC(2,:),'color','#77AC30','linewidth', 1);
% tau27=plot(time1, tau_AFFTSMC(2,:),'color','#A2142F','linewidth', 1);
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTC','NNFTFTC','FAFTFTC','AFFTSMC'},'Numcolumns',2)
% ylabel('Torque of joint 2/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes5,'on');
% hold(axes5,'off');
% % 设置其余坐标区属性
% set(axes5,'FontName','Times New Roman','FontSize',30,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp31 = BaseZoom();
% zp31.plot;
% zp32 = BaseZoom();
% zp32.plot;
%
% figure6=figure('WindowState','maximized');
% clf; %清空图窗
% axes6 = axes('Parent',figure6,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% tau31=plot(time, tau_SOIT2FNN(3,:),'color','#D95319','linewidth', 1);
% tau32=plot(time, tau_pid(3,:),'color','#7E2F8E','linewidth', 1);
% tau33=plot(time, tau_PFTSMC(3,:),'color','#0072BD','linewidth', 1);
% tau34=plot(time, tau_AFFTFTSMC(3,:),'color','#EDB120','linewidth', 1);
% tau35=plot(time, tau_NNFTFTSMC(3,:),'color','#4DBEEE','linewidth', 1);
%  tau36=plot(time1, tau_FAFTFTC(3,:),'color','#77AC30','linewidth', 1);
%  tau37=plot(time1, tau_AFFTSMC(3,:),'color','#A2142F','linewidth', 1);
% legend({'SOIT2FNNC','PID','PFTSMC','AFFTFTC','NNFTFTC','FAFTFTC','AFFTSMC'},'Numcolumns',2)
% ylabel('Torque of joint 3/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('Time/s','FontName','Times New Roman');
% grid(axes6,'on');
% hold(axes6,'off');
% % 设置其余坐标区属性
% set(axes6,'FontName','Times New Roman','FontSize',30,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp31 = BaseZoom();
% zp31.plot;
% zp32 = BaseZoom();
% zp32.plot;
%%
% figure7=figure('WindowState','maximized');
% clf;
% axes7=axes('Parent',figure7,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% uc1=plot(time, u_c(1,:),'color','#D95319','linewidth', 2.5);
% un1=plot(time, u_n(1,:),'color','#7E2F8E','linewidth', 2.5);
% line([0.5,0.5],[-400,400],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Sliding surface predefined-time threshold $T_p=0.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'u_c','u_n'})
% ylabel('Controller Output of joint 1/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('time/s','FontName','Times New Roman');
% grid(axes7,'on');
% hold(axes7,'off');
% % 设置其余坐标区属性
% set(axes7,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
%%
% figure8=figure('WindowState','maximized');
% clf;
% axes8=axes('Parent',figure8,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% uc2=plot(time, u_c(2,:),'color','#D95319','linewidth', 2.5);
% un2=plot(time, u_n(2,:),'color','#7E2F8E','linewidth', 2.5);
% line([0.5,0.5],[-400,400],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Sliding surface predefined-time threshold $T_p=0.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'u_c','u_n'})
% ylabel('Controller Output of joint 2/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('time/s','FontName','Times New Roman');
% grid(axes8,'on');
% hold(axes8,'off');
% % 设置其余坐标区属性
% set(axes8,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
%%
% figure9=figure('WindowState','maximized');
% clf;
% axes9=axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% grid on;
% hold on;
% uc3=plot(time, u_c(3,:),'color','#D95319','linewidth', 2.5);
% un3=plot(time, u_n(3,:),'color','#7E2F8E','linewidth', 2.5);
% line([0.5,0.5],[-400,400],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Sliding surface predefined-time threshold $T_p=0.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% ylabel('Controller Output of joint 3/N \cdot m','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('time/s','FontName','Times New Roman');
% grid(axes9,'on');
% hold(axes9,'off');
% % 设置其余坐标区属性
% legend({'u_c','u_n'})
% set(axes9,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
%%
% figure10=figure('WindowState','maximized');
% clf;
% axes10=axes('Parent',figure10,'Position',[0,0.1,1.14,0.8],'OuterPosition',[0,0,1.14,0.8]);
% grid on;
% hold on;
% sp1=plot(time, u_c(1,:)/kp(1),'color','#D95319','linewidth', 2.5);
% sp2=plot(time, u_c(2,:)/kp(2),'color','#7E2F8E','linewidth', 2.5);
% sp3=plot(time, u_c(3,:)/kp(3),'color','#0072BD','linewidth', 2.5);
% line([0.5,0.5],[-8,8],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Sliding surface predefined-time threshold $T_p=0.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% ylabel('Sliding surface value s_i','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('time/s','FontName','Times New Roman');
% grid(axes10,'on');
% hold(axes10,'off');
% % 设置其余坐标区属性
% legend({'s_1','s_2','s_3'})
% set(axes10,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
% zp101 = BaseZoom();
% zp101.plot;
% %
% figure11=figure('WindowState','maximized');
% clf;
% axes11=axes('Parent',figure11,'Position',[0,0.1,1.14,0.8],'OuterPosition',[0,0,1.14,0.8]);
% grid on;
% hold on;
% rule1=plot(time, rule_number,'color','#D95319','linewidth', 2.5);
% ylabel('Total number of rules','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('time/s','FontName','Times New Roman');
% grid(axes11,'on');
% hold(axes11,'off');
% line([1,1],[0,35],'linestyle','--','linewidth',2.5,'color','k')
% Str = 'Error predefined-time threshold $T_p+T_e=1s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.2,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% % 设置其余坐标区属性
% set(axes11,'FontName','Times New Roman','FontSize',32,...
%     'LineWidth',1,'OuterPosition',[-0.05 0 1.14 0.7]);
    % IAE1=sum(abs(error_NNFTFTSMC(1,:)))*5e-4
    % IAE2=sum(abs(error_NNFTFTSMC(2,:)))*5e-4
    % IAE3=sum(abs(error_NNFTFTSMC(3,:)))*5e-4
    % ITAE1=sum(abs(error_SOIT2FNN(1,:)).*time)*5e-4
    % ITAE2=sum(abs(error_SOIT2FNN(2,:)).*time)*5e-4
    % ITAE3=sum(abs(error_SOIT2FNN(3,:)).*time)*5e-4
AECI=0;
AAIC=0;
for i=1:3
    AECI=AECI+sum(abs(tau_NNFTFTSMC(i,:)))*5e-4;
    AAIC=AAIC+sum(abs(tau_NNFTFTSMC(i,2:end)-tau_NNFTFTSMC(i,1:end-1)))*5e-4;
end
AECI=AECI/3
AAIC=AAIC/3