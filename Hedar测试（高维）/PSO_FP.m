function PSO_FP()
%% �ú��������ж�ά���Ժ�������ڣ���������ѡ����Ҫ���Եĺ�����
% �������
clc;clear;close all;
% ���ú���
% index = 4;
% input()�����������������������ַ���������Ĭ������������
% �˴���Ҫע��power������⺯���г�ͻ�����Ը���Ϊpower1��
disp('1��Colville���Ժ���        2��Hart3���Ժ���        3��Hart6���Ժ���')
disp('4��Levy���Ժ���            5��Powell���Ժ���        6��Power���Ժ���')
disp('7��Shekel���Ժ���          ')

index = input('��������Ҫ���Ժ����� index: ');
% a = input('�����ַ���','s');
% disp(a);
switch index
    case 1
        PSO_Fun(@colville, 100, 4, -10, 10, -1.5, 1.5);
    case 2
        PSO_Fun(@hart3, 100, 3, 0, 1, -1, 1);
    case 3
        PSO_Fun(@hart6, 100, 6, 0, 1, -1, 1);
    case 4
        PSO_Fun(@levy, 500, 30, -10, 10, -1.5, 1.5);
    case 5
        PSO_Fun(@powell, 500, 4, -4, 5, -1.5, 1.5);
    case 6
        PSO_Fun(@power1, 500, 4, 0, 5, -1, 1);
    case 7
        PSO_Fun(@shekel, 100, 4, 0, 10, -0.8, 0.8);
    case 8
        PSO_Fun(@gold, 50, 2, -2, 2, -1.5, 1.5);
    case 9
        PSO_Fun(@griew, 50, 2, -50, 50, -1.5, 1.5);
    case 10
        PSO_Fun(@hump, 50, 2, -5, 5, -1.5, 1.5);
    case 11
        PSO_Fun(@matyas, 50, 2, -10, 10, -1.5, 1.5);
    case 12
        PSO_Fun(@mich, 50, 2, 0, 4, -1.5, 1.5);
    otherwise
        disp("��������ȷ�����У�");
end

