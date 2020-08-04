x = -5:0.01:5;
y = 2.1*(1 - x + 2 * x.^2).*exp(-x.^2/2);
[v, index_x] = max(y);
% 作为输出v的值
disp(v);
% 画图
plot(x,y,'m-','linewidth',3); % m表示的是粉红色,-是表示的是连续的曲线线
hold on;
plot(x(index_x), v,'kp','linewidth',4);
legend('目标函数','搜索到的最大值');
xlabel('x'); % 给x轴贴标签
ylabel('y'); % 给y轴贴标签
grid on;