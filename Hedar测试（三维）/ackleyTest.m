clear;
clc;
x1 = (-30:0.5:30);
x2 = (-30:0.5:30);
[X1,X2] = meshgrid(x1,x2);  % 这里就是用于生成了两个矩阵，一个是x，一个是y，同阶。
                                % 并且恰好同时从x，y中取一个值是代表一个点，用于代入函数求值。
%x{1} = X1;  % 这里用的是集合cell。
%x{2} = X2;
%Z = ackley(x);
Z = [121,121];
for i=1: 121
    for j=1: 121
        x = [X1(i,j) X2(i,j)];
        Z(i, j) = ackley(x);  % 其中x为一个点的集合
    end
end
  
mesh(X1,X2,Z);
title("Ackley三维图像");