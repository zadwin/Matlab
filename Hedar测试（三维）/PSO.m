function [his_run] = PSO(fun ,omega,phi,np,degree,D, LB, UB)
%  PSO���򣬻�������ͼ����
%  ���ߣ���Ⱥ��
%  2014.3.1
% =========================================
% ���룺
%  omega, phi ----- PSO����
%  np ----- ������
% degree --- ����ͼ�Ķ���
%  D ----- ����ά��
%  FE_max, fun, LB, UB---����ֵ����������������ţ��½�(������)���Ͻ�
%  x -------------- D*np�������ӵĳ�ʼλ��
%
%  �����
%  his_run ----- ���ÿ�����е���ú���ֵ��ʷ
%==========================================
%�˴���ֵ��ʲô��
global nfev maxnfev  % ����ֵ��������������ֵ�������
nfev = 1;
maxnfev = 20000;
his_run = zeros(maxnfev,1); % �洢ÿ�����е���ú���ֵ��ʷ

%% ------------------��ʼ��-----------------------
x = zeros(D,np); % ��¼���ӵĳ�ʼλ��
for i=1:np
    for j=1:D
        x(j,i) = LB(j) + rand()*(UB(j)-LB(j)); % ��i������λ�ó�ֵ
    end
end
V = zeros(D,np);     % ��¼np�����ӵ��ٶ�
fbest_p = zeros(np,1); % np*1��������¼ÿ�����ӵ�������Ӧֵksmnksmn
xbest_p = x;           % ��¼ÿ�����ӵĸ�������λ��
for i=1:np
    for j=1:D
        V(j,i) = LB(j)-x(j,i) + rand()*(UB(j)-LB(j)); % ��i�������ٶȳ�ֵ
    end
    % ����Ͳ��Ǻܶ�
    % X(2:4,[2 3 5])����ʾ�������������֣��У�2?4�����У�2��3��5����
    fbest_p(i) = fun(x(:,i)'); % ����ÿ�����ӵĳ�ʼ��Ӧֵ������¼��fbest_p��,ע��nfev�Ѽ�1
    if nfev == 1
        his_run(nfev,1) = fbest_p(1);
    elseif fbest_p(i)<his_run(nfev-1,1)
        his_run(nfev,1) = fbest_p(i);
    else
        his_run(nfev,1) = his_run(nfev-1,1);
    end
    nfev = nfev+1;
end
xbest_n = findNbest(fbest_p,xbest_p,np,degree); % ȷ��ÿ�����ӵ���������λ��

%% -----------------��ѭ����ʼ-------------------------
while nfev<maxnfev
    for i=1:np  % ��ÿһ������...
        for j=1:D % ...ÿһά��ִ�����²���
            C1 = rand()*phi;
            C2 = rand()*phi;
            V(j,i) = omega * V(j,i) + C1 * ( xbest_p(j,i) - x(j,i) ) + C2 * ( xbest_n(j,i) - x(j,i) ); % �ٶȸ���
            x(j,i) = x(j,i) + V(j,i);
        end
        fit = fun(x(:,i)'); % ������λ�õ���Ӧֵ
        if nfev>maxnfev
            return;
        end
        if fit<his_run(nfev-1,1)
            his_run(nfev,1) = fit;
        else
            his_run(nfev,1) = his_run(nfev-1,1);
        end
        if fit<fbest_p(i) % �����λ�õ���Ӧֵ��С�����¸���������Ӧֵ������λ��
            fbest_p(i)   = fit;
            xbest_p(:,i) = x(:,i);
        end
        nfev = nfev+1;
    end
    
    xbest_n = findNbest(fbest_p,xbest_p,np,degree); % ����ȷ��ÿ�����ӵ���������λ��
end
% ----------------��ѭ������------------------------

figure(1);
plot(his_run);
%% �Ӻ���
function xbest_n = findNbest(fbest_p,xbest_p,np,degree)
% ȷ��ÿ�����ӵ���������λ��
% fbest_p Ϊÿ�����ӵĸ���������Ӧֵ
% xbest_p Ϊÿ�����ӵĸ�������λ��
% np Ϊ���Ӹ���
% degree Ϊ����ͼ������ÿ�����ӵĶ�����degree = 2  ��Ӧlbest����
%                                             np ��Ӧgbest����
% -----------------------------------------------------------
% np��degree�����㣺����ͼ������ = np/(degree-1), degree-1 ����ÿ��������� ?
% ����ȷ��ÿ������������ȷ����Ҫ�����飬np = ÿ�������� * ���� ?
% ���⣬���� > ���� Ҳ���� ���� > ÿ��������+1 ��
% ����������������������������ϣ�(3,10,20), (4,10,30), (5,6,24) ?
% �����ƺ����ǿ���ͼ�����Ҫ�أ�2014.3.2
% ���⣬���ܿ���ͼ����ͳһlbest��gbest����ÿ�ܣ����ڸ�����������������ͼ��
% ����ͼһ��������ͼ����֮��һ����

if mod(np,2)==1 && mod(degree,2)==1
    fprintf('Either np or degree must be even !\n'); % np��degree������һ��ż���������޷���������ͼ
    xbest_n = [];    return;
end
if np<(degree+1)
    fprintf('np must greater than degree !\n'); % npҪ�����degree�������޷���������ͼ
    xbest_n = [];    return;
end
xbest_n = zeros(size(xbest_p));

if mod(degree,2)==0 % ż����
    k = degree/2;
    for i=0:np-1 % ��ÿ������
        neighbour = mod(i-k:1:i+k,np)+1; % ȷ�����ھӣ�������
        % ���������ӱ��Χ��һ��Ȧ�������������߸����� k ��
        [~,index] = min(fbest_p(neighbour));
        index = neighbour(index); % ȷ�������ھӣ�����Ϊ����
        xbest_n(:,i+1) = xbest_p(:,index); % ȷ����������λ��
    end
else % ������
    k = (degree-1)/2;
    nph = np/2; % ��ʱnpһ����ż��
    for i =0:np-1 % ��ÿ������
        neighbour = [mod(i-k:1:i+k,np),mod(i+nph,np)]+1; % ȷ�����ھӣ�������
        % ���������ӱ��Χ��һ��Ȧ�������������߸����� k ����ͬʱ��������������i+nph
        [~,index] = min(fbest_p(neighbour));
        index = neighbour(index); % ȷ�������ھӣ�����Ϊ����
        xbest_n(:,i+1) = xbest_p(:,index); % ȷ����������λ��
    end
end
end
end