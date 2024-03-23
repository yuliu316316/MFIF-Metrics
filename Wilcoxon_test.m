clear all;
close all;
clc;

num_metric = 20;
result=zeros(num_metric,num_metric);

%FR-IQA results using the GT fused image
A=xlsread('FR-IQA-results/GT_psnr.xlsx');
% A=xlsread('FR-IQA-results/GT_ssim.xlsx');
% A=xlsread('FR-IQA-results/GT_gmsd_neg.xlsx');

%Objective evaluation results of different fusion metrics
namef=cell(1,num_metric);
namef{1}='Metric-results/EN.xlsx';
namef{2}='Metric-results/SD.xlsx';
namef{3}='Metric-results/AG.xlsx';
namef{4}='Metric-results/SF.xlsx';
namef{5}='Metric-results/EI.xlsx';
namef{6}='Metric-results/Q_MI.xlsx';
namef{7}='Metric-results/Q_NCIE.xlsx';
namef{8}='Metric-results/Q_TE.xlsx';
namef{9}='Metric-results/Q_LMI.xlsx';
namef{10}='Metric-results/Q_FMI.xlsx';
namef{11}='Metric-results/Q_SCD.xlsx';
namef{12}='Metric-results/Q_G.xlsx';
namef{13}='Metric-results/Q_P.xlsx';
namef{14}='Metric-results/Q_W.xlsx';
namef{15}='Metric-results/Q_C.xlsx';
namef{16}='Metric-results/Q_Y.xlsx';
namef{17}='Metric-results/Q_CB.xlsx';
namef{18}='Metric-results/Q_CV_neg.xlsx';
namef{19}='Metric-results/Q_VIFF.xlsx';
namef{20}='Metric-results/Q_CNN.xlsx';

num_img=size(A,2);
SRCC=zeros(num_img,num_metric);
for i=1:num_metric
    B=xlsread(namef{i});
    for k=1:num_img
        SRCC(k,i)=corr(A(:,k),B(:,k),'type','Spearman'); 
    end
end

for i=1:num_metric
    for j=1:num_metric
        [p,h,stats]=signrank(SRCC(:,i),SRCC(:,j),'tail','both');
        if h==1&&stats.zval>0
            result(i,j)=1;
        elseif h==1&&stats.zval<0
            result(i,j)=-1;
        else
            result(i,j)=0;
        end
    end
end

disp(result)



