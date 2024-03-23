function [qtmi,et]=LMI(I1,I2,F,alpha)
%% ʵ�ֻ����Ĳ����ֽ�ľֲ�������Ϣ
% �ο����� M. Hossny, S. Nahavandi, D. Creighton, and A. Bhatti, 
%��Image fusion performance metric based on mutual information and 
%  entropy driven quadtree decomposition,�� Electronics Letters, 
% vol. 46, no. 18, pp. 266 �C1268, sep. 2010.
% ˼·����ͼ������Ĳ����ֽ⣬���ÿ��������Ƿ���ڸ�����ֵ������������������ֽ�
% �ظ���һ���̣�ֱ�����п鶼���������ֵ������С�����ٷֽ�Ϊֹ

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