function [tau_fault] = fault_(u,time)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
global system
if system==1 && time>=4
    var_epsilon=0.2*sin(time)+0.5;
    delta=0.3;
    tau_fault=var_epsilon*u+delta;
elseif system==2 && time>=4
    var_epsilon=0.3;
    delta=0.8;
    tau_fault=var_epsilon*u+delta;
else
    tau_fault=u;
end
end