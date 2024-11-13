clear all;
close all;
clc;
%%
x=0.5; x_last=0.5;
count = 0;
while(abs(x^3+log(x))>=1e-6 && count<100)
    diff = 3*x^2+1/x;
    x_last = x;
    x = x - (x^3+log(x))/diff;
    count = count + 1;
end




