clear all;
close all;
clc;
%%
%参考Adaptive Fuzzy Fault Tolerant Control for Robot
 %Manipulators With Fixed-Time Convergence section 4
mdl_puma560;

global system   %系统类型1 15s时出现参数扰动 对应论文simu1
% system=1;
system=2;      %系统类型2 15s时出现参数扰动 对应论文simu2

dt=1e-3;       
time=0:dt:8;   %仿真步长及时间

q=zeros(6,length(time));
dq=zeros(6,length(time));
q(:,1)=[0 0 0 0 0 0]';
dq(:,1)=[0 0 0 0 0 0]';                        %机械臂各广义角度及广义角速度

q_desire=[sin(time*pi/3)-0.5;
    1.5*cos(time*pi/3+pi/3)-1.3;
    sin(time*pi/3+pi/3)-0.2;
    zeros(1,length(time));
    zeros(1,length(time));
    zeros(1,length(time))];
dq_desire=[pi/3*cos(time*pi/3);
    -1.5*pi/3*sin(time*pi/3+pi/3);
    pi/3*cos(time*pi/3+pi/3);
    zeros(1,length(time));
    zeros(1,length(time));
    zeros(1,length(time))];
ddq_desire=[-(pi/3)^2*sin(time*pi/3);
    -1.5*(pi/3)^2*cos(time*pi/3+pi/3);
    -(pi/3)^2*sin(time*pi/3+pi/3);
    zeros(1,length(time));
    zeros(1,length(time));
    zeros(1,length(time))];

s1=zeros(6,length(time));
alpha_s=zeros(6,length(time));
s2=zeros(6,length(time));

u=zeros(6,length(time));

tau_fault=zeros(6,length(time));

tau=zeros(6,length(time));

k1=3; k2=10; k3=10;
k8=3; k9=10; k10=10;

alpha=5/7; beta=5/3;

s1_d=zeros(6,length(time));
s1_alpha_d=zeros(6,length(time));
s1_beta_d=zeros(6,length(time));
alpha_s_d=zeros(6,length(time));

iota=0.005;

