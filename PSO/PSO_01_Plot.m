function [y_best_values] = PSO_01_Plot( fun, N, d, xllimit, xulimit, vllimit, vulimit)
% 输入参数：
% fun：是用来接受测试函数。
% N：是种群的粒子数量。
% d：是表示测试函数的维度。
% xllimit和xulimit分别表示位置参数的上下限，防止更新的时候粒子的位置越界。
% vllimit和vulimit分贝表示粒子更新是的速度参数的上下限，防止更新的速度太快或者太慢。

ger = 1;        % 记录计算次数
maxger = 20000; % 设置最大计算次数。
%% 对于粒子的每个维度生成位置和速度的上下限矩阵。
xlimit = 1./zeros(d,2);
vlimit = zeros(d,2);
for i = 1:d
    xlimit(i,:) = [xllimit xulimit];
    vlimit(i,:) = [vllimit vulimit];
end
%% 设置速度更新的常量。
c_1 = 0.8; % 惯性权重。
c_2 = 0.5; % 自我学习因子。
c_3 = 0.5; % 群体学习因子。
%% 初始化种群信息
% 初始化种群位置。
x = 1./zeros( N, d);
for i = 1:d
    x(:,i) = xlimit(i,1) + (xlimit(i,2) - xlimit(i,1))*rand( N, 1);
end
v = rand( N, d); % 初始化种群速度。
x_best = x;      % 初始化个体历史最佳位置。
y_best = 1./zeros(1,d); % 设置种群历史最佳位置。
x_best_f = 1./zeros(N,1); % 设置个体历史最佳适应值（函数值）,初始化为∞。
y_best_f = inf; % 设置种群历史最佳适应值（函数值）,初始化为无穷大。
fx = 1./zeros(N,1); % 用于接收计算出来的函数值。
x0 = 1./zeros(1,d); % 用于封装计算函数值的参数。
%% 绘制图片1：种群初始化图像。
% 原函数的绘制
figure(1);
% 图像是否有颜色，有时候是和取的坐标精度有关。
[x0_1,x0_2] = meshgrid(xllimit:0.1:xulimit); % 其中x_1和x_2是用来生成原函数图像的参数值。
node_num = (xulimit - xllimit)/0.1 + 1; % node_num是用来统计需要生成的点的数量。
y_0 = 1./zeros(node_num,node_num);  % y_0是用来存储原函数图像的函数值。
for i = 1:node_num
    for j = 1:node_num
        x0 = [x0_1(i,j) x0_2(i,j)];
        y_0(i,j) = fun(x0);
    end
end
mesh( x0_1, x0_2, y_0);
hold on;
% 种群粒子初始状态的绘制。
for i = 1:N
    for j = 1:d
        x0(1,j) = x(i,j);
    end
    fx(i,1) = fun(x0);   
end
plot3( x(:,1), x(:,2), fx, 'ro'); % 这里的三个矩阵一定是同型的。
hold on;
%% 图二的开始：种群粒子的变化状态
% 函数图像的绘制
figure(2);
mesh( x0_1, x0_2, y_0);
title("粒子状态变化");
hold on;
% 粒子状态的绘制。
plot3( x(:,1), x(:,2), fx, 'ro');
hold on;
%% 粒子群工作
times = 0; % 用于控制图像输出。
record = 1./zeros(maxger ,1); % 设置记录器，记录每次计算的函数值。更好的描述算法的运行效果。
index = 1;  % 用来计算迭代次数。
while ger <= maxger
    % 计算函数值。
    for i = 1:N
        for j = 1:d
            x0(1,j) = x(i,j);
        end
        fx(i,1) = fun(x0);
        record(ger) = fx(i,1);
        ger = ger + 1;
    end
    % 更新个体历史最佳。
    for i = 1:N
        if x_best_f(i) > fx(i)
           x_best_f(i) = fx(i);
           x_best(i,:) = x(i,:);
        end
    end
    % 更新种群历史最佳。
    if y_best_f > min(x_best_f)
        [y_best_f,min_index] = min(x_best_f);
        y_best = x(min_index,:);
    end
    % 记录最好值的变化历史。
    y_best_values(index,1) = y_best_f;
    index = index+1;
    % 速度的更新。其中repmat是复制y_best生成一个N*1的矩阵，用于正常计算。
    % 次数加了一个rand不知道是为什么。
    v = c_1 * v + c_2 * rand()* (x_best-x) + c_3 * rand() * (repmat(y_best,N,1) - x);
    % 防止速度越界。
    for i = 1:N
        for j = 1:d
            % 速度上界的比较。
            if v(i,j) > vlimit(j,2)
               v(i,j) = vlimit(j,2);
            end
            % 速度下界的比较。
            if v(i,j) < vlimit(j,1)
               v(i,j) = vlimit(j,1);
            end
        end
    end
    x = x + v;% 位置的更新
    % 防止粒子位置越界。
    for i = 1:N
        for j = 1:d
            % 速度上界的比较。
            if v(i,j) > xlimit(j,2)
               v(i,j) = xlimit(j,2);
            end
            % 速度下界的比较。
            if v(i,j) < xlimit(j,1)
               v(i,j) = xlimit(j,1);
            end
        end
    end
    
   if times > 20
      cla;    % cla命令会清楚所有的图像中设定的内容（恢复自动设定）。
      mesh(x0_1, x0_2, y_0);
      hold on;
      for i=1: N
          for j = 1:d
              x0(1,j) = x(i,j);
          end
          fx(i, 1) = fun(x0);  % 其中x为一个点的集合
      end
      plot3(x(:,1), x(:, 2), fx(:,1), 'ro');
      hold on;
      pause(0.2);
      times=0;
   end
   times = times + 1;
end
%% 绘制种群粒子收敛情况。
figure(3);
plot(y_best_values);
xlabel("迭代次数");
ylabel("最佳适应值");
title("函数收敛性");
hold on;
%% 绘制种群粒子的最终状态。
figure(4);
mesh(x0_1, x0_2, y_0);
hold on;
% 为什么最后所有的x变量都能到达最佳为位置（部分函数）
plot3(x(:,1), x(:,2), fx, 'ro');
title("最终状态");
hold on;
end



