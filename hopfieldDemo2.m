clc;
clear;
%% ����ͼ����
I_p = imread('2.jpg');       %�����һ��ͼ��
[m,n,index] = size(I_p);
if (index == 3)
    I_p = rgb2gray(I_p);
end
%% ͼ���ֵ��
thresh_p1 = graythresh(I_p);     %�Զ�ȷ����ֵ����ֵ  
I_p2 = im2bw(I_p,thresh_p1);       %��ͼ���ֵ��
II_p2 = double(I_p2);           %logicalתdouble
I_pin = guiyi(II_p2,m,n); %ͼ���һ��-1��1
%% ͼ��ģ������
H_p = fspecial('motion',20,30); %�˶������ƫ�ƾ���
Ig_p = imfilter(I_p,H_p); %���
%% ����ͼ���ֵ��
thresh_p2 = graythresh(Ig_p);     %�Զ�ȷ����ֵ����ֵ  
Ig_p2 = im2bw(Ig_p,thresh_p2);       %��ͼ���ֵ��  
Igg_p2 = double(Ig_p2);
I_pnoise = guiyi(Igg_p2,m,n);
%% ����ͼ��ˮ��
I_f = imread('3.jpg');
[m,n,index] = size(I_f);
if (index == 3)
    I_f = rgb2gray(I_f);
end
%% ͼ���ֵ��
thresh_f1 = graythresh(I_f);     %�Զ�ȷ����ֵ����ֵ  
I_f2 = im2bw(I_f,thresh_f1);       %��ͼ���ֵ��
II_f2 = double(I_f2);           %logicalתdouble

I_fin = guiyi(II_f2,m,n); %ͼ���һ��-1��1
%% ͼ��ģ������
H_f = fspecial('motion',20,30); %�˶������ƫ�ƾ���
Ig_f = imfilter(I_f,H_f); %���
%% ����ͼ���ֵ��
thresh_f2 = graythresh(Ig_f);     %�Զ�ȷ����ֵ����ֵ  
Ig_f2 = im2bw(Ig_f,thresh_f2);       %��ͼ���ֵ��  
% Igg_f2 = double(Ig_f2);
% I_fnoise = guiyi(Igg_f2,m,n);
shi = zeros(m,n);
Igg_f2 = double(shi);
I_fnoise = guiyi(Igg_f2,m,n);
array1 = cell(1,m);%ÿһ��Ԫ�ش���ͼ���һ��
for i = 1:m
    array1{1,i}=  [I_pin(i,:)',I_fin(i,:)'];%ԭʼͼ��ÿ��ת��
end

for i = 1:m
    arrayp1{1,i} = I_pnoise(i,:)';%ģ��ͼƬÿ��ת��
    arrayf1{1,i} = I_fnoise(i,:)';
end
% 
for i = 1:m
    array{1,i} = mynewhop(array1{1,i},arrayf1{1,i});%����ƶ��¼�������
end
for i = 1:m
    arr{i} = array{1,i}{1,30};%�ȶ���������͵�
end
I_out = zeros(m,n);
for i = 1:m
    I_out(i,:) = arr{i}; %���������ͼ��
end

AAA = (I_out - I_fin);
AAA = mse(AAA);
%% ���ͼ��
% figure()
% subplot(2,3,1)
% imshow(I_f)
% title('ԭʼͼ��');
% subplot(2,3,4)
% imshow(I_fin)     
% title('ԭʼͼ���ֵ��');
% subplot(2,3,2)
% imshow(Ig_f)     
% title('����ͼ��');
% subplot(2,3,5)
% imshow(I_fnoise)   
% title('����ͼ���ֵ��');
% subplot(2,3,3)
% imshow(I_out)
% title(['��������ͼ�� mse = ' num2str(AAA)]);
figure(1)
imshow(I_f)
title('ԭʼͼ��');
figure(2)
imshow(I_fin) 
title('ԭʼͼ���ֵ��');
figure(3)
imshow(Ig_f)
title('����ͼ��');
figure(4)
imshow(I_fnoise)
title('����ͼ���ֵ��');
figure(5)
imshow(I_out)
title(['��������ͼ�� mse = ' num2str(AAA)]);