clear all;
close all;
%clc;
addpath(genpath('fusion-metrics'));

num_alg=30;
num_img=710;
Q=zeros(num_alg,num_img);

for kk=1:num_img
disp(kk)
k=mod(mod(kk,100),10);
v=floor(mod(kk,100)/10);
h=floor(kk/100);

name1=['data/Real-MFF/imageA/' num2str(h) num2str(v) num2str(k) '_A.png'];
name2=['data/Real-MFF/imageB/' num2str(h) num2str(v) num2str(k) '_B.png'];
namef=cell(1,num_alg);

namef{1}=['data/Fused-images/result_LP/' num2str(h) num2str(v) num2str(k) '_LP.png'];
namef{2}=['data/Fused-images/result_SIDWT/' num2str(h) num2str(v) num2str(k) '_SIDWT.png'];
namef{3}=['data/Fused-images/result_DTCWT/' num2str(h) num2str(v) num2str(k) '_DTCWT.png'];
namef{4}=['data/Fused-images/result_NSCT/' num2str(h) num2str(v) num2str(k) '_NSCT.png'];
namef{5}=['data/Fused-images/result_GFF/' num2str(h) num2str(v) num2str(k) '_GFF.png'];
namef{6}=['data/Fused-images/result_SR/' num2str(h) num2str(v) num2str(k) '_SR.png'];
namef{7}=['data/Fused-images/result_CSR/' num2str(h) num2str(v) num2str(k) '_CSR.png'];
namef{8}=['data/Fused-images/result_MWGF/' num2str(h) num2str(v) num2str(k) '_MWGF.png'];
namef{9}=['data/Fused-images/result_ICA/' num2str(h) num2str(v) num2str(k) '_ICA.png'];
namef{10}=['data/Fused-images/result_NSCT-SR/' num2str(h) num2str(v) num2str(k) '_NSCT-SR.png'];
namef{11}=['data/Fused-images/result_SSSDI/' num2str(h) num2str(v) num2str(k) '_SSSDI.png'];
namef{12}=['data/Fused-images/result_PC/' num2str(h) num2str(v) num2str(k) '_PC.png'];
namef{13}=['data/Fused-images/result_QUADTREE/' num2str(h) num2str(v) num2str(k) '_QUADTREE.png'];
namef{14}=['data/Fused-images/result_IMF/' num2str(h) num2str(v) num2str(k) '_IMF.png'];
namef{15}=['data/Fused-images/result_DSIFT/' num2str(h) num2str(v) num2str(k) '_DSIFT.png'];
namef{16}=['data/Fused-images/result_SRCF/' num2str(h) num2str(v) num2str(k) '_SRCF.png'];
namef{17}=['data/Fused-images/result_BF/' num2str(h) num2str(v) num2str(k) '_BF.png'];
namef{18}=['data/Fused-images/result_GFDF/' num2str(h) num2str(v) num2str(k) '_GFDF.png'];
namef{19}=['data/Fused-images/result_BRW/' num2str(h) num2str(v) num2str(k) '_BRW.png'];
namef{20}=['data/Fused-images/result_MISF/' num2str(h) num2str(v) num2str(k) '_MISF.png'];
namef{21}=['data/Fused-images/result_CNN/' num2str(h) num2str(v) num2str(k) '_CNN.png'];
namef{22}=['data/Fused-images/result_ECNN/' num2str(h) num2str(v) num2str(k) '_ECNN.png'];
namef{23}=['data/Fused-images/result_IFCNN/' num2str(h) num2str(v) num2str(k) '_IFCNN.png'];
namef{24}=['data/Fused-images/result_MADCNN/' num2str(h) num2str(v) num2str(k) '_MADCNN.png'];
namef{25}=['data/Fused-images/result_SMFuse/' num2str(h) num2str(v) num2str(k) '_SMFuse.png'];
namef{26}=['data/Fused-images/result_SESF/' num2str(h) num2str(v) num2str(k) '_SESF.png'];
namef{27}=['data/Fused-images/result_DRPL/' num2str(h) num2str(v) num2str(k) '_DRPL.png'];
namef{28}=['data/Fused-images/result_MSFIN/' num2str(h) num2str(v) num2str(k) '_MSFIN.png'];
namef{29}=['data/Fused-images/result_U2Fusion/' num2str(h) num2str(v) num2str(k) '_U2Fusion.png'];
namef{30}=['data/Fused-images/result_MFF-SSIM/' num2str(h) num2str(v) num2str(k) '_MFF-SSIM.png'];


for i=1:num_alg

A=imread(name1);B=imread(name2); 
F=imread(namef{i});

if size(A,3)>1
   A=rgb2gray(A);B=rgb2gray(B);F=rgb2gray(F); 
end
img1=double(A);img2=double(B);imgf=double(F);


% Q(i,kk)=EN(imgf,256);%EN
% Q(i,kk)=SD(imgf);%SD
% Q(i,kk)=AG(imgf);%AG
% Q(i,kk)=SF(imgf);%SF
% Q(i,kk)=metricsEdge_intensity(imgf);%EI
% Q(i,kk)=metricMI(img1,img2,imgf,1);%QMI
% Q(i,kk)=metricWang(img1,img2,imgf);%QNCIE
% Q(i,kk)=metricMI(img1,img2,imgf,2);%QTE
% Q(i,kk)=LMI(img1,img2,imgf,1);%QLMI  
% Q(i,kk)=fmi(img1,img2,imgf);%QFMI
% Q(i,kk)=analysis_SCD(img1,img2,imgf);%QSCD
% Q(i,kk)=metricXydeas(img1,img2,imgf);%QG
% Q(i,kk)=metricZhao(img1,img2,imgf);%QP
% Q(i,kk)=metricPeilla(img1,img2,imgf,2);%QW
% Q(i,kk)=metricCvejic(img1,img2,imgf,2);%QC
% Q(i,kk)=metricYang(img1,img2,imgf);%QY
% Q(i,kk)=metricChenBlum(img1,img2,imgf);%QCB
% Q(i,kk)=metricChen(img1,img2,imgf);%QCV
Q(i,kk)=VIFF_Public(img1,img2,imgf);%QVIFF

end
end

xlswrite('temp.xlsx',Q);