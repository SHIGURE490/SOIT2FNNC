classdef RBFNN
    %UNTITLED4 此处显示有关此类的摘要
    %   此处显示详细说明

    properties
        center
        cons
    end

    methods
        function obj = RBFNN()
            %UNTITLED4 构造此类的实例
            %   此处显示详细说明
            obj.center=[-12 -9 -6 -3 0 3 6 9 12];
            obj.cons=zeros(9^3,3);
        end

        function [net_output,fs] = output(obj,input)
            %METHOD1 此处显示有关此方法的摘要
            % input 为s1
            %   此处显示详细说明
            fs=zeros(9^3,1);
            for num1=1:9
                for num2=1:9
                    for num3=1:9
                        fs((num1-1)*9^2+(num2-1)*9+num3)=exp(-(input(1)-obj.center(num1))^2/9)*...
                            exp(-(input(2)-obj.center(num2))^2/9)*exp(-(input(3)-obj.center(num3))^2/9);
                    end
                end
            end
            net_output=obj.cons'*fs;
        end

        function obj=adapt(obj,input) 
            gamma2=200; p=13; q_b=11;
            dt=5e-4; delta2=0.2;
            k2=10;
            [~,fs] = output(obj,input);
            dW=zeros(9^3,3);
            dW(:,1)=10*(input(1)*k2*p/q_b*fs-delta2*obj.cons(:,1));
            dW(:,2)=10*(input(2)*k2*p/q_b*fs-delta2*obj.cons(:,2));
            dW(:,3)=10*(input(3)*k2*p/q_b*fs-delta2*obj.cons(:,3));
            obj.cons=obj.cons+dW*dt;
        end
    end
end