clear all;
close all;
%clc;
addpath(genpath('FR-IQA'));

num_alg=30;
num_img=710;
Q=zeros(num_alg,num_img);

for kk=1:num_img
disp(kk)
k=mod(mod(kk,100),10);
v=floor(mod(kk,100)/10);
h=floor(kk/100);

namer=['data/Real-MFF/Fusion/' num2str(h) num2str(v) num2str(k) '_F.png'];
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

R=imread(namer); 
F=imread(namef{i});

if size(R,3)>1
   R=rgb2gray(R);F=rgb2gray(F); 
end
imgr=double(R);imgf=double(F);

Q(i,kk)=PSNR(imgr,imgf);
% Q(i,kk)=ssim_index(imgr,imgf);
% Q(i,kk)=GMSD(imgr,imgf);

end
end

xlswrite('GT_psnr.xlsx',Q);
% xlswrite('GT_ssim.xlsx',Q);
% xlswrite('GT_gmsd.xlsx',Q);