clear;% 清空工作空间。
clc;% 清空命令行。
A = magic(3);% 会生成一个3*3的随机矩阵，其中的每个元素值为1到3^2,且任何的行列值的和都相等。
disp(A);
B = magic(3);
disp(B);
C = A + B;
disp(C);

D = horzcat(A,B);% 矩阵左右合并。
E = vertcat(A,B);% 矩阵上下合并。