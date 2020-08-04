function PSO_Fun_Plot(fun, N , d, llimit, ulimit, vllimit, vulimit)
% 这是一个有绘制功能的算法，其中，fun是测试函数；N是初始粒子的个数；d是测试的维数；
%   llimit和ulimit分别是粒子位置的上下限；vllimit和vulimit分别是粒子更新的速度上下限
%% 初始化种群
% N = 500;                         % 初始种群个数
% d = 3;                          % 空间维数
ger = 300;                      % 最大迭代次数 
limit = zeros(d,2)*NaN;         %可以将矩阵设置为空值。 
for i = 1:d
    limit(i,:) = [llimit,ulimit];
end
%% 初始状态图像的开始。
figure(1);
[x0_1, x0_2] = meshgrid(llimit:0.2:ulimit);
n_co = (ulimit-llimit)/0.2 + 1;
% 计算函数值,这里的y0只用于存储画图图像的函数值。
y0 = zeros(n_co, n_co);
for i = 1:n_co
    for j = 1:n_co
        x0 = [x0_1(i, j) x0_2(i, j)];   % 注意这里面是取x0的值。
        y0(i, j) = fun(x0);
    end
end
mesh(x0_1, x0_2, y0);
title("初始状态");
hold on;                                % 首先如果一个图形没有用hold on，但是下面又进行了绘制，怎会把之前的数据清理掉。

%limit = [-10,10;-10, 10;-10,10;-10,10];                % 设置位置参数限制(矩阵的形式可以多维)
% 但是不知道这个速度为什么是这个，怎么得来的。以及下面的惯性权重、自我学习因子和群体学习因子
vlimit = zeros(d,2);
for i = 1:d
    vlimit(i,:) = [vllimit,vulimit];    % 设置速度限制
end
% vlimit = [-1, 1;-1, 1;-1,1;-1,1];               % 设置速度限制
c_1 = 0.8;                        % 惯性权重
c_2 = 0.5;                       % 自我学习因子
c_3 = 0.5;                       % 群体学习因子 
for i = 1:d
    x(:,i) = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, 1);%初始种群的位置。这里会产生0-20的数，最后x就是一个500行2列的矩阵
end
v = rand(N, d);                  % 初始种群的速度
x0 = zeros(1, d);                % x0用于过度每次计算函数值的参数，大小为1*d
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置。整体最优就只存储一个。
% 最佳适应度应该就是值，最佳的函数值。
fx = zeros(N,1);                       % 用于存储每个个体的值,初始大小为N*1。
fxm = 1./zeros(N, 1);               % 每个个体的历史最佳适应度
fym = inf;                      % 种群历史最佳适应度
% 图一初始状态的延续
for i = 1:N
    for j = 1:d
        x0(1,j) = xm(i, j);      % 次此处是要先生成一个完整的x0点才进行下一步的计算函数值。
    end
    fx(i,1) = fun(x0);
end
plot3(xm(:,1) ,xm(:,2), fx(:,1), 'ro');  % 注意plot和plot3的区别。
saveas(gcf,'初始状态.jpg'); % 此函数用于保存绘制出来的图片，其中图像句柄figure_handle固定为gcf。并且会对原来同名的图像进行覆盖。
hold on;

% 图二的开始
figure(2);
mesh(x0_1, x0_2, y0);
title("状态位置变化");
hold on;
plot3(xm(:,1), xm(:,2), fx(:,1), 'ro'); % 初始的变化图
hold on;

%% 粒子群工作
iter = 1;
times = 1; 
record = zeros(ger, 1);          % 记录器
while iter <= ger
    for i=1: N
        for j = 1:d
            x0(1,j) = x(i,j);
        end
        % x0 = [x(i,1) x(i,2) x(i,3) x(i,4)];
        fx(i, 1) = fun(x0);  % 其中x为一个点的集合
    end
    for i = 1:N      
       if fxm(i) > fx(i)
           fxm(i) = fx(i);     % 更新个体历史最佳适应度
           xm(i,:) = x(i,:);   % 更新个体历史最佳位置
       end 
    end
    if fym > min(fxm)
       [fym, nmin] = min(fxm);   % 更新群体历史最佳适应度
       ym = xm(nmin, :);      % 更新群体历史最佳位置
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
            if  v(j,i)<vlimit(i,1)
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
                x(j,i) = limit(i,1);
            end
        end
    end
    record(iter) = fym;% 最小值记录，指的是最小的函数值（最小适应值）
    % 10秒中之后重新绘制一下算法值的状态变化。
    if times >= 10
        % 每迭代10次在图像中输出一下个体的位置。
        % 想要实现状态图，只能每次清楚后两个图像都画。
        cla;    % cla命令会清楚所有的图像中设定的内容（恢复自动设定）。
        mesh(x0_1, x0_2, y0);
        hold on;
        for i=1: N
            for j = 1:d
                x0(1,j) = x(i,j);
            end
            % x0 = [x(i,1) x(i,2) x(i,3) x(i,4)];
            fx(i, 1) = fun(x0);  % 其中x为一个点的集合
        end
        plot3(x(:,1), x(:, 2), fx(:,1), 'ro');
        hold on;
        if iter == 10
            saveas(gcf,'粒子工作中间状态(第10代).jpg');
        end
        pause(0.2);
        times=0;
    end
    iter = iter+1;
    times=times+1;
end
% 图三的开始，它记录的是最大值的过程。此处的plot相当于是按照数组下标进行绘制。
figure(3);plot(record);title('收敛过程');
saveas(gcf,'收敛过程.jpg');
hold on;

figure(4);
mesh(x0_1, x0_2, y0);
hold on;
% 为什么最后所有的x变量都能到达最佳为位置（部分函数）
plot3(x(:,1), x(:,2), fx(:,1), 'ro');
title("最终状态");
saveas(gcf,'最终状态.jpg');
hold on;

% 输出最小值和最小值点。
disp(['最小值：',num2str(fym)]);
disp(['变量取值：',num2str(ym)]);

end

