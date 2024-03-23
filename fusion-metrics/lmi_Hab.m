function HabR=lmi_Hab(A,B)
% compute mutural information of the image A and B
% 
% ---------
[row,column]=size(A);
%mingray=min(min(min(A)),min(min(B)));
maxgray=max(max(max(A)),max(max(B)));
grayl=maxgray+1;
counter = zeros(grayl,grayl);
%ͳ��ֱ��ͼ
A=A+1;
B=B+1;
for i=1:row
    for j=1:column
        indexx = A(i,j);   %%% A�ڣ�i,j�����ĻҶ�ֵ
        indexy = B(i,j);   %%% B�ڣ�i,j�����ĻҶ�ֵ
        counter(indexx,indexy) = counter(indexx,indexy)+1;   %%%  ����ֱ��ͼ
    end
end
%����������Ϣ��
total= sum(counter(:));
index = find(counter~=0);   %%% ���в�Ϊ��ĻҶ�
p = counter/total;  %%% ���Ҷ�ֵ��ռ���������ԻҶ�ֱ��ͼ��׼��
HabR = sum(sum(-p(index).*log2(p(index))));
        
        
