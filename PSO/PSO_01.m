function [y_best_values] = PSO_01( fun, N, d, xllimit, xulimit, vllimit, vulimit)
% ���������
% fun�����������ܲ��Ժ�����
% N������Ⱥ������������
% d���Ǳ�ʾ���Ժ�����ά�ȡ�
% xllimit��xulimit�ֱ��ʾλ�ò����������ޣ���ֹ���µ�ʱ�����ӵ�λ��Խ�硣
% vllimit��vulimit�ֱ���ʾ���Ӹ����ǵ��ٶȲ����������ޣ���ֹ���µ��ٶ�̫�����̫����

ger = 1;        % ��¼�������
maxger = 20000; % ���������������
%% �������ӵ�ÿ��ά������λ�ú��ٶȵ������޾���
xlimit = 1./zeros(d,2);
vlimit = zeros(d,2);
for i = 1:d
    xlimit(i,:) = [xllimit xulimit];
    vlimit(i,:) = [vllimit vulimit];
end
%% �����ٶȸ��µĳ�����
c_1 = 0.8; % ����Ȩ�ء�
c_2 = 0.5; % ����ѧϰ���ӡ�
c_3 = 0.5; % Ⱥ��ѧϰ���ӡ�
%% ��ʼ����Ⱥ��Ϣ
% ��ʼ����Ⱥλ�á�
x = 1./zeros( N, d);
for i = 1:d
    x(:,i) = xlimit(i,1) + (xlimit(i,2) - xlimit(i,1))*rand( N, 1);
end
v = rand( N, d); % ��ʼ����Ⱥ�ٶȡ�
x_best = x;      % ��ʼ��������ʷ���λ�á�
y_best = 1./zeros(1,d); % ������Ⱥ��ʷ���λ�á�
x_best_f = 1./zeros(N,1); % ���ø�����ʷ�����Ӧֵ������ֵ��,��ʼ��Ϊ�ޡ�
y_best_f = inf; % ������Ⱥ��ʷ�����Ӧֵ������ֵ��,��ʼ��Ϊ�����
%% ����Ⱥ����
times = 1; % ���ڿ���ͼ�������
record = 1./zeros(maxger ,1); % ���ü�¼������¼ÿ�μ���ĺ���ֵ�����õ������㷨������Ч����
fx = 1./zeros(N,1); % ���ڽ��ռ�������ĺ���ֵ��
x0 = 1./zeros(1,d); % ���ڷ�װ���㺯��ֵ�Ĳ�����
index = 1;  % �����������������
while ger <= maxger
    % ���㺯��ֵ��
    for i = 1:N
        for j = 1:d
            x0(1,j) = x(i,j);
        end
        fx(i,1) = fun(x0);
        record(ger) = fx(i,1);
        ger = ger + 1;
    end
    % ���¸�����ʷ��ѡ�
    for i = 1:N
        if x_best_f(i) > fx(i)
           x_best_f(i) = fx(i);
           x_best(i,:) = x(i,:);
        end
    end
    % ������Ⱥ��ʷ��ѡ�
    if y_best_f > min(x_best_f)
        [y_best_f,min_index] = min(x_best_f);
        y_best = x(min_index,:);
    end
    % ��¼���ֵ�ı仯��ʷ��
    y_best_values(index,1) = y_best_f;
    index = index+1;
    % �ٶȵĸ��¡�����repmat�Ǹ���y_best����һ��N*1�ľ��������������㡣
    % ��������һ��rand��֪����Ϊʲô��
    v = c_1 * v + c_2 * rand()* (x_best-x) + c_3 * rand() * (repmat(y_best,N,1) - x);
    % ��ֹ�ٶ�Խ�硣
    for i = 1:N
        for j = 1:d
            % �ٶ��Ͻ�ıȽϡ�
            if v(i,j) > vlimit(j,2)
               v(i,j) = vlimit(j,2);
            end
            % �ٶ��½�ıȽϡ�
            if v(i,j) < vlimit(j,1)
               v(i,j) = vlimit(j,1);
            end
        end
    end
    x = x + v;% λ�õĸ���
    % ��ֹ����λ��Խ�硣
    for i = 1:N
        for j = 1:d
            % �ٶ��Ͻ�ıȽϡ�
            if v(i,j) > xlimit(j,2)
               v(i,j) = xlimit(j,2);
            end
            % �ٶ��½�ıȽϡ�
            if v(i,j) < xlimit(j,1)
               v(i,j) = xlimit(j,1);
            end
        end
    end
end
figure(1);
plot(y_best_values);
xlabel("��������");
ylabel("�����Ӧֵ");
title("����������");
hold on;
end



