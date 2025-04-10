clear all;
close all;
clc
%%
%Neural Networks-Based Fault Tolerant Control of a
%Robot via Fast Terminal Sliding Mode
mdl_puma560;
global system   %系统类型1 15s时出现参数扰动 对应论文simu1
% system=1;
system=1;      %系统类型2 15s时出现参数扰动 对应论文simu2
dt=5e-4;
time=0:dt:20;

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

q=zeros(6,length(time));
dq=zeros(6,length(time));
q(:,1)=[0 0 0 0 0 0]';
dq(:,1)=[0 0 0 0 0 0]';                        %机械臂各广义角度及广义角速度

x1=zeros(6,length(time));
x2=zeros(6,length(time));
x1(:,1)=[0 0 0 0 0 0]';
x2(:,1)=[0 0 0 0 0 0]';

z1=zeros(6,length(time));
z2=zeros(6,length(time));
alpha1=zeros(6,length(time));
s1=zeros(6,length(time));

u=zeros(6,length(time));
tau_fault=zeros(6,length(time));
tau=zeros(6,length(time));

K1=15; k1=10; k2=10; p=13; q_b=11;
eta=18; lambda=2;

net_output=zeros(3,length(time));
dob_value=zeros(3,length(time));
%%
for i=1:length(time)
    
    z1(:,i)=q(:,i)-q_desire(:,i);
    alpha1(:,i)=-K1*z1(:,i)+dq_desire(:,i);
    z2(:,i)=dq(:,i)-alpha1(:,i);

    s1(:,i)=z1(:,i)+k1*abs(z1(:,i)).^lambda.*sign(z1(:,i))+k2*abs(z2(:,i))...
        .^(p/q_b).*sign(z2(:,i));

    if i==1
        RBFNN=RBFNN();
        dob = dob();
    end

    RBFNN=RBFNN.adapt(s1(:,i));
    dob = dob.adapt(s1(:,i),z2(:,i));
    dob_value(:,i)=dob.dob_value;

    [net_output(:,i),~] = RBFNN.output(s1(:,i));

    u(:,i)=-q_b/p*(1/k2)*(s1(:,i)./(abs(s1(:,i)).^2)*z1(:,i)'*z2(:,i)+eta*abs(s1(:,i)).*(sign(s1(:,i)))).*...
        abs(z2(:,i)).^(1-p/q_b)-[dob.dob_value;0;0;0]-[net_output(:,i);0;0;0].*(abs(z2(:,i)).^(1-p/q_b));

    u(4:6,i)=zeros(3,1);
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
plot(time,z1(1,:))
title('关节误差1')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,2)
plot(time,z1(2,:))
title('关节误差2')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,3)
plot(time,z1(3,:))
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
    for i=1:length(time)
        RMSE(k)=RMSE(k)+z1(k,i)^2;
        ITAE(k)=ITAE(k)+i/length(time)*abs(z1(k,i))*dt;
        IAE(k)=IAE(k)+abs(z1(k,i))*dt;
        ISE(k)=ISE(k)+z1(k,i)^2*dt;
    end
    RMSE(k)=sqrt(RMSE(k)/length(time));
end
