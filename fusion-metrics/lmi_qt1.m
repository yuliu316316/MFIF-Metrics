function [decomp]=lmi_qt1(I)
%% 实现基于四叉树分解的局部化互信息LMI中的四叉树分解
% 用元胞数组存储每个块的左上角坐标和长宽
%I=A;
[row,column]=size(I);
clength=max(floor(log2(row)),floor(log2(column)));  %%用于存储分解后图像坐标和大小的元胞数组长度
mindim=4;
l=clength-mindim/2;   %分解层数
decomp=cell(l,1);   %创建一维元胞数组，用以存储分解后的图像块相关数据
% decomp中存储的是用于存储每个小图像块数据的元胞数组，
% 其最大数量随图像分割约来约细而呈4的幂数增长，依次为4，16，64，256，1024...,4^clength
r=row;   %设置初始块的行数
c=column;
x11=1;
y11=1;

dblock1=lmi_dblocks(I,x11,y11,r,c);
decomp{1}=dblock1;    %把第一次分解的结果存入元胞数组decomp的第一个元素中，总共四个五元数组


%% 下面的代码用来对第level层的所有子图像每四个一组计算其截至熵stopen
for level=1:l    

    sumen=zeros(1,length(decomp{level})/4);
    stopen=zeros(1,length(decomp{level})/4);
    
    for j=1:length(decomp{level})/4    %计算局部截至熵
        for k=1:4            
            sumen(j)=sumen(j)+decomp{level}{(j-1)*4+k}(5);  %则计算其截至熵
        end
        stopen(j)=sumen(j)/4;
    end

    % 下面的代码用来在子图像块的熵大于截至熵时，对其进行四叉树分解，并把分解结果存储在dblock中
    dblock=cell(1,length(decomp{level}));
   indexdecomp =zeros(1,length(decomp{level}));   %用来记住decomp{level}中那些已被再次分解的元素的标号
    for k=1:length(decomp{level})/4
        for kk=1:4
            if decomp{level}{(k-1)*4+kk}(5)>=stopen(k)
                r=decomp{level}{(k-1)*4+kk}(3);    %% 子图像块的高
                c=decomp{level}{(k-1)*4+kk}(4);    %% 子图像块的宽
                x11=decomp{level}{(k-1)*4+kk}(1);
                y11=decomp{level}{(k-1)*4+kk}(2);
                indexdecomp((k-1)*4+kk)=1;   %记住那些已被再次分解的元素的标号
                dblock{(k-1)*4+kk}=lmi_dblocks(I,x11,y11,r,c);   %那些无须分解的子块在dblock中对应的元胞数组元素为空
            end
        end
    end

   %下面的代码用来消除输出decomp中level层中已被再次分解的元素。
    ltemp=length(decomp{level})-sum(indexdecomp);
    tempd=cell(1,ltemp);
    mm=1;
    for m=1:length(decomp{level})
        if indexdecomp(m)==0
            tempd{level}(mm)=decomp{level}(m);
            mm=mm+1;
        end
    end
    decomp{level}=tempd{level};
   % 下面的代码用来消除dblock中的空元胞数组，并把所有非空元素依次存入ddd中
    index=0;
    for ll=1:length(dblock)
        if ~isempty(dblock{ll})
            index=index+1;
        end
    end
    ddd=cell(1,index);
    jj=1;
    for ii=1:length(dblock)
        if ~isempty(dblock{ii})
            ddd{jj}=dblock{ii};
            jj=jj+1;
        end
    end
   % 下面的代码用来把ddd中的嵌套数据提出，按顺序存入decomp的下一层中 
    for ii=1:length(ddd)
        for jj=1:4           
            decomp{level+1}{(ii-1)*4+jj}=ddd{ii}{jj};
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%20120221 09：30
end
    