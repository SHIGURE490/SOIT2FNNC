function [q_output,dq_output] = simu_p560(p560,q,dq,tau,time)
%SIMUA 3自由度机械臂
%
%   此处显示详细说明
dt=5e-4; %仿真步长
global system

fic=[0.3*dq(1)+1.2*sin(2*q(1))+0.5*cos(dq(1))+randn;
       0.8*dq(2)+2.3*sin(2*q(2))-0.7*sin(dq(2))+randn;
       0.5*dq(3)-1.5*sin(3*q(3))+0.2*sin(dq(3))+randn;
       0;
       0;
       0];

disturbance=[3*sin(time)+4*cos(time);
    cos(time)^2-2*sin(time);
    sin(time)^2+3*cos(time);
    0;
    0;
    0];
if system==1 && time>=10
    phi=[6*sin(q(1)*q(2))+15*cos(q(1)*dq(2))+1;
        8*cos(q(1)*q(2))+13*sin(dq(1)*dq(2))+3;
        2*sin(q(2)*q(3))-19*sin(dq(2)*dq(3))+6;
        0;
        0;
        0];
    gamma=[1-exp(-10*(time-10));
           1-exp(-30*(time-10));
           1-exp(-16*(time-10));
           0;
           0;
           0];
elseif system==2 && time>=10
    phi=[2*cos(q(1)*q(2))-6*sin(q(1)*dq(2))+3;
        5*sin(q(1)*q(2))+9*cos(dq(1)*dq(2))-2;
        3*cos(q(2)*q(3))-7*sin(dq(2)*dq(3))+5;
        0;
        0;
        0];
    gamma=[1-exp(-20*(time-10));
           1-exp(-12*(time-10));
           1-exp(-25*(time-10));
           0;
           0;
           0];
else
    phi=zeros(6,1);
    gamma=zeros(6,1);
end

real_tau=tau-fic-disturbance-phi.*gamma;
ddq=p560.accel(q',dq',real_tau');
dq_output=ddq*dt+dq;
q_output=dq*dt+q;

end

