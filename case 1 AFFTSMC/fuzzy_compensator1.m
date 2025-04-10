classdef fuzzy_compensator1
    %UNTITLED5 此处显示有关此类的摘要
    %   此处显示详细说明

    properties
        center
        cons
    end

    methods
        function obj = fuzzy_compensator1()
            %UNTITLED5 构造此类的实例
            %   此处显示详细说明
            obj.center=[-pi/3 -pi/6 0 pi/6 pi/3];
            obj.cons=zeros(5^6,3);
        end

        function [net_output,fs] = output(obj,input)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            fs=zeros(5^6,1);
            for num1=1:5
                for num2=1:5
                    for num3=1:5
                        for num4 = 1:5
                            for num5 = 1:5
                                for num6 = 1:5
                                    fs((num1-1)*5^5+(num2-1)*5^4+(num3-1)*5^3+(num4-1)*5^2+(num5-1)*5+num6)=...
                                        exp(-(input(1)-obj.center(num1))^2/2*(pi/6)^2)*exp(-(input(2)-obj.center(num2))^2/2*(pi/6)^2)*...
                                        exp(-(input(3)-obj.center(num3))^2/2*(pi/6)^2)*exp(-(input(4)-obj.center(num4))^2/2*(pi/6)^2)*...
                                        exp(-(input(5)-obj.center(num5))^2/2*(pi/6)^2)*exp(-(input(6)-obj.center(num6))^2/2*(pi/6)^2);
                                end
                            end
                        end
                    end
                end
            end
            net_output=obj.cons'*fs;
        end

        function [obj]=adapt(obj,input1,input2)
            dt=1e-3;
            gamma=5; 
            [~,fs] = output(obj,input1);
            dW=zeros(size(obj.cons));
            for i = 1:3
                dW(:,i) = -gamma*fs*input2(i);
            end
            obj.cons=obj.cons+dW*dt;
        end
    end
end