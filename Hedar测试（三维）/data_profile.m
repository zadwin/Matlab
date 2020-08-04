function hl = data_profile(H,N,gate)
%   ���� H ��һ�����Ժ�����ֵ�ļ��ϣ���һ����ά���󣬾���Ĵ�С�� nf*np*ns ������nf�ǿ������Ϊ���������һ��Ϊ20000�Ρ�
%   np�ǿ������Ϊ����ĸ����������ĸ�����
%   ns�ǿ������Ϊ�㷨�ĸ�����
%   ���Һ��������ֵ����һ���㷨����ÿ�������м���50�εĺ���ֵ��ƽ��ֵ��


% data_profile(H1,ones(50,1),1); ִ�д��룻���⣺N��gate��ʲô��cutoff����ʲô��
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

% ���������һ���㷨��˵�ģ����� nf��һ����ʾһ�������ļ�������� np��ֵ����ĸ�����ns��ָ�㷨�ĸ�����
[nf,np,ns] = size(H); % Grab the dimensions

% Produce a suitable history array with sorted entries:
% ��Ҫ�ǲ���һ���еݼ��������ֵ����Ϊÿ�ζ��Ǻ�ǰһ���Ƚϣ���Ȼ�����ظ���ֵ���������ڽ��бȽϵ�λ��һ����С�ڵ��ڣ�֮ǰ��õ�ֵ��
% �������Ϊ��¼ĿǰΪֹ���Ž⡣���ڼ�����һ�δﵽ"���"������
for j = 1:ns
    for i = 2:nf
      H(i,:,j) = min(H(i,:,j),H(i-1,:,j));% һ������Ĺ��ɡ�����ΪʲôҪ���򣿣���������Ϊ��ֻ����ǰ��һ�����бȽ���ѡ����С��ֵ����ΪֻҪ����С�ģ�����ľͲ���Ҫ�ˡ��൱�ھ��Ǽ�¼���������У���һ������ʽ�ӵ�ֵ��������һ������Ĺ��̡�
    end
end

% ��¼ÿ�������ȫ�����š�min(H)�ǲ���һ��ÿһҳ��ÿһ�е���Сֵ��min(min(H),[],3)�������һ��һҳһ�е����飬��Ϊ��С��
prob_min = min(min(H),[],3);   % The global minimum for each problem
prob_max = H(1,:,1);           % The starting value for each problem

% For each problem and solver, determine the number of
% N-function bundles (e.g.- gradients) required to reach the cutoff value
% ���ÿ���㷨����ÿ������ﵽ����"���"�����ĵ��������������㷨һ������"���"������Ҫ����50����ʱT(np,ns)��ֵ��Ϊ50��
T = zeros(np,ns);
for p = 1:np
    % ����ĵ����ֵ
    cutoff = prob_min(p) + gate*(prob_max(p) - prob_min(p));
    for s = 1:ns
        % find(A):���ؾ���A�з�0Ԫ������λ�á�find(A>5):���ؾ���A�д���5��Ԫ������λ�á�[i,j,v]=find(A)���ؾ���A�з�0Ԫ�����ڵ��С��С�ֵ��
        % find(A>m,4) ���ؾ���A��ǰ�ĸ�����m��Ԫ�ص������±�ֵ��
        nfevs = find(H(:,p,s) <= cutoff,1);
        if (isempty(nfevs))
            T(p,s) = NaN;% ���û���ҵ����ʵ�ֵ�������������򽫼���ɱ�����Ϊ�ޡ�
        else
            T(p,s) = nfevs/N(p);% �ҵ����򣬽�����������Բ��������ά����
        end
    end
end

% Other colors, lines, and markers are easily possible:
% ���������ͱ�ǵ���Ϣ��
colors  = ['b' 'r' 'k' 'm' 'c' 'g' 'y'];   lines   = {'-' '-.' '--'};
markers = [ 's' 'o' '^' 'v' 'p' '<' 'x' 'h' '+' 'd' '*' '<' ];

% Replace all NaN's with twice the max_ratio and sort.
max_data = max(max(T));% �ҳ���������е����Ԫ��ֵ��������ֵ����Щ����ɱ��޵Ĳ��Ժ���
T(isnan(T)) = 2*max_data;
% sort(A,dim,mode)��dim��ʾ����ָ���ķ�������������С�mode��ʾ�����ǽ��򡣣�ascend��descned��
% �����������Ϊ��ʹ�óɱ�����������һ���ɱ���������һ�����⡣�����Դ����ơ�������߳ɱ���ʱ��Ϳ���֪���ܹ�����������ж��١�
T = sort(T);% sort(T)�����Ǵ�С��������򡣶�ÿһ�зֱ�������򣬴�ʱ��ʱ����ͬ�е�Ԫ��Ҳ�ᱻ���ҡ�

% For each solver, plot stair graphs with markers.
hl = zeros(ns,1);
for s = 1:ns
    % ����������Ϊ�ǽ���״�ģ������е�Ԫ�ػ��������ֵ�����δ���
    [xs,ys] = stairs(T(:,s),(1:np)/np);% ��1:np)/np�Ǳ�ʾy�ᡣ��Ϊstair�е����������ά����һ���ģ�������һ��ֵ��Ӧһ��ֵ���������Ϊ��һ����ɱ���ʾ�����һ�����⣬�ڶ�������ɱ���ʾ������ڶ������⡣�Դ����ơ�
    sl = mod(s-1,3) + 1; sc = mod(s-1,7) + 1; sm = mod(s-1,12) + 1;
    option1 = [char(lines(sl)) colors(sc) markers(sm)];
    
    hl(s) = plot(xs,ys,option1);
    hold on;
end
xlabel('����ֵ�������/ά��');
ylabel('�������������');
% Axis properties are set so that failures are not shown, but with the
% max_ratio data points shown. This highlights the "flatline" effect.
axis([0 1.1*max_data 0 1]);% ����������������ָ�����䡣
