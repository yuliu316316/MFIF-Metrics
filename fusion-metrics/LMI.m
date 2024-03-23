function [qtmi,et]=LMI(I1,I2,F,alpha)
%% 实现基于四叉树分解的局部化互信息
% 参考文献 M. Hossny, S. Nahavandi, D. Creighton, and A. Bhatti, 
%“Image fusion performance metric based on mutual information and 
%  entropy driven quadtree decomposition,” Electronics Letters, 
% vol. 46, no. 18, pp. 266 –1268, sep. 2010.
% 思路：对图像进行四叉树分解，检查每个块的熵是否大于给定阈值，若满足条件则继续分解
% 重复这一过程，直至所有块都满足给定阈值，或块大小不能再分解为止

tic;
[decomp1]=lmi_qt1(I1);
[decomp2]=lmi_qt1(I2);
[decompf]=lmi_qt1(F);
[miafd,miaf]=lmi_mi(I1,F,decomp1,alpha);
[mifad,mifa]=lmi_mi(F,I1,decompf,alpha);
[mibfd,mibf]=lmi_mi(I2,F,decomp2,alpha);
[mifbd,mifb]=lmi_mi(F,I2,decompf,alpha);
qtmi=(miaf+mifa+mibf+mifb)/2;
et=toc;