function [dydt] = command_filter(t,y,alpha1)
%command_filter 基于文中给出ode45的状态方程
% dydt=[dphi_11,dphi_12]
n=6; %机械臂关节数
lambda11=1; lambda12=4; lambda13=8; lambda14=24;
alpha=5/7; beta=5/3;
m11=alpha; n11=beta; m12=alpha/(2-alpha);  n12=2*beta-1;
dydt=zeros(2*n,1); 
dydt(1:n)=-lambda11*abs(y(1:n)-alpha1).^m11.*sign(y(1:n)-alpha1)-lambda12*abs(y(1:n)-alpha1).^n11.*sign(y(1:n)-alpha1)+y(n+1:2*n);
dydt(n+1:2*n)=-lambda13*abs(y(1:n)-alpha1).^m12.*sign(y(1:n)-alpha1)-lambda14*abs(y(1:n)-alpha1).^n12.*sign(y(1:n)-alpha1);
end