clear all;
close all;
clc;
%%
%pid 控制
%参考robust adaptive fuzzy fault tolerant control of robot manipulators with
%unknow parameters
mdl_puma560;
mdl_puma561;

global system   %系统类型1 15s时出现参数扰动 对应论文simu1
% system=1;
system=1;      %系统类型2 15s时出现参数扰动 对应论文simu2

dt=5e-4;       
time=0:dt:5;   %仿真步长及时间

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

error=zeros(6,length(time));
derror=zeros(6,length(time));

u=zeros(6,length(time));
u_c=zeros(6,length(time)); u_n=zeros(6,length(time));

tau_fault=zeros(6,length(time));

tau=zeros(6,length(time));

W1=zeros(1,length(time));
W2=zeros(1,length(time));
W3=zeros(1,length(time));          %记录网络权值

hat_p=zeros(6,length(time));

beta=0.8;
Te=0.5;                           %收敛时间1
iota=0.005;                       %收敛域
kp=[150 150 150 0 0 0];     

%控制器放大倍数
alpha=100;
gamma0=0.2;
%%
for i=1:length(time)

    error(:,i)=q_desire(:,i)-q(:,i);
    derror(:,i)=dq_desire(:,i)-dq(:,i);
    for j=1:6
        if abs(error(j,i))>=iota
            u_c(j,i)=kp(j)*(derror(j,i)+1/(Te*beta)*(2*error(j,i)+abs(error(j,i))^(1-beta)*sign(error(j,i))+abs(error(j,i))^(1+beta)*sign(error(j,i))));
        else
            u_c(j,i)=kp(j)*(derror(j,i)+1/(Te*beta)*(2*error(j,i)+iota^(-beta)*error(j,i)+abs(error(j,i))^(1+beta)*sign(error(j,i))));
        end
    end

    input=[error(1:3,i);derror(1:3,i)];

    if i==1
        [SOIT2FNN]=SOIT2FNN(input);
    else
        [SOIT2FNN]=SOIT2FNN.self_organize(input,u_c(1:3,i),i);
    end

    [SOIT2FNN]=SOIT2FNN.adapt(input,u_c(1:3,i));
    [~,net_output] = SOIT2FNN.net_output(input);

    u_n(:,i)=[net_output;0;0;0];

    u(:,i)=u_c(:,i)+u_n(:,i);

    [tau_fault(:,i)] = fault_(u(:,i),time(i));
    u_max=[400;400;400;400;400;400];
    [tau(:,i)]=saturation_p560(tau_fault(:,i),u_max);

    if i<length(time)
    [q(:,i+1),dq(:,i+1)]=simu_p560(p561,q(:,i),dq(:,i),tau(:,i),time(i));
    q(4:6,i+1)=zeros(3,1);
    dq(4:6,i+1)=zeros(3,1);
    end
    
    disp([num2str(i/(length(time))*100,'%.2f'),'% completed.'])
    rule_number(i)=size(SOIT2FNN.center,2);
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
plot(time,error(1,:))
title('关节误差1')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,2)
plot(time,error(2,:))
title('关节误差2')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,3)
plot(time,error(3,:))
title('关节误差3')
ylabel('广义坐标/rad')
xlabel('t/s')
figure(6)
subplot(3,1,1)
plot(time,derror(1,:))
title('关节角速度误差1')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,2)
plot(time,derror(2,:))
title('关节角速度误差2')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,3)
plot(time,derror(3,:))
title('关节角速度误差3')
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
        RMSE(k)=RMSE(k)+error(k,i)^2;
        ITAE(k)=ITAE(k)+i/length(time)*abs(error(k,i))*dt;
        IAE(k)=IAE(k)+abs(error(k,i))*dt;
        ISE(k)=ISE(k)+error(k,i)^2*dt;
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

