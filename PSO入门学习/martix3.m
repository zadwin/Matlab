clc;
clear;
%% 数组和矩阵的区别
% 数组是在程序设计中，为了处理方便，把具有相同类型的若干变量按有序的形式组织起来的一种形式。这些按序排列的同类数据元素的集合称之为数组。
%  （1）矩阵是数学的概念，而数组是计算机程序设计领域的概念；在数学上，定义m×n个数{a_{ij}}(i=1, 2…, m ; j=1, 2,… n)排成的m行n列的数表示为m行n列的矩阵
%  （2）作为一种变换或映射算符的体现，矩阵运算有着明确而严格的数学规则。而数组运算是Matlab软件定义的规则，其目的是为了使数据管理方便，操作简单，命令形式自然，执行计算有效。
%   二者联系主要体现在：在Matlab中，矩阵是以数组的形式存在的。因此，一维数组相当于向量；二维数组相当于矩阵。所以矩阵是数组的子集。

%% 高维矩阵的理解
% 一维数组（向量）看做某一本书中某一页的一行（一列）；
% 二维数组看做是由多行多列（多个一维数组）组成的一本书中的一页；
% 三维数组看做是由多页（多个矩阵）组成了一本书；
% 四维数组看做是由多本书（多个三维数组）组成了一个书架中的某一排.......
% 通俗的理解就是对2*2的矩阵的继续排列。

%% 理解一、三维数组的理解。三维数组三个坐标分别是行，列，页。

%% 理解二、其实就是数组里面套用数组的一个过程。例如矩阵的第一个元素需要是一个矩阵。

%% 1、直接通过函数声明多维矩阵。zeros、ones、rand等
% 这里是产生一个2*2*3的三维数组，它的输出包含三个2*2的矩阵
A = zeros(2,2,3);
disp(A);
% 这里是生产一个2*3的矩阵
B = zeros(2,3);
disp(B);

%% 2、直接利用索引方式生成多维矩阵。
% 这种方式生成了一个2*3*3的数组。
% 下面的代码先生成一个二维数组作为三维数组的第一页，然后通过数组直接索引，添加第二页、第三页。
C=zeros(2,3);
C(:,:,2) = ones(2,3);
C(:,:,3) = 4;

%% 3、利用函数reshape生成多维度数组。
B = reshape(A,2,9);    % 通过该函数将A数组转换成一个2*9的数组
% B = [A(:,:,1) A(:,:,2) A(:,:,3)]; % 结果与reshape(A,2,9)一样。
reshape(B,2,3,3);        % 通过该函数将数组D转化为一个2*3*3的三维矩阵
reshape(B,[2 3 3]);      % 结果与reshape(B,2,3,3);一样。

%% 4、利用函数repmat生成多维度数组
% repmat是通过数组复制创建多维数组的，是将数组C在行维和列维分别复制一次，然后再页维复制三次得到2×3×3的三维数组。
%  里面的数字则表示在行列上复制多少次。注意和reshape的区别。
D = ones(2,3);
repmat(D,[1 1 3]);% repmat写出类似reshape的repmat(C,1,1,3)将显示出错。
E = repmat(2,3,4);% 此处表示以第一个元素为基准，复制一个2*3的数组。其中第一个也可以是矩阵。

%% 5、利用cat函数创建多维数组,
a=zeros(2);
b=ones(2);
c=repmat(2,2,2);
F = cat(3,a,b,c);% 这里就是创建一个三维的数组，分别第一页为a，第二页为b，第三页为c。
%         (加入每页的维度不同可不可以？),不可以，必须保持维度相同。
% 下面这个数组因为是一页的，所以也可以给每本书增加页数。例如G(:,:,2,3) = [2 2;2
% 2]，此时是怎加第三本书的第二页，但是前面的书也会增加页数，用0补齐
G = cat(4,a,b,c);   % 创建一个四维数组，这样出来的结果和F一样，怎么理解。可能相当于这个时候是一个以三个数组为基础，创建一个四本书，每本一页的数组。


