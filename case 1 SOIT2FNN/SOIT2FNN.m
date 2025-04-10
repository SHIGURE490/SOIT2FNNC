classdef SOIT2FNN
    %UNTITLED 此处显示有关此类的摘要
    % 用于自组织
    %   此处显示详细说明

    properties
        center
        upper_vari
        lower_vari
        upper_cons
        lower_cons
        BMM_para
        upper_mu
        lower_mu
        upper_firestrength
        lower_firestrength
        upper_firestrength_bar
        lower_firestrength_bar
        density
        gen_time
        alpha
    end

    methods
        function obj = SOIT2FNN(input)
            %UNTITLED 构造此类的实例
            %   此处显示详细说明
            input_dim=length(input);
            obj.center=input;
            obj.upper_vari=0.3*rand(input_dim,1)+0.3;
            obj.lower_vari=0.2*rand(input_dim,1)+0.2;
            % obj.upper_cons=zeros(1,1);
            % obj.lower_cons=zeros(1,1);
            obj.upper_cons=zeros(3,1);
            obj.lower_cons=zeros(3,1);
            obj.BMM_para=0.5;
            obj.upper_mu=zeros(input_dim,1);
            obj.lower_mu=zeros(input_dim,1);
            obj.upper_firestrength=zeros(1,1);
            obj.lower_firestrength=zeros(1,1);
            obj.upper_firestrength_bar=zeros(1,1);
            obj.lower_firestrength_bar=zeros(1,1);
            obj.density=1;
            obj.gen_time=1;
            obj.alpha=100;
        end

        function [obj,output] = net_output(obj,input)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            input_dim=size(obj.center,1);
            rule_num=size(obj.center,2);
            % layer 1
            for i=1:input_dim
                for j=1:rule_num
                    obj.upper_mu(i,j)=exp(-(input(i)-obj.center(i,j))^2/(2*obj.upper_vari(i,j)^2));
                    obj.lower_mu(i,j)=exp(-(input(i)-obj.center(i,j))^2/(2*obj.lower_vari(i,j)^2));
                end
            end
            % layer 2
            for j=1:rule_num
                obj.upper_firestrength(j)=prod(obj.upper_mu(:,j));
                obj.lower_firestrength(j)=prod(obj.lower_mu(:,j));
            end
            % layer 3
            for j=1:rule_num
                obj.upper_firestrength_bar(j)=obj.upper_firestrength(j)/sum(obj.upper_firestrength);
                obj.lower_firestrength_bar(j)=obj.lower_firestrength(j)/sum(obj.lower_firestrength);
            end
            % layer 4
            output=obj.BMM_para*(obj.upper_cons*obj.upper_firestrength_bar)+(1-obj.BMM_para)*(obj.lower_cons*obj.lower_firestrength_bar);
        end

        function [obj]=self_organize(obj,input,tau_c,time)

            input_dim=size(obj.center,1);
            % output_dim=1;
            rule_num=size(obj.center,2);

            k_m=1; k_d=2; k_l=1;          
            M_distance_upper=zeros(rule_num,1);          %马氏距离度量
            M_distance_lower=zeros(rule_num,1);
            for j=1:rule_num
                M_distance_upper(j)=sqrt((input-obj.center(:,j))'*inv(diag([obj.upper_vari(:,j)]))*(input-obj.center(:,j)));
                M_distance_lower(j)=sqrt((input-obj.center(:,j))'*inv(diag([obj.lower_vari(:,j)]))*(input-obj.center(:,j)));
            end                                           %分别求上下马氏距离

            weighted_M_distance=obj.BMM_para*M_distance_upper+(1-obj.BMM_para)*M_distance_lower;

            [min_weighted_M_distance,~]=min(weighted_M_distance);

            weighted_fs=obj.BMM_para*obj.upper_firestrength+(1-obj.BMM_para)*obj.lower_firestrength;
            [max_weighted_fs,~]=max(weighted_fs);
            f_th=0.1;

            if min_weighted_M_distance>k_d+(k_m-k_d)*exp(-norm(tau_c)) ||  max_weighted_fs<=f_th
                %若归一化马氏距离大于一定值，则生成规则
                Euler_distance=zeros(input_dim,rule_num);     %计算样本到模糊集的距离
                min_Euler_distance=zeros(input_dim,1);        %用于记载最小模糊集距离
                weighted_vari=obj.BMM_para*obj.upper_vari+(1-obj.BMM_para)*obj.lower_vari;
                for i=1:input_dim
                    for j=1:rule_num
                        Euler_distance(i,j)=abs(input(i)-obj.center(i,j));
                    end
                    [min_Euler_distance(i),Euler_index]=min(Euler_distance(i,:));
                    if min_Euler_distance(i)>k_l*weighted_vari(i,Euler_index)   %若该点落于对应模糊集之外
                        obj.center(i,rule_num+1)=input(i);
                        % if input(i)>max(obj.center(i,1:rule_num)) || input(i)<min(obj.center(i,1:rule_num)) %若新建模糊集为边缘模糊集
                        %     obj.upper_vari(i,rule_num+1)=obj.upper_vari(i,rule_num); %
                        %     obj.lower_vari(i,rule_num+1)=obj.lower_vari(i,rule_num); %若为边缘模糊集则自组织模糊集方差不变
                        % else
                        %     obj.upper_vari(i,rule_num+1)=obj.upper_vari(i,rule_num)/rule_num*(rule_num-1);
                        %     obj.lower_vari(i,rule_num+1)=obj.lower_vari(i,rule_num)/rule_num*(rule_num-1);
                        % end
                        obj.upper_vari(i,rule_num+1)=obj.upper_vari(i,Euler_index);
                        obj.lower_vari(i,rule_num+1)=obj.lower_vari(i,Euler_index);       %若落于模糊集之内则直接使用该模糊集
                    else
                        obj.center(i,rule_num+1)=obj.center(i,Euler_index);
                        obj.upper_vari(i,rule_num+1)=obj.upper_vari(i,Euler_index);
                        obj.lower_vari(i,rule_num+1)=obj.lower_vari(i,Euler_index);       %若落于模糊集之内则直接使用该模糊集
                    end
                end
                % obj.upper_cons(rule_num+1)=zeros(1,1);            %matlab优先生成行向量
                % obj.lower_cons(rule_num+1)=zeros(1,1);
                obj.upper_cons(:,rule_num+1)=zeros(3,1);            %matlab优先生成行向量
                obj.lower_cons(:,rule_num+1)=zeros(3,1);
                obj.upper_mu(:,rule_num+1)=zeros(input_dim,1);
                obj.lower_mu(:,rule_num+1)=zeros(input_dim,1);
                obj.upper_firestrength=[obj.upper_firestrength;zeros(1,1)];
                obj.lower_firestrength=[obj.lower_firestrength;zeros(1,1)];
                obj.upper_firestrength_bar=[obj.upper_firestrength_bar;zeros(1,1)];
                obj.lower_firestrength_bar=[obj.lower_firestrength_bar;zeros(1,1)];
                obj.density(rule_num+1)=1;
                obj.gen_time(rule_num+1)=time;
            else
                gamma_density=0.05;           delta_t=50;                                  %不重要的规则阈值
                [obj,~] = net_output(obj,input);
                weighted_fs=obj.BMM_para*obj.upper_firestrength+(1-obj.BMM_para)*obj.lower_firestrength;
                [~,winning_rule_index]=max(weighted_fs);
                obj.density(winning_rule_index)=obj.density(winning_rule_index)+1;
                unimportant_rule_idx=[];                                    %记录不重要的规则索引
                for j=1:rule_num
                    if obj.density(j)/(time-obj.gen_time(j))<gamma_density       
                        unimportant_rule_idx=[unimportant_rule_idx;j];
                    end
                end
                if mod(time,delta_t)==0
                    [~,delete_un_idx]=min(weighted_fs(unimportant_rule_idx));
                    %删除不重要的规则中当前加权激活强度最小者
                    delete_idx=unimportant_rule_idx(delete_un_idx);
                    if isempty(delete_idx)~=1
                        for i=1:input_dim
                            if obj.center(i,delete_idx)<max(obj.center(i,:)) && obj.center(i,delete_idx)>min(obj.center(i,:))
                                obj.upper_vari(i,:)=obj.upper_vari(i,:)*(rule_num-1)/(rule_num-2);
                                obj.lower_vari(i,:)=obj.lower_vari(i,:)*(rule_num-1)/(rule_num-2);
                            end
                        end
                        obj.center(:,delete_idx)=[];
                        obj.upper_vari(:,delete_idx)=[];
                        obj.lower_vari(:,delete_idx)=[];
                        obj.upper_cons(:,delete_idx)=[];
                        obj.lower_cons(:,delete_idx)=[];
                        obj.upper_mu(:,delete_idx)=[];
                        obj.lower_mu(:,delete_idx)=[];
                        obj.upper_firestrength(delete_idx)=[];
                        obj.lower_firestrength(delete_idx)=[];
                        obj.upper_firestrength_bar(delete_idx)=[];
                        obj.lower_firestrength_bar(delete_idx)=[];
                        obj.density(delete_idx)=[];
                        obj.gen_time(delete_idx)=[];
                    end
                end
            end
        end

        function [obj]=adapt(obj,input,tau_c)
            dt=1e-3;   
            Ts=0.5; gamma=0.8; gamma0=10; nv=10;
            [obj,~]=net_output(obj,input);
            rule_num=size(obj.center,2);
            % dcons=diag([1000,1000,1000])*tau_c/(norm(tau_c)^2+0.01)*obj.firestrength_bar'/(norm(obj.firestrength_bar)^2);
            cons_vector=zeros(3,2*rule_num);
            var_fs_vector=zeros(2*rule_num,1);
            var_fs_vector(1:rule_num)=obj.BMM_para*obj.upper_firestrength_bar;
            var_fs_vector(rule_num+1:end)=(1-obj.BMM_para)*obj.lower_firestrength_bar;
            obj.alpha=obj.alpha+dt*(gamma0*norm(tau_c)-gamma0*nv*obj.alpha);
            % cons_vector=alpha*tau_c/(abs(tau_c)+0.01)*var_fs_vector'/(norm(var_fs_vector)^2)+...
            %             1/(Ts*gamma)*(tau_c+2^(gamma/2)*abs(tau_c)^(-gamma/2)*sign(tau_c)+(1/2)^(gamma/2)*abs(tau_c)^(gamma/2)*sign(tau_c))*var_fs_vector'/(norm(var_fs_vector)^2);
            cons_vector=obj.alpha*tau_c/(norm(tau_c)+0.01)*var_fs_vector'/(norm(var_fs_vector)^2)+...
                1/(Ts*gamma)*(tau_c+2^(gamma/2)*abs(tau_c).^(-gamma).*sign(tau_c)+(1/2)^(gamma/2)*abs(tau_c).^(gamma).*sign(tau_c))*var_fs_vector'/(norm(var_fs_vector)^2);
            % cons_vector=alpha*tau_c/(abs(tau_c)+0.01)*var_fs_vector'/(norm(var_fs_vector)^2);
            obj.upper_cons=cons_vector(:,1:rule_num)*dt+obj.upper_cons;
            obj.lower_cons=cons_vector(:,rule_num+1:end)*dt+obj.lower_cons;
        end
    end
end