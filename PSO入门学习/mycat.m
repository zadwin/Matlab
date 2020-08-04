function [d] = mycat(t)
%墨西哥帽子
x = (-t:0.5:t);
y = (-t:0.5:t);
[X,Y] = meshgrid(x,y);
%这里采取的都是直接矩阵对应元素计算，一次性计算，所以这里的r是有很多个点
%esp也是一个常量
r = sqrt(X.^2+Y.^2) + eps;
Z = sin(r)./r;
surf(X,Y,Z);
title("墨西哥帽子")
d = size(x,2) + size(y,2);
end

