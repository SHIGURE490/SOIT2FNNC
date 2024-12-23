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
            obj.center=[-3 -2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3];
            obj.cons=zeros(13^3,6);
        end

        function [net_output,fs] = output(obj,input)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            fs=zeros(13^3,1);
            for num1=1:13
                for num2=1:13
                    for num3=1:13
                        fs((num1-1)*13^2+(num2-1)*13+num3)=...
                            exp(-(input(1)-obj.center(num1))^2/2)*exp(-(input(2)-obj.center(num2))^2/2)*...
                            exp(-(input(3)-obj.center(num3))^2/2);

                    end
                end
            end
            net_output=obj.cons'*fs;
        end

        function [obj]=adapt(obj,input1,input2)
            dt=1e-3;
            gamma2=300; r2=0.5;
            [~,fs] = output(obj,input1);
            dW=zeros(size(obj.cons));
            dW = gamma2*fs*input2'-r2*obj.cons;
            obj.cons=obj.cons+dW*dt;
        end
    end
end