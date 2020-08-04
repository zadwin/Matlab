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
        disp("请输入正确的序列！");
end

