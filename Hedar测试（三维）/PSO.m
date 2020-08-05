function [his_run] = PSO(fun ,omega,phi,np,degree,D, LB, UB)
%  PSO程序，基于正则图拓扑
%  作者：刘群锋
%  2014.3.1
% =========================================
% 输入：
%  omega, phi ----- PSO参数
%  np ----- 粒子数
% degree --- 正则图的度数
%  D ----- 问题维数
%  FE_max, fun, LB, UB---函数值最大计算次数，问题标号，下界(行向量)，上界
%  x -------------- D*np矩阵，粒子的初始位置
%
%  输出：
%  his_run ----- 输出每次运行的最好函数值历史
%==========================================
%此处的值是什么？
global nfev maxnfev  % 函数值计算次数、最大函数值计算次数
nfev = 1;
maxnfev = 20000;
his_run = zeros(maxnfev,1); % 存储每次运行的最好函数值历史

%% ------------------初始化-----------------------
x = 1./zeros(D,np); % 记录粒子的初始位置
for i=1:np
    for j=1:D
        x(j,i) = LB(j) + rand()*(UB(j)-LB(j)); % 第i个粒子位置初值
    end
end
V = zeros(D,np);     % 记录np个粒子的速度
fbest_p = zeros(np,1); % np*1向量，记录每个粒子的最优适应值ksmnksmn
xbest_p = x;           % 记录每个粒子的个体最优位置
for i=1:np
    for j=1:D
        V(j,i) = LB(j)-x(j,i) + rand()*(UB(j)-LB(j)); % 第i个粒子速度初值
    end
    % 这里就不是很懂
    % X(2:4,[2 3 5])，表示的内容有两部分：行（2?4）和列（2、3、5）。
    fbest_p(i) = fun(x(:,i)'); % 计算每个粒子的初始适应值，并记录在fbest_p中,注意nfev已加1
    if nfev == 1
        his_run(nfev,1) = fbest_p(1);
    elseif fbest_p(i) < his_run(nfev-1,1)
        his_run(nfev,1) = fbest_p(i);
    else
        his_run(nfev,1) = his_run(nfev-1,1);
    end
    nfev = nfev+1;
end
xbest_n = findNbest(fbest_p,xbest_p,np,degree); % 确定每个粒子的邻域最优位置

%% -----------------主循环开始-------------------------
while nfev<maxnfev
    for i=1:np  % 对每一个粒子...
        for j=1:D % ...每一维，执行以下操作
            C1 = rand()*phi;
            C2 = rand()*phi;
            V(j,i) = omega * V(j,i) + C1 * ( xbest_p(j,i) - x(j,i) ) + C2 * ( xbest_n(j,i) - x(j,i) ); % 速度更新
            x(j,i) = x(j,i) + V(j,i);
        end
        fit = fun(x(:,i)'); % 计算新位置的适应值
        if nfev>maxnfev
            return;
        end
        if fit<his_run(nfev-1,1)
            his_run(nfev,1) = fit;
        else
            his_run(nfev,1) = his_run(nfev-1,1);
        end
        if fit<fbest_p(i) % 如果新位置的适应值更小，更新个体最优适应值和最优位置
            fbest_p(i)   = fit;
            xbest_p(:,i) = x(:,i);
        end
        nfev = nfev+1;
    end
    
    xbest_n = findNbest(fbest_p,xbest_p,np,degree); % 重新确定每个粒子的邻域最优位置
end
% ----------------主循环结束------------------------

figure(1);
plot(his_run);
%% 子函数
function xbest_n = findNbest(fbest_p,xbest_p,np,degree)
% 确定每个粒子的邻域最优位置
% fbest_p 为每个粒子的个体最优适应值
% xbest_p 为每个粒子的个体最优位置
% np 为粒子个数
% degree 为凯莱图拓扑中每个粒子的度数，degree = 2  对应lbest拓扑
%                                             np 对应gbest拓扑
% -----------------------------------------------------------
% np和degree需满足：凯莱图的组数 = np/(degree-1), degree-1 即是每组的粒子数 ?
% 可先确定每组粒子数，再确定需要多少组，np = 每组粒子数 * 组数 ?
% 另外，组数 > 度数 也就是 组数 > 每组粒子数+1 ？
% 常见（度数、组数、粒子数）组合：(3,10,20), (4,10,30), (5,6,24) ?
% 组数似乎不是凯莱图必须的要素，2014.3.2
% 另外，可能凯莱图不是统一lbest和gbest的最好框架？现在更倾向于先试试正则图。
% 凯莱图一定是正则图，反之则不一定。

if mod(np,2)==1 && mod(degree,2)==1
    fprintf('Either np or degree must be even !\n'); % np和degree至少有一个偶数，否则无法构造正则图
    xbest_n = [];    return;
end
if np<(degree+1)
    fprintf('np must greater than degree !\n'); % np要求大于degree，否则无法构造正则图
    xbest_n = [];    return;
end
xbest_n = zeros(size(xbest_p));

if mod(degree,2)==0 % 偶数度
    k = degree/2;
    for i=0:np-1 % 对每个粒子
        neighbour = mod(i-k:1:i+k,np)+1; % 确定其邻居，含自身
        % 把所有粒子编号围成一个圈，自身粒子两边各连接 k 个
        [~,index] = min(fbest_p(neighbour));
        index = neighbour(index); % 确定最优邻居，可能为自身
        xbest_n(:,i+1) = xbest_p(:,index); % 确定邻域最优位置
    end
else % 奇数度
    k = (degree-1)/2;
    nph = np/2; % 此时np一定是偶数
    for i =0:np-1 % 对每个粒子
        neighbour = [mod(i-k:1:i+k,np),mod(i+nph,np)]+1; % 确定其邻居，含自身
        % 把所有粒子编号围成一个圈，自身粒子两边各连接 k 个，同时连接正对面粒子i+nph
        [~,index] = min(fbest_p(neighbour));
        index = neighbour(index); % 确定最优邻居，可能为自身
        xbest_n(:,i+1) = xbest_p(:,index); % 确定邻域最优位置
    end
end
end
end