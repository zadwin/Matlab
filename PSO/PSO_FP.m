function PSO_FP()
%% ����һ���㷨���Ե���ڣ�����ѡ����Եĺ�����
%% �������
clc;% �������ڡ�
clear;% ������б����� 
close all; % �������ͼƬ��
% ���ú���
% index = 4;
% input()�����������������������ַ���������Ĭ������������
disp('1��Ackley���Ժ���         2��Beale���Ժ���         3��Boh1���Ժ���');
disp('4��Booth���Ժ���          5��Branin���Ժ���        6��dp���Ժ���');
disp('7��Easom���Ժ���          8��Gold���Ժ���          9��Griew���Ժ���');
disp('10��Hump���Ժ���          11��Matyas���Ժ���       12��Mich���Ժ���');
disp('13��Perm���Ժ���          14��Rast���Ժ���         15��Rosen���Ժ���');
disp('16��Schw���Ժ���          17��Shub���Ժ���         18��Sphere���Ժ���');
disp('19��Sum2���Ժ���          20��Trid���Ժ���         21��Zakh���Ժ���');
disp('22��Levy���Ժ���          23��Powell���Ժ���');
index = input('��������Ҫ���Ժ����� index: ');
% a = input('�����ַ���','s');
% disp(a);
switch index
    case 1
        PSO_01_Plot(@ackley, 50, 2, -30, 30, -1.5, 1.5);
    case 2
        PSO_01_Plot(@beale, 50, 2, -4, 4, -1.5, 1.5);
    case 3
        PSO_01_Plot(@boh1, 50, 2, -100, 100, -1.5, 1.5);
    case 4
        PSO_01_Plot(@booth, 50, 2, -10, 10, -1.5, 1.5);
    case 5
        PSO_01_Plot(@branin, 50, 2, -10, 10, -1.5, 1.5);
    case 6
        PSO_01_Plot(@dp, 50, 2, -10, 10, -1.5, 1.5);
    case 7
        PSO_01_Plot(@easom, 50, 2, -30, 30, -1.5, 1.5);
    case 8
        PSO_01_Plot(@gold, 50, 2, -2, 2, -1.5, 1.5);
    case 9
        PSO_01_Plot(@griew, 50, 2, -50, 50, -1.5, 1.5);
    case 10
        PSO_01_Plot(@hump, 50, 2, -5, 5, -1.5, 1.5);
    case 11
        PSO_01_Plot(@matyas, 50, 2, -10, 10, -1.5, 1.5);
    case 12
        PSO_01_Plot(@mich, 50, 2, 0, 4, -1.5, 1.5);
    case 13
        PSO_01_Plot(@perm, 50, 2, -2, 2, -1.5, 1.5);
    case 14
        PSO_01_Plot(@rast, 50, 2, -5, 5, -1.5, 1.5);
    case 15
        PSO_01_Plot(@rosen, 50, 2, -10, 10, -1.5, 1.5);
    case 16
        PSO_01_Plot(@schw, 50, 2, -500, 500, -1.5, 1.5);
    case 17
        PSO_01_Plot(@shub, 50, 2, -10, 10, -1.5, 1.5);
    case 18
        PSO_01_Plot(@sphere, 50, 2, -5, 5, -1.5, 1.5);
    case 19
        PSO_01_Plot(@sum2, 50, 2, -10, 10, -1.5, 1.5);
    case 20
        PSO_01_Plot(@trid, 50, 2, -4, 4, -1.5, 1.5);
    case 21
        PSO_01_Plot(@zakh, 50, 2, -10, 10, -1.5, 1.5);
    case 22
        PSO_01_Plot(@levy, 50, 2, -10, 10, -1.5, 1.5);
    case 23
        PSO_01_Plot(@powell, 50, 2, -4, 4, -1.5, 1.5);
    otherwise
        disp("��������ȷ�����У�");
end

