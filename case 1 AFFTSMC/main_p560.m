clear all;
close all;
clc;
%%
%pid 控制
%参考 Adaptivefixed-time fuzzy fault-tolerant control for robotic manipulator withunknownfrictionandcompositeactuatorfaults
mdl_puma560;

global system   %系统类型1 15s时出现参数扰动 对应论文simu1
system=1;
% system=2;      %系统类型2 15s时出现参数扰动 对应论文simu2

dt=1e-3;       
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
ddq_desire=[-pi/3*pi/3*sin(time*pi/3);
    -1.5*pi/3*pi/3*cos(time*pi/3+pi/3);
    -pi/3*pi/3*sin(time*pi/3+pi/3);
    zeros(1,length(time));
    zeros(1,length(time));
    zeros(1,length(time))];

error = zeros(6,length(time));
error_dot = zeros(6,length(time));
u = zeros(6,length(time));
s = zeros(6,length(time));
L1 = zeros(6,6);
L2 = zeros(6,6);
H = zeros(6,length(time));
Sig_L2 = zeros(6,length(time));

F = zeros(6,length(time));
F_dot = zeros(6,length(time));

H_dot = zeros(6,length(time));
Sig_L2_dot = zeros(6,length(time));

S = zeros(6,length(time));

L1 = diag([5 5 5 0 0 0]);
L2 = diag([5 5 5 0 0 0]);

sigma = 0.005; l1 = 5/7; l2 = 9/7;

delta=0.5; W = 2;

K_a = (3/2 - 1/2*l1)*delta^(l1-1);
K_b = (1/2*l1 - 1/2)*delta^(l1-3);

K_0 = diag([3 3 3 0 0 0]); K_1 = diag([1 1 1 0 0 0]); K_2 = diag([1 1 1 0 0 0]);

phi_hat = zeros(1,length(time));

Sig_v1_S = zeros(6,length(time));
Sig_v2_S = zeros(6,length(time));

v3=5/4;  v1 = 1 - 1/v3;  v2= 1 +1/v3;

tau_fault = zeros(6,length(time));
tau = zeros(6,length(time));
%%
for i=1:length(time)

    M0 = p560.inertia(q(:,i)');
    C0 = p560.coriolis(q(:,i)',dq(:,i)');
    G0 = p560.gravload(q(:,i)');

    error(:,i) = -(q_desire(:,i) - q(:,i));
    error_dot(:,i) = -(dq_desire(:,i) - dq(:,i));

    for j = 1:6
        if abs(error(j,i)) >= sigma
            H(j,i) = abs(error(j,i))^l1*sign(error(j,i));
            H_dot(j,i) = l1 * abs(error(j,i))^(l1-1);
        else
            H(j,i) = K_a*abs(error(j,i))*sign(error(j,i)) + K_b*error(j,i)^3;
            H_dot(j,i) = K_a + 3*K_b*error(j,i)^2;
        end
        Sig_L2(j,i) = abs(error(j,i))^l2 * sign(error(j,i));
        Sig_L2_dot(j,i) = l2* abs(error(j,i))^(l2-1);
    end
    
    S(:,i) = error_dot(:,i) + L1*H(:,i) + L2 * Sig_L2(:,i);
    
    F(:,i) = dq_desire(:,i) -L1*H(:,i)-L2*Sig_L2(:,i);
    F_dot(:,i) = ddq_desire(:,i) - L1*H_dot(:,i) - L2*Sig_L2_dot(:,i);

    if i > 1
    phi_hat(i) = phi_hat(i-1) + delta*norm(S(:,i));
    end

    for j = 1:6
        Sig_v1_S(j,i) = abs(S(j,i)) ^ v1 * sign(S(j,i));
        Sig_v2_S(j,i) = abs(S(j,i)) ^ v2 * sign(S(j,i));
    end

    if i == 1
        fuzzy = fuzzy_compensator1();
    end
    input = [q(1:3,i);dq(1:3,i)];
    fuzzy = fuzzy.adapt(input,S(1:3,i));
    fuzzy_output1 = fuzzy.output(input);
    fuzzy_output1 = [fuzzy_output1;zeros(3,1)];

    u(:,i)= M0*F_dot(:,i) + C0*F(:,i)+ G0' + fuzzy_output1 - (W)*sign(S(:,i))-...
         K_0 * S(:,i) - K_1 * Sig_v1_S(:,i) - K_2 * Sig_v2_S(:,i);
    
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

error_AFFTSMC = error;
tau_AFFTSMC = tau;

save added_FTC2.mat
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
plot(time,-error(1,:))
title('关节误差1')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,2)
plot(time,-error(2,:))
title('关节误差2')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,3)
plot(time,-error(3,:))
title('关节误差3')
ylabel('广义坐标/rad')
xlabel('t/s')
figure(6)
subplot(3,1,1)
plot(time,-error_dot(1,:))
title('关节角速度误差1')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,2)
plot(time,-error_dot(2,:))
title('关节角速度误差2')
ylabel('广义坐标/rad')
xlabel('t/s')
subplot(3,1,3)
plot(time,-error_dot(3,:))
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

