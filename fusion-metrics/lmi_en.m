function entropy=lmi_en(img)
%% ���ڼ���img����


[row,column]=size(img);
total= row*column;
b=max(max(img));  %���Ҷȼ�
counter=zeros(1,b+1);   %���ڴ洢ÿ���Ҷ�ֵ��������
grey_img=img+1;    %�Ҷȼ�
for i=1:row
    for j=1:column
        indexx= grey_img(i,j);   %��i,j�����ĻҶ�ֵ
        counter(indexx)=counter(indexx)+1;    %counter�洢�Ҷ�Ϊindexx�����ص����
    end
end
%��������õ�ͼ��ĻҶ�ֱ��ͼ
% total= sum(counter(:));  %�ܵ����ص���,���7���ظ�
index = find(counter~=0);
 p = counter/total;    %ÿ���Ҷ�ֵ��ռ�ı���
entropy= sum(sum(-p(index).*log2(p(index))));   