function y = ackley(x)
% 最小值：2.4298e-11
% 变量取值：1.1723e-12  8.5099e-12

% Ackley function.
% Matlab Code by A. Hedar (Sep. 29, 2005).
% The number of variables n should be adjusted below.
% The default value of n =2.
% 
n = 2;
a = 20; b = 0.2; c = 2*pi;
s1 = 0; s2 = 0;
%% 方法一：是自己按照所学的改进的。主要就是直接通过矩阵的运算，更加便捷。
% 因为传过来的是一个cell（主要是因为要将x区分为两个矩阵，所以才这么封装的）
% 但是当提取的时候内部的矩阵也是cell类型，所以要将其转换类型。
% 对于cell取元素的方法要和矩阵相区分。cell要用{};而矩阵要用（）。
%for i=1:n
%   s1 = s1+[x{i}].^2;
%   s2 = s2+cos(c.*[x{i}]);
%end
%y = -a*exp(-b*sqrt(1/n.*s1))-exp(1/n.*s2)+a+exp(1);




%%  方法二（这是来自于下载的hedar测试函数代码）
% 这个方法是用于每次计算一个点的函数值（因为例如：x(i)^2是不能用于矩阵运算的）。具体的调用方法如下：双循环依次求函数值
% for i=1: 1001
%       j=1: 1001
%        z(i, j)=ackley(x)  其中x为一个点的集合
%%  正式代码
for i=1:n
   s1 = s1+x(i)^2;
   s2 = s2+cos(c*x(i));
end
y = -a*exp(-b*sqrt(1/n*s1))-exp(1/n*s2)+a+exp(1);
