function f_value = PSO_Fun(fun, N , d, llimit, ulimit, vllimit, vulimit)
% 这也是一个测试算法。只是它不绘制图像。fun是测试函数；N是初始粒子的个数；d是测试的维数；
%   llimit和ulimit分别是粒子位置的上下限；vllimit和vulimit分别是粒子更新的速度上下限
%% clc;clear;close all; 作为有参函数的时候这一行代码是不可以的，因为传过来的参数也会被清除掉。
%% 初始化种群
% N = 500;                         % 初始种群个数
% d = 3;                          % 空间维数
% ger = 20000;                      % 最大迭代次数
max_ger = 20000;
limit = zeros(d,2);
for i = 1:d
    limit(i,:) = [llimit,ulimit];
end
%limit = [-10,10;-10, 10;-10,10;-10,10];                % 设置位置参数限制(矩阵的形式可以多维)
% 但是不知道这个速度为什么是这个，怎么得来的。以及下面的惯性权重、自我学习因子和群体学习因子
vlimit = zeros(d,2);
for i = 1:d
    vlimit(i,:) = [vllimit,vulimit];
end
% vlimit = [-1, 1;-1, 1;-1,1;-1,1];               % 设置速度限制
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
fxm = 1./zeros(N, 1);               % 每个个体的历史最佳适应度
fym = inf;                      % 种群历史最佳适应度

%% 粒子群工作
iter = 1;
times = 1; 
record = zeros(max_ger, 1);          % 记录器
f_value = zeros(max_ger,1);
while iter <= max_ger
    fx = [N,1];
    for i=1: N
        x0 = zeros(1,d);
        for j = 1:d
            x0(1,j) = x(i,j);
        end
        % x0 = [x(i,1) x(i,2) x(i,3) x(i,4)];
        fx(i, 1) = fun(x0);  % 其中x为一个点的集合
        f_value(iter,1) = fun(x0);
        iter = iter + 1;
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
    if times >= 180
        % 可用来记录过程中的个体值。
        times=0;
    end
    times=times+1;
end
% 图三的开始，它记录的是最大值的过程。
%figure(3);plot(record);title('收敛过程');
% 输出最小值和最小值点。
%disp(['最小值：',num2str(fym)]);
%disp(['变量取值：',num2str(ym)]);

end

