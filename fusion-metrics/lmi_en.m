function entropy=lmi_en(img)
%% 用于计算img的熵


[row,column]=size(img);
total= row*column;
b=max(max(img));  %最大灰度级
counter=zeros(1,b+1);   %用于存储每个灰度值的像素数
grey_img=img+1;    %灰度级
for i=1:row
    for j=1:column
        indexx= grey_img(i,j);   %（i,j）处的灰度值
        counter(indexx)=counter(indexx)+1;    %counter存储灰度为indexx的像素点个数
    end
end
%上述代码得到图像的灰度直方图
% total= sum(counter(:));  %总的像素点数,与第7行重复
index = find(counter~=0);
 p = counter/total;    %每个灰度值所占的比例
entropy= sum(sum(-p(index).*log2(p(index))));   