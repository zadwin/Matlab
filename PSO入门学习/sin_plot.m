clear;
clc;
x = -3*pi:0.1:3*pi;
y = sin(x);
plot(x,y,'r');%可以控制为线段的颜色，和实线虚线
title('y = sin(x)的图形');