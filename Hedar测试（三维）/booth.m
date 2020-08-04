function y = booth(x)
% 最小值：1.2622e-29
% 变量取值：1           3

% Booth function 
% Matlab Code by A. Hedar (Sep. 29, 2005).
% The number of variables n = 2.
% 
y  = (x(1)+2*x(2)-7)^2+(2*x(1)+x(2)-5)^2;
