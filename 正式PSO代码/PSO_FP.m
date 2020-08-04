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
        LB = [-10 -10 -10 -10];
        UB = [10 10 10 10];
        f = PSO(@colville, 0.8, 1.2, 100, 2, 4, LB, UB);
        min_f = min(f);
    case 2
        LB = [0 0 0];
        UB = [1 1 1];
        % Ϊʲô����������
        fun_value1 = zeros(20000, 10);
        fun_value2 = zeros(20000, 10);
        for i = 1:10
            f = PSO(@hart3, 0.8, 1.2, 100, 2, 3, LB, UB);
            fun_value1(:,i) = f; 
        end
        % ������
        LB = [-10 -10 -10 -10];
        UB = [10 10 10 10];
        for i = 1:10
            f = PSO(@colville, 0.8, 1.2, 100, 2, 4, LB, UB);
            fun_value2(:,i) = f;
        end
        fun_value1(:,:,2) = fun_value2;
        N = zeros(10,1);
        gate = 2;
        data_profile(fun_value1 , N, gate);
    case 3
        LB = [0 0 0 0 0 0];
        UB = [1 1 1 1 1 1];
        PSO(@hart6, 0.8, 1.2, 100, 2, 6, LB, UB);
    case 4
        LB = [-10 -10 -10];
        UB = [10 10 10];
        PSO(@levy, 0.8, 1.2, 100, 2, 3, LB, UB);
    case 5
        LB = [-4 -4 -4 -4];
        UB = [5 5 5 5];
        PSO(@powell, 0.8, 1.2, 100, 2, 4, LB, UB);
    case 6
        LB = [0 0 0 0];
        UB = [5 5 5 5];
        PSO(@power1, 0.8, 1.2, 100, 2, 4, LB, UB);
    otherwise
        disp("��������ȷ�����У�");
end
end

