function [tao]=saturation_p560(u,u_max)
%u为列向量,u_max也为列向量
for i=1:length(u)
    if u(i)>=u_max(i)
        tao(i)=u_max(i)*sign(u(i));
    elseif u(i)<=-u_max(i)
        tao(i)=u_max(i)*sign(u(i));
    else
        tao(i)=u(i);
    end
end
end