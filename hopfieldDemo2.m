clc;
clear;
%% 输入图像人
I_p = imread('2.jpg');       %输入第一张图像
[m,n,index] = size(I_p);
if (index == 3)
    I_p = rgb2gray(I_p);
end
%% 图像二值化
thresh_p1 = graythresh(I_p);     %自动确定二值化阈值  
I_p2 = im2bw(I_p,thresh_p1);       %对图像二值化
II_p2 = double(I_p2);           %logical转double
I_pin = guiyi(II_p2,m,n); %图像归一到-1和1
%% 图像模糊加噪
H_p = fspecial('motion',20,30); %运动卷积的偏移矩阵
Ig_p = imfilter(I_p,H_p); %卷积
%% 加噪图像二值化
thresh_p2 = graythresh(Ig_p);     %自动确定二值化阈值  
Ig_p2 = im2bw(Ig_p,thresh_p2);       %对图像二值化  
Igg_p2 = double(Ig_p2);
I_pnoise = guiyi(Igg_p2,m,n);
%% 输入图像水果
I_f = imread('3.jpg');
[m,n,index] = size(I_f);
if (index == 3)
    I_f = rgb2gray(I_f);
end
%% 图像二值化
thresh_f1 = graythresh(I_f);     %自动确定二值化阈值  
I_f2 = im2bw(I_f,thresh_f1);       %对图像二值化
II_f2 = double(I_f2);           %logical转double

I_fin = guiyi(II_f2,m,n); %图像归一到-1和1
%% 图像模糊加噪
H_f = fspecial('motion',20,30); %运动卷积的偏移矩阵
Ig_f = imfilter(I_f,H_f); %卷积
%% 加噪图像二值化
thresh_f2 = graythresh(Ig_f);     %自动确定二值化阈值  
Ig_f2 = im2bw(Ig_f,thresh_f2);       %对图像二值化  
% Igg_f2 = double(Ig_f2);
% I_fnoise = guiyi(Igg_f2,m,n);
shi = zeros(m,n);
Igg_f2 = double(shi);
I_fnoise = guiyi(Igg_f2,m,n);
array1 = cell(1,m);%每一个元素代表图像的一行
for i = 1:m
    array1{1,i}=  [I_pin(i,:)',I_fin(i,:)'];%原始图像每行转列
end

for i = 1:m
    arrayp1{1,i} = I_pnoise(i,:)';%模糊图片每行转列
    arrayf1{1,i} = I_fnoise(i,:)';
end
% 
for i = 1:m
    array{1,i} = mynewhop(array1{1,i},arrayf1{1,i});%霍夫菲尔德记忆联想
end
for i = 1:m
    arr{i} = array{1,i}{1,30};%稳定到能量最低点
end
I_out = zeros(m,n);
for i = 1:m
    I_out(i,:) = arr{i}; %输出联想后的图像
end

AAA = (I_out - I_fin);
AAA = mse(AAA);
%% 输出图像
% figure()
% subplot(2,3,1)
% imshow(I_f)
% title('原始图像');
% subplot(2,3,4)
% imshow(I_fin)     
% title('原始图像二值化');
% subplot(2,3,2)
% imshow(Ig_f)     
% title('噪声图像');
% subplot(2,3,5)
% imshow(I_fnoise)   
% title('噪声图像二值化');
% subplot(2,3,3)
% imshow(I_out)
% title(['记忆联想图像 mse = ' num2str(AAA)]);
figure(1)
imshow(I_f)
title('原始图像');
figure(2)
imshow(I_fin) 
title('原始图像二值化');
figure(3)
imshow(Ig_f)
title('噪声图像');
figure(4)
imshow(I_fnoise)
title('噪声图像二值化');
figure(5)
imshow(I_out)
title(['记忆联想图像 mse = ' num2str(AAA)]);