function hl = data_profile(H,N,gate)
%   其中 H 是一个测试函数的值的集合，是一个三维矩阵，矩阵的大小是 nf*np*ns ，其中nf是可以理解为计算次数，一般为20000次。
%   np是可以理解为问题的个数，函数的个数。
%   ns是可以理解为算法的个数。
%   并且函数里面的值都是一个算法，在每个问题中计算50次的函数值的平均值。


% data_profile(H1,ones(50,1),1); 执行代码；问题：N和gate是什么？cutoff又是什么？
%     This subroutine produces a data profile as described in:
%
%     Benchmarking Derivative-Free Optimization Algorithms
%     Jorge J. More' and Stefan M. Wild
%     SIAM J. Optimization, Vol. 20 (1), pp.172-191, 2009.
%
%     The latest version of this subroutine is always available at
%     http://www.mcs.anl.gov/~more/dfo/
%     The authors would appreciate feedback and experiences from numerical
%     studies conducted using this subroutine.
%
%     The subroutine returns a handle to lines in a data profile.
%
%       H contains a three dimensional array of function values.
%         H(f,p,s) = function value # f for problem p and solver s.
%       N is an np-by-1 vector of (positive) budget units. If simplex
%         gradients are desired, then N(p) would be n(p)+1, where n(p) is
%         the number of variables for problem p.
%       gate is a positive constant reflecting the convergence tolerance.
%
%     Argonne National Laboratory
%     Jorge More' and Stefan Wild. January 2008.

% 这里是针对一个算法来说的，其中 nf是一个表示一个函数的计算次数， np是值问题的个数，ns是指算法的个数。
[nf,np,ns] = size(H); % Grab the dimensions

% Produce a suitable history array with sorted entries:
% 主要是产生一个行递减的数组的值，因为每次都是和前一个比较，虽然会有重复的值，但是正在进行比较的位置一定是小于等于，之前最好的值。
% 可以理解为记录目前为止最优解。用于计算哪一次达到"解出"的条件
for j = 1:ns
    for i = 2:nf
      H(i,:,j) = min(H(i,:,j),H(i-1,:,j));% 一个排序的过成。但是为什么要排序？，这里是因为它只是与前面一个进行比较生选择最小的值，因为只要有最小的，后面的就不需要了。相当于就是记录整个过程中，第一个满足式子的值，而不是一个排序的过程。
    end
end

% 记录每个问题的全局最优。min(H)是产生一个每一页的每一行的最小值，min(min(H),[],3)将会产生一个一页一行的数组，且为最小。
prob_min = min(min(H),[],3);   % The global minimum for each problem
prob_max = H(1,:,1);           % The starting value for each problem

% For each problem and solver, determine the number of
% N-function bundles (e.g.- gradients) required to reach the cutoff value
% 求解每个算法对于每个问题达到满足"解出"条件的迭代次数。比如算法一在满足"解出"条件需要迭代50，此时T(np,ns)的值即为50。
T = zeros(np,ns);
for p = 1:np
    % 满足的的最大值
    cutoff = prob_min(p) + gate*(prob_max(p) - prob_min(p));
    for s = 1:ns
        % find(A):返回矩阵A中非0元素所在位置。find(A>5):返回矩阵A中大于5的元素所在位置。[i,j,v]=find(A)返回矩阵A中非0元素所在的行、列、值。
        % find(A>m,4) 返回矩阵A中前四个大于m的元素的所有下标值。
        nfevs = find(H(:,p,s) <= cutoff,1);
        if (isempty(nfevs))
            T(p,s) = NaN;% 如果没有找到合适的值满足解出条件，则将计算成本设置为∞。
        else
            T(p,s) = nfevs/N(p);% 找到了则，将计算次数除以测试问题的维数。
        end
    end
end

% Other colors, lines, and markers are easily possible:
% 设置线条和标记的信息。
colors  = ['b' 'r' 'k' 'm' 'c' 'g' 'y'];   lines   = {'-' '-.' '--'};
markers = [ 's' 'o' '^' 'v' 'p' '<' 'x' 'h' '+' 'd' '*' '<' ];

% Replace all NaN's with twice the max_ratio and sort.
max_data = max(max(T));% 找出这个矩阵中的最大元素值，将它赋值给那些计算成本∞的测试函数
T(isnan(T)) = 2*max_data;
% sort(A,dim,mode)，dim表示按照指定的方向进行升序排列。mode表示升序还是降序。（ascend、descned）
% 下面的排序是为了使得成本依次上升，一个成本代表解出了一个问题。这样以此类推。到达最高成本的时候就可以知道总共解决的问题有多少。
T = sort(T);% sort(T)排序是从小到大的排序。对每一列分别进行排序，此时当时处于同行的元素也会被打乱。

% For each solver, plot stair graphs with markers.
hl = zeros(ns,1);
for s = 1:ns
    % 它产生的因为是阶梯状的，所以有的元素会产生两个值，依次错开。
    [xs,ys] = stairs(T(:,s),(1:np)/np);% （1:np)/np是表示y轴。因为stair中的两个矩阵的维数是一样的，所以是一个值对应一个值。可以理解为第一计算成本表示计算出一个问题，第二个计算成本表示计算出第二个问题。以此类推。
    sl = mod(s-1,3) + 1; sc = mod(s-1,7) + 1; sm = mod(s-1,12) + 1;
    option1 = [char(lines(sl)) colors(sc) markers(sm)];
    
    hl(s) = plot(xs,ys,option1);
    hold on;
end
xlabel('函数值计算次数/维数');
ylabel('求解出的问题比例');
% Axis properties are set so that failures are not shown, but with the
% max_ratio data points shown. This highlights the "flatline" effect.
axis([0 1.1*max_data 0 1]);% 这个是设置坐标轴的指定区间。
