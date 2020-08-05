function PSO_Fun_Plot(fun, N , d, llimit, ulimit, vllimit, vulimit)
% ����һ���л��ƹ��ܵ��㷨�����У�fun�ǲ��Ժ�����N�ǳ�ʼ���ӵĸ�����d�ǲ��Ե�ά����
%   llimit��ulimit�ֱ�������λ�õ������ޣ�vllimit��vulimit�ֱ������Ӹ��µ��ٶ�������
%% ��ʼ����Ⱥ
% N = 500;                         % ��ʼ��Ⱥ����
% d = 3;                          % �ռ�ά��
ger = 300;                      % ���������� 
limit = zeros(d,2)*NaN;         %���Խ���������Ϊ��ֵ�� 
for i = 1:d
    limit(i,:) = [llimit,ulimit];
end
%% ��ʼ״̬ͼ��Ŀ�ʼ��
figure(1);
[x0_1, x0_2] = meshgrid(llimit:0.2:ulimit);
n_co = (ulimit-llimit)/0.2 + 1;
% ���㺯��ֵ,�����y0ֻ���ڴ洢��ͼͼ��ĺ���ֵ��
y0 = zeros(n_co, n_co);
for i = 1:n_co
    for j = 1:n_co
        x0 = [x0_1(i, j) x0_2(i, j)];   % ע����������ȡx0��ֵ��
        y0(i, j) = fun(x0);
    end
end
mesh(x0_1, x0_2, y0);
title("��ʼ״̬");
hold on;                                % �������һ��ͼ��û����hold on�����������ֽ����˻��ƣ������֮ǰ�������������

%limit = [-10,10;-10, 10;-10,10;-10,10];                % ����λ�ò�������(�������ʽ���Զ�ά)
% ���ǲ�֪������ٶ�Ϊʲô���������ô�����ġ��Լ�����Ĺ���Ȩ�ء�����ѧϰ���Ӻ�Ⱥ��ѧϰ����
vlimit = zeros(d,2);
for i = 1:d
    vlimit(i,:) = [vllimit,vulimit];    % �����ٶ�����
end
% vlimit = [-1, 1;-1, 1;-1,1;-1,1];               % �����ٶ�����
c_1 = 0.8;                        % ����Ȩ��
c_2 = 0.5;                       % ����ѧϰ����
c_3 = 0.5;                       % Ⱥ��ѧϰ���� 
for i = 1:d
    x(:,i) = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, 1);%��ʼ��Ⱥ��λ�á���������0-20���������x����һ��500��2�еľ���
end
v = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�
x0 = zeros(1, d);                % x0���ڹ���ÿ�μ��㺯��ֵ�Ĳ�������СΪ1*d
xm = x;                          % ÿ���������ʷ���λ��
ym = zeros(1, d);                % ��Ⱥ����ʷ���λ�á��������ž�ֻ�洢һ����
% �����Ӧ��Ӧ�þ���ֵ����ѵĺ���ֵ��
fx = zeros(N,1);                       % ���ڴ洢ÿ�������ֵ,��ʼ��СΪN*1��
fxm = 1./zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = inf;                      % ��Ⱥ��ʷ�����Ӧ��
% ͼһ��ʼ״̬������
for i = 1:N
    for j = 1:d
        x0(1,j) = xm(i, j);      % �δ˴���Ҫ������һ��������x0��Ž�����һ���ļ��㺯��ֵ��
    end
    fx(i,1) = fun(x0);
end
plot3(xm(:,1) ,xm(:,2), fx(:,1), 'ro');  % ע��plot��plot3������
% saveas(gcf,'��ʼ״̬.jpg'); % �˺������ڱ�����Ƴ�����ͼƬ������ͼ����figure_handle�̶�Ϊgcf�����һ��ԭ��ͬ����ͼ����и��ǡ�
hold on;

% ͼ���Ŀ�ʼ
figure(2);
mesh(x0_1, x0_2, y0);
title("״̬λ�ñ仯");
hold on;
plot3(xm(:,1), xm(:,2), fx(:,1), 'ro'); % ��ʼ�ı仯ͼ
hold on;

%% ����Ⱥ����
iter = 1;
times = 1; 
record = zeros(ger, 1);          % ��¼��
while iter <= ger
    for i=1: N
        for j = 1:d
            x0(1,j) = x(i,j);
        end
        % x0 = [x(i,1) x(i,2) x(i,3) x(i,4)];
        fx(i, 1) = fun(x0);  % ����xΪһ����ļ���
    end
    for i = 1:N      
       if fxm(i) > fx(i)
           fxm(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
           xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
       end 
    end
    if fym > min(fxm)
       [fym, nmin] = min(fxm);   % ����Ⱥ����ʷ�����Ӧ��
       ym = xm(nmin, :);      % ����Ⱥ����ʷ���λ��
    end
    % �����һ�ε��ٶ���������ɵġ�repmat��1:10,40,1�����Ƕ�һ����1��2��....��10ֵ�ظ����г�40*1�ľ���.
    % �˴���repmat(ym, N, 1)�Ƕ�ymһ��1��2�еľ���������У���һ�е���һ��Ԫ�ء�
    % ���еĹ�����һ���ᳯ��Ŀǰ���ŵĵط����¡�
    v = v * c_1 + c_2 * rand *(xm - x) + c_3 * rand *(repmat(ym, N, 1) - x);% �ٶȸ���
    % �߽��ٶȴ�����ֹ�ٶ�Խ�硣
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
    x = x + v;% λ�ø���
    % �߽�λ�ô���,��ֹλ�ó��磬��ֹ���������ı���ȡֵ��Χ��
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
    record(iter) = fym;% ��Сֵ��¼��ָ������С�ĺ���ֵ����С��Ӧֵ��
    % 10����֮�����»���һ���㷨ֵ��״̬�仯��
    if times >= 10
       % ÿ����10����ͼ�������һ�¸����λ�á�
       % ��Ҫʵ��״̬ͼ��ֻ��ÿ�����������ͼ�񶼻���
       cla;    % cla�����������е�ͼ�����趨�����ݣ��ָ��Զ��趨����
       mesh(x0_1, x0_2, y0);
       hold on;
       for i=1: N
           for j = 1:d
               x0(1,j) = x(i,j);
           end
           % x0 = [x(i,1) x(i,2) x(i,3) x(i,4)];
           fx(i, 1) = fun(x0);  % ����xΪһ����ļ���
       end
       plot3(x(:,1), x(:, 2), fx(:,1), 'ro');
       hold on;
       pause(0.2);
       times=0;
   end
   iter = iter + 1;
   times = times + 1;
end
% ͼ���Ŀ�ʼ������¼�������ֵ�Ĺ��̡��˴���plot�൱���ǰ��������±���л��ơ�
figure(3);plot(record);title('��������');
hold on;

figure(4);
mesh(x0_1, x0_2, y0);
hold on;
% Ϊʲô������е�x�������ܵ������Ϊλ�ã����ֺ�����
plot3(x(:,1), x(:,2), fx(:,1), 'ro');
title("����״̬");
hold on;

% �����Сֵ����Сֵ�㡣
disp(['��Сֵ��',num2str(fym)]);
disp(['����ȡֵ��',num2str(ym)]);

end

