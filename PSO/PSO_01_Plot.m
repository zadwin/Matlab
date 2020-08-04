function [y_best_values] = PSO_01_Plot( fun, N, d, xllimit, xulimit, vllimit, vulimit)
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
fx = 1./zeros(N,1); % ���ڽ��ռ�������ĺ���ֵ��
x0 = 1./zeros(1,d); % ���ڷ�װ���㺯��ֵ�Ĳ�����
%% ����ͼƬ1����Ⱥ��ʼ��ͼ��
% ԭ�����Ļ���
figure(1);
% ͼ���Ƿ�����ɫ����ʱ���Ǻ�ȡ�����꾫���йء�
[x0_1,x0_2] = meshgrid(xllimit:0.1:xulimit); % ����x_1��x_2����������ԭ����ͼ��Ĳ���ֵ��
node_num = (xulimit - xllimit)/0.1 + 1; % node_num������ͳ����Ҫ���ɵĵ��������
y_0 = 1./zeros(node_num,node_num);  % y_0�������洢ԭ����ͼ��ĺ���ֵ��
for i = 1:node_num
    for j = 1:node_num
        x0 = [x0_1(i,j) x0_2(i,j)];
        y_0(i,j) = fun(x0);
    end
end
mesh( x0_1, x0_2, y_0);
hold on;
% ��Ⱥ���ӳ�ʼ״̬�Ļ��ơ�
for i = 1:N
    for j = 1:d
        x0(1,j) = x(i,j);
    end
    fx(i,1) = fun(x0);   
end
plot3( x(:,1), x(:,2), fx, 'ro'); % �������������һ����ͬ�͵ġ�
hold on;
%% ͼ���Ŀ�ʼ����Ⱥ���ӵı仯״̬
% ����ͼ��Ļ���
figure(2);
mesh( x0_1, x0_2, y_0);
title("����״̬�仯");
hold on;
% ����״̬�Ļ��ơ�
plot3( x(:,1), x(:,2), fx, 'ro');
hold on;
%% ����Ⱥ����
times = 0; % ���ڿ���ͼ�������
record = 1./zeros(maxger ,1); % ���ü�¼������¼ÿ�μ���ĺ���ֵ�����õ������㷨������Ч����
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
    
   if times > 20
      cla;    % cla�����������е�ͼ�����趨�����ݣ��ָ��Զ��趨����
      mesh(x0_1, x0_2, y_0);
      hold on;
      for i=1: N
          for j = 1:d
              x0(1,j) = x(i,j);
          end
          fx(i, 1) = fun(x0);  % ����xΪһ����ļ���
      end
      plot3(x(:,1), x(:, 2), fx(:,1), 'ro');
      hold on;
      pause(0.2);
      times=0;
   end
   times = times + 1;
end
%% ������Ⱥ�������������
figure(3);
plot(y_best_values);
xlabel("��������");
ylabel("�����Ӧֵ");
title("����������");
hold on;
%% ������Ⱥ���ӵ�����״̬��
figure(4);
mesh(x0_1, x0_2, y_0);
hold on;
% Ϊʲô������е�x�������ܵ������Ϊλ�ã����ֺ�����
plot3(x(:,1), x(:,2), fx, 'ro');
title("����״̬");
hold on;
end



