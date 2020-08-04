function PSO_03()
% PSO_01 Summary of this function goes here
%   Detailed explanation goes here
clc;clear;close all;
%% ��ʼ����Ⱥ
N = 500;                         % ��ʼ��Ⱥ����
d = 3;                          % �ռ�ά��
ger = 300;                      % ����������     
limit = [0,1;0, 1;0,1];                % ����λ�ò�������(�������ʽ���Զ�ά)
% ���ǲ�֪������ٶ�Ϊʲô���������ô�����ġ��Լ�����Ĺ���Ȩ�ء�����ѧϰ���Ӻ�Ⱥ��ѧϰ����
vlimit = [-1, 1;-1, 1;-1,1];               % �����ٶ�����
c_1 = 0.8;                        % ����Ȩ��
c_2 = 0.5;                       % ����ѧϰ����
c_3 = 0.5;                       % Ⱥ��ѧϰ���� 
for i = 1:d
    x(:,i) = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, 1);%��ʼ��Ⱥ��λ�á���������0-20���������x����һ��500��2�еľ���
end
v = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�
xm = x;                          % ÿ���������ʷ���λ��
ym = zeros(1, d);                % ��Ⱥ����ʷ���λ�á��������ž�ֻ�洢һ����
% �����Ӧ��Ӧ�þ���ֵ����ѵĺ���ֵ��
fxm = 1./zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = inf;                      % ��Ⱥ��ʷ�����Ӧ��

%% ����Ⱥ����
iter = 1;
times = 1; 
record = zeros(ger, 1);          % ��¼��
while iter <= ger
    fx = [N,1];
    for i=1: N
        x0 = [x(i,1) x(i,2) x(i,3)];
        fx(i, 1) = hart3(x0);  % ����xΪһ����ļ���
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
    if times >= 180
        % ��������¼�����еĸ���ֵ��
        times=0;
    end
    iter = iter+1;
    times=times+1;
end
% ͼ���Ŀ�ʼ������¼�������ֵ�Ĺ��̡�
figure(3);plot(record);title('��������');
% �����Сֵ����Сֵ�㡣
disp(['��Сֵ��',num2str(fym)]);
disp(['����ȡֵ��',num2str(ym)]);

end

