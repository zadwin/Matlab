function value = ackleyValue(x1,x2)
[X,Y] = meshgrid(x1,x2);
%这里采取的都是直接矩阵对应元素计算，一次性计算，所以这里的r是有很多个点
%esp也是一个常量
A=sqrt(X.^2+0.5*Y.^2);
B=cos(2*pi*X)+cos(2*pi*Y);
Z=-20*exp(-0.2*A)-exp(0.5*B)+20;
value = Z;