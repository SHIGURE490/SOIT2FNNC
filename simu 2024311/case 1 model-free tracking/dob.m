classdef dob
    %UNTITLED5 此处显示有关此类的摘要
    %   此处显示详细说明

    properties
        dob_value
    end

    methods
        function obj = dob()
            %UNTITLED5 构造此类的实例
            %   此处显示详细说明
            obj.dob_value=zeros(3,1);
        end

        function obj = adapt(obj,s1,z2)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            dt=5e-4;
            gamma1=2; k2=30; p=13; q_b=11; delta1=20;
            d_hat_dt=zeros(3,1);
            for j=1:3
                d_hat_dt(j)=gamma1*(s1(j)*k2*p/q_b*abs(z2(j))^((p-q_b)-1)-...
                    delta1*obj.dob_value(j));
            end
            obj.dob_value=obj.dob_value+dt*d_hat_dt;
        end
    end
end