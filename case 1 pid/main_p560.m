clear all;
close all;
clc;
%%
%pid 控制
%参考robust adaptive fuzzy fault tolerant control of robot manipulators with
%unknow parameters
mdl_puma560;

global system   %系统类型1 15s时出现参数扰动 对应论文simu1
system=1;
% system=2;      %系统类型2 15s时出现参数扰动 对应论文simu2

dt=5e-4;       
time=0:dt:20;   %仿真步长及时间

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
error_int=zeros(6,length(time));

u=zeros(6,length(time));

tau_fault=zeros(6,length(time));

tau=zeros(6,length(time));

K_p=diag([750 750 750 0 0 0]); K_i=diag([200 200 200 0 0 0]); 
K_d=diag([100 100 100 0 0 0]);

%%
for i=1:length(time)

    error(:,i)=q_desire(:,i)-q(:,i);
    derror(:,i)=dq_desire(:,i)-dq(:,i);
    if i==1
        error_int(:,i)=error(:,i)*dt;
    else
        error_int(:,i)=error_int(:,i-1)+error(:,i)*dt;
    end

    u(:,i)=K_p*error(:,i)+K_d*derror(:,i)+K_i*error_int(:,i);
    
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
    for i=1:length(time)
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

