function PSO_01()
% ���ֵ��1162.5609
% PSO_01 Summary of this function goes here
%   Detailed explanation goes here
clc;clear;close all;
%% ��ʼ����Ⱥ
f= @(a,b)(a .* sin(a) .* cos(2 * a) - 2 * a .* sin(3 * a)).*(b .* sin(b) .* cos(2 * b) - 2 * b .* sin(3 * b)); % �������ʽ
% figure��1����figure������һ��������һ���µ�ͼ��
figure(1);
% meshgrid��MATLAB�������������������ĺ�����
% ���������������һ������ƽ�� ��0��ʼ��20��������λ���0.2������x��y�ĵ�
[x0_1, x0_2]=meshgrid(0:.2:20);
y0=f(x0_1,x0_2);
% plot��plot3��surf��mesh���ǻ�ͼ�ĺ�����
% mesh�������ڻ��Ʋ����ر�ϸ����ά��������ͼ��surf�������ڻ��ƱȽϹ⻬����ά��������ͼ��
% ͼһ�Ŀ�ʼ
mesh(x0_1, x0_2, y0);
hold on;

N = 500;                         % ��ʼ��Ⱥ����
d = 2;                          % �ռ�ά��
ger = 300;                      % ����������     
limit = [0, 20;0,20];                % ����λ�ò�������(�������ʽ���Զ�ά)
% ���ǲ�֪������ٶ�Ϊʲô���������ô�����ġ��Լ�����Ĺ���Ȩ�ء�����ѧϰ���Ӻ�Ⱥ��ѧϰ����
vlimit = [-1.5, 1.5;-1.5, 1.5];               % �����ٶ�����
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
fxm = zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = -inf;                      % ��Ⱥ��ʷ�����Ӧ��

% ���е�xm(:,1)��xm(:,2)�൱�ں����Ĳ���x��y��
plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'ro');title('��ʼ״̬ͼ');
hold on;
figure(2);
% ͼ���Ŀ�ʼ
mesh(x0_1, x0_2, y0);
hold on;
plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'ro');
hold on;
%% ����Ⱥ����
iter = 1;
times = 1; 
record = zeros(ger, 1);          % ��¼��
while iter <= ger
    fx = f(x(:,1),x(:,2)) ; % ���嵱ǰ��Ӧ��
    % disp(fx');    % ���ÿ�����������ĸ����ֵ��
    for i = 1:N      
       if fxm(i) < fx(i)
           fxm(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
           xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
       end 
    end
    if fym < max(fxm)
       [fym, nmax] = max(fxm);   % ����Ⱥ����ʷ�����Ӧ��
       ym = xm(nmax, :);      % ����Ⱥ����ʷ���λ��
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
        if  v(j,i) < vlimit(i,1)
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
            x(j,i)=limit(i,1);
        end
        end
    end
    record(iter) = fym;% ���ֵ��¼��ָ�������ĺ���ֵ�������Ӧֵ��
    % 10����֮�����»���һ���㷨ֵ��״̬�仯��
    if times >= 10
        % cla(),Clear
        % axis�������ǰͼ���еĵ�ǰ��ᡣ�����᲻��Ӱ�졣����������еĻ��Ƶ�ͼ�񣬵�������Ȼ�������������»���
        cla;
        mesh(x0_1, x0_2, y0);
        plot3(x(:,1),x(:,2),f(x(:,1),x(:,2)), 'ro');title('״̬λ�ñ仯');
        pause(0.1);
        times=0;
    end
    iter = iter+1;
    times=times+1;
end
% ͼ���Ŀ�ʼ������¼�������ֵ�Ĺ��̡�
figure(3);plot(record);title('��������');
% ͼ�Ŀ�ʼ�Ĺ��̣���¼���յ�λ�ã��൱��ÿ��������󶼴ﵽ������λ�á�
figure(4);
mesh(x0_1, x0_2, y0);
hold on;
plot3(x(:,1),x(:,2),f(x(:,1),x(:,2)), 'ro');title('����״̬ͼ');

disp(['���ֵ��',num2str(fym)]);
disp(['����ȡֵ��',num2str(ym)]);

end

