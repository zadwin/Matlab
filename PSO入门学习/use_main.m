x = -5:0.01:5;
y = 2.1*(1 - x + 2 * x.^2).*exp(-x.^2/2);
[v, index_x] = max(y);
% ��Ϊ���v��ֵ
disp(v);
% ��ͼ
plot(x,y,'m-','linewidth',3); % m��ʾ���Ƿۺ�ɫ,-�Ǳ�ʾ����������������
hold on;
plot(x(index_x), v,'kp','linewidth',4);
legend('Ŀ�꺯��','�����������ֵ');
xlabel('x'); % ��x������ǩ
ylabel('y'); % ��y������ǩ
grid on;