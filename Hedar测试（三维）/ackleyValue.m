function value = ackleyValue(x1,x2)
[X,Y] = meshgrid(x1,x2);
%�����ȡ�Ķ���ֱ�Ӿ����ӦԪ�ؼ��㣬һ���Լ��㣬���������r���кܶ����
%espҲ��һ������
A=sqrt(X.^2+0.5*Y.^2);
B=cos(2*pi*X)+cos(2*pi*Y);
Z=-20*exp(-0.2*A)-exp(0.5*B)+20;
value = Z;