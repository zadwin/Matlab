function [d] = mycat(t)
%ī����ñ��
x = (-t:0.5:t);
y = (-t:0.5:t);
[X,Y] = meshgrid(x,y);
%�����ȡ�Ķ���ֱ�Ӿ����ӦԪ�ؼ��㣬һ���Լ��㣬���������r���кܶ����
%espҲ��һ������
r = sqrt(X.^2+Y.^2) + eps;
Z = sin(r)./r;
surf(X,Y,Z);
title("ī����ñ��")
d = size(x,2) + size(y,2);
end

