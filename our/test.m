clear all;
close all;
clc;
% numsize=3;
% for num=1:numsize
num=3;
path1= ['medical/CT-01',num2str(num-1),'.jpg'];
path2= ['medical/MRI-01',num2str(num-1),'.jpg'];
result_path= ['results/s01_',num2str(num-1),'.jpg'];

A=double(rgb2gray(imread(path1)))/255;
B=double(rgb2gray(imread(path2)))/255;
F = DLDCT_Fusion(img1, img2);
imwrite(F,result_path);