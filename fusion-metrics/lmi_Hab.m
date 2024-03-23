function HabR=lmi_Hab(A,B)
% compute mutural information of the image A and B
% 
% ---------
[row,column]=size(A);
%mingray=min(min(min(A)),min(min(B)));
maxgray=max(max(max(A)),max(max(B)));
grayl=maxgray+1;
counter = zeros(grayl,grayl);
%统计直方图
A=A+1;
B=B+1;
for i=1:row
    for j=1:column
        indexx = A(i,j);   %%% A在（i,j）处的灰度值
        indexy = B(i,j);   %%% B在（i,j）处的灰度值
        counter(indexx,indexy) = counter(indexx,indexy)+1;   %%%  联合直方图
    end
end
%计算联合信息熵
total= sum(counter(:));
index = find(counter~=0);   %%% 所有不为零的灰度
p = counter/total;  %%% 各灰度值所占比例，即对灰度直方图标准化
HabR = sum(sum(-p(index).*log2(p(index))));
        
        
