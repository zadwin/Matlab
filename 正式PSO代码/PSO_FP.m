function PSO_FP()
%% 该函数是所有多维测试函数的入口，可以用于选择需要测试的函数。
% 清除缓存
clc;clear;close all;
% 调用函数
% index = 4;
% input()函数可以用来输入数或者字符串。但是默认是输入数。
% 此处需要注意power函数与库函数有冲突，所以改名为power1。
disp('1、Colville测试函数        2、Hart3测试函数        3、Hart6测试函数')
disp('4、Levy测试函数            5、Powell测试函数        6、Power测试函数')
disp('7、Shekel测试函数          ')

index = input('请输入需要测试函数的 index: ');
% a = input('输入字符串','s');
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
        % 为什么最后会收敛？
        fun_value1 = zeros(20000, 10);
        fun_value2 = zeros(20000, 10);
        for i = 1:10
            f = PSO(@hart3, 0.8, 1.2, 100, 2, 3, LB, UB);
            fun_value1(:,i) = f; 
        end
        % 函数二
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
        disp("请输入正确的序列！");
end
end

