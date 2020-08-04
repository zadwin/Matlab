function PSO1_FP_data()
%% 这是一个算法测试的入口，用于选择测试的函数。
%% 清除缓存
clc;% 清空命令窗口。
clear;% 清除所有变量。 
close all; % 清除所有图片。
% 调用函数
% index = 4;
% input()函数可以用来输入数或者字符串。但是默认是输入数。
H_PSO1 = zeros(20000,30);
H_PSO_f = zeros(20000,30);
j = 1;
N = zeros(1,22);
for i = 1:30
    f_value = PSO_Fun(@ackley, 50, 2, -30, 30, -1.5, 1.5);
    H_PSO1(:,i) = f_value;
end
N(1,j) = 2;
j = j+1;
for i = 1:30
    f_value = PSO_Fun(@beale, 50, 2, -4, 4, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;
for i = 1:30
    f_value = PSO_Fun(@boh1, 50, 2, -100, 100, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@booth, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@branin, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;


for i = 1:30
    f_value = PSO_Fun(@dp, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@easom, 50, 2, -30, 30, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@gold, 50, 2, -2, 2, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@griew, 50, 2, -50, 50, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@hump, 50, 2, -5, 5, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@matyas, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@mich, 50, 2, 0, 4, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@perm, 50, 2, -2, 2, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@rast, 50, 2, -5, 5, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@rosen, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@schw, 50, 2, -500, 500, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;
  
for i = 1:30
    f_value = PSO_Fun(@shub, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;
   
for i = 1:30
    f_value = PSO_Fun(@sphere, 50, 2, -5, 5, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@sum2, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@trid, 50, 2, -4, 4, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    f_value = PSO_Fun(@zakh, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;


for i = 1:30
    f_value = PSO_Fun(@levy, 50, 2, -10, 10, -1.5, 1.5);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO1(:,:,j) = H_PSO_f;
j = j+1;
end
