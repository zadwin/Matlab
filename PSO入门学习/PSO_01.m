function PSO_01()
% 最大值：1162.5609
% PSO_01 Summary of this function goes here
%   Detailed explanation goes here
clc;clear;close all;
%% 初始化种群
f= @(a,b)(a .* sin(a) .* cos(2 * a) - 2 * a .* sin(3 * a)).*(b .* sin(b) .* cos(2 * b) - 2 * b .* sin(3 * b)); % 函数表达式
% figure（1）与figure的作用一样，建立一个新的图形
figure(1);
% meshgrid是MATLAB中用于生成网格采样点的函数。
% 下面这个就是生成一个坐标平面 从0开始到20结束，单位间隔0.2，生成x、y的点
[x0_1, x0_2]=meshgrid(0:.2:20);
y0=f(x0_1,x0_2);
% plot、plot3、surf和mesh都是绘图的函数。
% mesh（）用于绘制不是特别精细的三维曲面网格图。surf（）用于绘制比较光滑的三维曲面网格图。
% 图一的开始
mesh(x0_1, x0_2, y0);
hold on;

N = 500;                         % 初始种群个数
d = 2;                          % 空间维数
ger = 300;                      % 最大迭代次数     
limit = [0, 20;0,20];                % 设置位置参数限制(矩阵的形式可以多维)
% 但是不知道这个速度为什么是这个，怎么得来的。以及下面的惯性权重、自我学习因子和群体学习因子
vlimit = [-1.5, 1.5;-1.5, 1.5];               % 设置速度限制
c_1 = 0.8;                        % 惯性权重
c_2 = 0.5;                       % 自我学习因子
c_3 = 0.5;                       % 群体学习因子 
for i = 1:d
    x(:,i) = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, 1);%初始种群的位置。这里会产生0-20的数，最后x就是一个500行2列的矩阵
end    
v = rand(N, d);                  % 初始种群的速度
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置。整体最优就只存储一个。
% 最佳适应度应该就是值，最佳的函数值。
fxm = zeros(N, 1);               % 每个个体的历史最佳适应度
fym = -inf;                      % 种群历史最佳适应度

% 其中的xm(:,1)、xm(:,2)相当于函数的参数x、y。
plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'ro');title('初始状态图');
hold on;
figure(2);
% 图二的开始
mesh(x0_1, x0_2, y0);
hold on;
plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'ro');
hold on;
%% 粒子群工作
iter = 1;
times = 1; 
record = zeros(ger, 1);          % 记录器
while iter <= ger
    fx = f(x(:,1),x(:,2)) ; % 个体当前适应度
    % disp(fx');    % 输出每个迭代次数的个体的值。
    for i = 1:N      
       if fxm(i) < fx(i)
           fxm(i) = fx(i);     % 更新个体历史最佳适应度
           xm(i,:) = x(i,:);   % 更新个体历史最佳位置
       end 
    end
    if fym < max(fxm)
       [fym, nmax] = max(fxm);   % 更新群体历史最佳适应度
       ym = xm(nmax, :);      % 更新群体历史最佳位置
    end
    % 这里第一次的速度是随机生成的。repmat（1:10,40,1）就是对一行数1，2，....，10值重复排列成40*1的矩阵.
    % 此处的repmat(ym, N, 1)是对ym一个1行2列的矩阵进行排列，把一行当成一个元素。
    v = v * c_1 + c_2 * rand *(xm - x) + c_3 * rand *(repmat(ym, N, 1) - x);% 速度更新
    % 边界速度处理，防止速度越界。
    for i=1:d 
        for j=1:N
        if  v(j,i)>vlimit(i,2)
            v(j,i)=vlimit(i,2);
        end
        if  v(j,i) < vlimit(i,1)
            v(j,i)=vlimit(i,1);
        end
        end
    end       
    x = x + v;% 位置更新
    % 边界位置处理,防止位置出界，防止超出函数的变量取值范围。
    for i=1:d 
        for j=1:N
        if  x(j,i)>limit(i,2)
            x(j,i)=limit(i,2);
        end
        if  x(j,i) < limit(i,1)
            x(j,i)=limit(i,1);
        end
        end
    end
    record(iter) = fym;% 最大值记录，指的是最大的函数值（最大适应值）
    % 10秒中之后重新绘制一下算法值的状态变化。
    if times >= 10
        % cla(),Clear
        % axis即清除当前图形中的当前活动轴。其他轴不受影响。它会清除所有的绘制的图像，但窗口依然保留，可以重新绘制
        cla;
        mesh(x0_1, x0_2, y0);
        plot3(x(:,1),x(:,2),f(x(:,1),x(:,2)), 'ro');title('状态位置变化');
        pause(0.1);
        times=0;
    end
    iter = iter+1;
    times=times+1;
end
% 图三的开始，它记录的是最大值的过程。
figure(3);plot(record);title('收敛过程');
% 图四开始的过程，记录最终的位置，相当于每个个体最后都达到了最优位置。
figure(4);
mesh(x0_1, x0_2, y0);
hold on;
plot3(x(:,1),x(:,2),f(x(:,1),x(:,2)), 'ro');title('最终状态图');

disp(['最大值：',num2str(fym)]);
disp(['变量取值：',num2str(ym)]);

end

