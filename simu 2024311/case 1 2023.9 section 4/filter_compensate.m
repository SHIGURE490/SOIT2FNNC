function [dydt] = filter_compensate(t,y,w1,z1)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
k4=10; k5=10; k6=10;
alpha=5/7; beta=5/3;
f1=(abs(w1'*z1)+k6/2*w1'*w1)/(norm(y)^2+0.001);
dydt=zeros(6,1);
dydt=-k4*y-k5*abs(y).^alpha.*sign(y)-k6*abs(y).^beta.*sign(y)-f1*y+w1;
end