%%
for i=1:length(time)

    s1(:,i)=q(:,i)-q_desire(:,i);
    alpha_s(:,i)=-(k1*s1(:,i)+k2*abs(s1(:,i)).^alpha.*sign(s1(:,i))+k3*abs(s1(:,i)).^beta.*sign(s1(:,i)))+dq_desire(:,i);
    s2(:,i)=dq(:,i)-alpha_s(:,i);

    s1_d(:,i)=dq(:,i)-dq_desire(:,i);
    for j=1:6
        if abs(s1(j,i))>=iota
            s1_alpha_d(j,i)=alpha*abs(s1(j,i))^(alpha-1)*...
               (dq(j,i)-dq_desire(j,i));
        else
            s1_alpha_d(j,i)=alpha*iota^(alpha-1)*...
               (dq(j,i)-dq_desire(j,i));
        end
    end
    s1_beta_d(:,i)=beta*abs(s1(:,i)).^(beta-1).*...
               (dq(:,i)-dq_desire(:,i));
    alpha_s_d(:,i)=-(k1*s1_d(:,i)+k2*s1_alpha_d(:,i)+k3*s1_beta_d(:,i))+ddq_desire(:,i);

    s2(:,i)=dq(:,i)-alpha_s(:,i);
   
    M0=p560.inertia(q(:,i)');
    C0=p560.coriolis(q(:,i)',dq(:,i)');
    G0=p560.gravload(q(:,i)');

    if i==1
        fuzzy = fuzzy_compensator();
    end
    input=[s2(1:3,i)];
    fuzzy=fuzzy.adapt(input);
    [net_output,~] = fuzzy.output(input);

    u(:,i)=C0*dq(:,i)+G0'+M0*(alpha_s_d(:,i)-k8*s2(:,i)-k9*abs(s2(:,i)).^alpha.*sign(s2(:,i))-...
        k10*abs(s2(:,i)).^beta.*sign(s2(:,i)));

    u(:,i)=-M0*([net_output;zeros(3,1)])+u(:,i);

    [tau_fault(:,i)] = fault_(u(:,i),time(i));
    u_max=[400;400;400;400;400;400];
    [tau(:,i)]=saturation_p560(tau_fault(:,i),u_max);

    if i<length(time)
    [q(:,i+1),dq(:,i+1)]=simu_p560(p560,q(:,i),dq(:,i),tau(:,i),time(i));
    q(4:6,i+1)=zeros(3,1);
    dq(4:6,i+1)=zeros(3,1);
    end

    disp([num2str(i/(length(time))*100,'%.2f'),'% completed.'])

end
figure(2)
subplot(3,1,1)
plot(time,q(1,:),time,q_desire(1,:))
title('关节角度1')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,2)
plot(time,q(2,:),time,q_desire(2,:))
title('关节角度2')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,3)
plot(time,q(3,:),time,q_desire(3,:))
title('关节角度3')
ylabel('广义坐标/rad')
xlabel('t/s')
figure(3)
subplot(3,1,1)
plot(time,dq(1,:),time,dq_desire(1,:))
title('关节角速度1')
ylabel('广义速度/rad/s')
xlabel('t/s')
subplot(3,1,2)
plot(time,dq(2,:),time,dq_desire(2,:))
title('关节角速度2')
ylabel('广义速度/rad/s')
xlabel('t/s')
subplot(3,1,3)
plot(time,dq(3,:),time,dq_desire(3,:))
title('关节角速度3')
ylabel('广义速度/rad/s')
xlabel('t/s')
figure(4)
subplot(3,1,1)
plot(time,tau(1,:))
hold on
tao_upper=[400 400];
tao_lower=[-400 -400];
line([0 20],tao_upper,'Color','red','LineStyle','--')
hold on
line([0 20],tao_lower,'Color','red','LineStyle','--')
title('关节力矩1')
ylabel('关节力矩/N m')
xlabel('t/s')
subplot(3,1,2)
plot(time,tau(2,:))
hold on
line([0 20],tao_upper,'Color','red','LineStyle','--')
hold on
line([0 20],tao_lower,'Color','red','LineStyle','--')
title('关节力矩2')
ylabel('关节力矩/N m')
xlabel('t/s')
subplot(3,1,3)
plot(time,tau(3,:))
hold on
line([0 20],tao_upper,'Color','red','LineStyle','--')
hold on
line([0 20],tao_lower,'Color','red','LineStyle','--')
title('关节力矩3')
ylabel('关节力矩/N m')
xlabel('t/s')
figure(5)
subplot(3,1,1)
plot(time,-s1(1,:))
title('关节误差1')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,2)
plot(time,-s1(2,:))
title('关节误差2')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,3)
plot(time,-s1(3,:))
title('关节误差3')
ylabel('广义坐标/rad')
xlabel('t/s')

RMSE=zeros(3,1);
ITAE=zeros(3,1);
ISE=zeros(3,1);
IAE=zeros(3,1);
ECI=zeros(3,1);
AICE=zeros(3,1);
for k=1:3
    for i=4001:length(time)
        RMSE(k)=RMSE(k)+s1(k,i)^2;
        ITAE(k)=ITAE(k)+i/length(time)*abs(s1(k,i))*dt;
        IAE(k)=IAE(k)+abs(s1(k,i))*dt;
        ISE(k)=ISE(k)+s1(k,i)^2*dt;
    end
    RMSE(k)=sqrt(RMSE(k)/length(time));
end
% ITAE
% ISE
% RMSE
% for k=1:3
%     for i=1:length(time)
%         ECI(k)=ECI(k)+tao(k,i)^2*dt;
%     end
% end
% ECI
% for k=1:3
%     for i=1:(length(time)-1)
%         AICE(k)=AICE(k)+abs(tao(k,i+1)-tao(k,i))*dt;
%     end
% end
% AICE

