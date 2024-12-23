classdef fuzzy_compensator
    %UNTITLED5 此处显示有关此类的摘要
    %   此处显示详细说明

    properties
        center
        cons
    end

    methods
        function obj = fuzzy_compensator()
            %UNTITLED5 构造此类的实例
            %   此处显示详细说明
            obj.center=[-7 -5 -3 -1 0 1 3 5 7];
            obj.cons=zeros(9^3,3);
        end

        function [net_output,fs] = output(obj,input)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            fs=zeros(9^3,1);
            for num1=1:9
                for num2=1:9
                    for num3=1:9
                        fs((num1-1)*9^2+(num2-1)*9+num3)=...
                            exp(-(input(1)-obj.center(num1))^2/4)*exp(-(input(2)-obj.center(num2))^2/4)*...
                            exp(-(input(3)-obj.center(num3))^2/4);
                    end
                end
            end
            net_output=obj.cons'*fs;
        end

        function [obj]=adapt(obj,input)
            dt=1e-3;
            alpha=5/7; beta=5/3;
            w11=0; w22=0;
            [~,phi_z] = output(obj,input);
            dW=zeros(size(obj.cons));
            for j=1:3
                dW(:,j)=100*input(j)*phi_z-w11*abs(obj.cons(:,j)).^alpha.*sign(obj.cons(:,j))-...
                    w22*abs(obj.cons(:,j)).^beta.*sign(obj.cons(:,j));
            end
            obj.cons=obj.cons+dW*dt;
        end
    end
end