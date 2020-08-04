function plot_01()
%PLOT Summary of this function goes here
%   Detailed explanation goes here
f= @(a,b)(a .* sin(a) .* cos(2 * a) - 2 * a .* sin(3 * a)).*(b .* sin(b) .* cos(2 * b) - 2 * b .* sin(3 * b)); % 函数表达式
figure;
[x0_1, x0_2]=meshgrid(0:.2:20);
y0=f(x0_1,x0_2);
surf(x0_1,x0_2,y0);
title("绘图");
pause(3);
end

