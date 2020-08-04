function [H_PSO2,N] = PSO2_FP_data()
%% ����һ���㷨���Ե���ڣ�����ѡ����Եĺ�����
%% �������
clc;% �������ڡ�
clear;% ������б����� 
close all; % �������ͼƬ��
% ���ú���
% index = 4;
% input()�����������������������ַ���������Ĭ������������
H_PSO2 = zeros(20000,30);
H_PSO_f = zeros(20000,30);
j = 1;
N = zeros(1,22);
for i = 1:30
    LB = [-30 -30];
    UB = [30 30];
    f_value = PSO(@ackley, 0.8, 1.2,50,2,2, LB, UB);
    H_PSO2(:,i) = f_value;
end
N(1,j) = 2;
j = j+1;
for i = 1:30
    LB = [-4 -4];
    UB = [4 4];
    f_value = PSO(@beale,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;
for i = 1:30
    LB = [-100 -100];
    UB = [100 100];
    f_value = PSO(@boh1,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@booth,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@branin,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;


for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@dp,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@easom,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-2 -2];
    UB = [2 2];
    f_value = PSO(@gold,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-50 -50];
    UB = [50 50];
    f_value = PSO(@griew,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-5 -5];
    UB = [5 5];
    f_value = PSO(@hump,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@matyas,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [0 0];
    UB = [4 4];
    f_value = PSO(@mich,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [0 0];
    UB = [4 4];
    f_value = PSO(@perm,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-5 -5];
    UB = [5 5];
    f_value = PSO(@rast,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@rosen,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-500 -500];
    UB = [500 500];
    f_value = PSO(@schw,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;
  
for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@shub,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;
   
for i = 1:30
    LB = [-5 -5];
    UB = [5 5];
    f_value = PSO(@sphere,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@sum2,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-4 -4];
    UB = [4 4];
    f_value = PSO(@trid,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;

for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@zakh,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;


for i = 1:30
    LB = [-10 -10];
    UB = [10 10];
    f_value = PSO(@levy,0.8,1.2,50, 2,2, LB, UB);
    H_PSO_f(:,i) = f_value;
end
N(1,j) = 2;
H_PSO2(:,:,j) = H_PSO_f;
j = j+1;
end
