function PSO_FP()
%% 这是一个算法测试的入口，用于选择测试的函数。
%% 清除缓存
clc;% 清空命令窗口。
clear;% 清除所有变量。 
close all; % 清除所有图片。
% 调用函数
% index = 4;
% input()函数可以用来输入数或者字符串。但是默认是输入数。
disp('1、Ackley测试函数         2、Beale测试函数         3、Boh1测试函数');
disp('4、Booth测试函数          5、Branin测试函数        6、dp测试函数');
disp('7、Easom测试函数          8、Gold测试函数          9、Griew测试函数');
disp('10、Hump测试函数          11、Matyas测试函数       12、Mich测试函数');
disp('13、Perm测试函数          14、Rast测试函数         15、Rosen测试函数');
disp('16、Schw测试函数          17、Shub测试函数         18、Sphere测试函数');
disp('19、Sum2测试函数          20、Trid测试函数         21、Zakh测试函数');
disp('22、Levy测试函数          23、Powell测试函数');
index = input('请输入需要测试函数的 index: ');
% a = input('输入字符串','s');
% disp(a);
switch index
    case 1
        PSO_Fun_Plot(@ackley, 50, 2, -30, 30, -1.5, 1.5);
    case 2
        PSO_Fun_Plot(@beale, 50, 2, -4, 4, -1.5, 1.5);
    case 3
        PSO_Fun_Plot(@boh1, 50, 2, -100, 100, -1.5, 1.5);
    case 4
        PSO_Fun_Plot(@booth, 50, 2, -10, 10, -1.5, 1.5);
    case 5
        PSO_Fun_Plot(@branin, 50, 2, -10, 10, -1.5, 1.5);
    case 6
        PSO_Fun_Plot(@dp, 50, 2, -10, 10, -1.5, 1.5);
    case 7
        PSO_Fun_Plot(@easom, 50, 2, -30, 30, -1.5, 1.5);
    case 8
        PSO_Fun_Plot(@gold, 50, 2, -2, 2, -1.5, 1.5);
    case 9
        PSO_Fun_Plot(@griew, 50, 2, -50, 50, -1.5, 1.5);
    case 10
        PSO_Fun_Plot(@hump, 50, 2, -5, 5, -1.5, 1.5);
    case 11
        PSO_Fun_Plot(@matyas, 50, 2, -10, 10, -1.5, 1.5);
    case 12
        PSO_Fun_Plot(@mich, 50, 2, 0, 4, -1.5, 1.5);
    case 13
        PSO_Fun_Plot(@perm, 50, 2, -2, 2, -1.5, 1.5);
    case 14
        PSO_Fun_Plot(@rast, 50, 2, -5, 5, -1.5, 1.5);
    case 15
        PSO_Fun_Plot(@rosen, 50, 2, -10, 10, -1.5, 1.5);
    case 16
        PSO_Fun_Plot(@schw, 50, 2, -500, 500, -1.5, 1.5);
    case 17
        PSO_Fun_Plot(@shub, 50, 2, -10, 10, -1.5, 1.5);
    case 18
        PSO_Fun_Plot(@sphere, 50, 2, -5, 5, -1.5, 1.5);
    case 19
        PSO_Fun_Plot(@sum2, 50, 2, -10, 10, -1.5, 1.5);
    case 20
        PSO_Fun_Plot(@trid, 50, 2, -4, 4, -1.5, 1.5);
    case 21
        PSO_Fun_Plot(@zakh, 50, 2, -10, 10, -1.5, 1.5);
    case 22
        PSO_Fun_Plot(@levy, 50, 2, -10, 10, -1.5, 1.5);
    case 23
        PSO_Fun_Plot(@powell, 50, 2, -4, 4, -1.5, 1.5);
    otherwise
        disp("请输入正确的序列！");
end

