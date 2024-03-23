function [decomp]=lmi_qt1(I)
%% ʵ�ֻ����Ĳ����ֽ�ľֲ�������ϢLMI�е��Ĳ����ֽ�
% ��Ԫ������洢ÿ��������Ͻ�����ͳ���
%I=A;
[row,column]=size(I);
clength=max(floor(log2(row)),floor(log2(column)));  %%���ڴ洢�ֽ��ͼ������ʹ�С��Ԫ�����鳤��
mindim=4;
l=clength-mindim/2;   %�ֽ����
decomp=cell(l,1);   %����һάԪ�����飬���Դ洢�ֽ���ͼ����������
% decomp�д洢�������ڴ洢ÿ��Сͼ������ݵ�Ԫ�����飬
% �����������ͼ��ָ�Լ��Լϸ����4����������������Ϊ4��16��64��256��1024...,4^clength
r=row;   %���ó�ʼ�������
c=column;
x11=1;
y11=1;

dblock1=lmi_dblocks(I,x11,y11,r,c);
decomp{1}=dblock1;    %�ѵ�һ�ηֽ�Ľ������Ԫ������decomp�ĵ�һ��Ԫ���У��ܹ��ĸ���Ԫ����


%% ����Ĵ��������Ե�level���������ͼ��ÿ�ĸ�һ������������stopen
for level=1:l    

    sumen=zeros(1,length(decomp{level})/4);
    stopen=zeros(1,length(decomp{level})/4);
    
    for j=1:length(decomp{level})/4    %����ֲ�������
        for k=1:4            
            sumen(j)=sumen(j)+decomp{level}{(j-1)*4+k}(5);  %������������
        end
        stopen(j)=sumen(j)/4;
    end

    % ����Ĵ�����������ͼ�����ش��ڽ�����ʱ����������Ĳ����ֽ⣬���ѷֽ����洢��dblock��
    dblock=cell(1,length(decomp{level}));
   indexdecomp =zeros(1,length(decomp{level}));   %������סdecomp{level}����Щ�ѱ��ٴηֽ��Ԫ�صı��
    for k=1:length(decomp{level})/4
        for kk=1:4
            if decomp{level}{(k-1)*4+kk}(5)>=stopen(k)
                r=decomp{level}{(k-1)*4+kk}(3);    %% ��ͼ���ĸ�
                c=decomp{level}{(k-1)*4+kk}(4);    %% ��ͼ���Ŀ�
                x11=decomp{level}{(k-1)*4+kk}(1);
                y11=decomp{level}{(k-1)*4+kk}(2);
                indexdecomp((k-1)*4+kk)=1;   %��ס��Щ�ѱ��ٴηֽ��Ԫ�صı��
                dblock{(k-1)*4+kk}=lmi_dblocks(I,x11,y11,r,c);   %��Щ����ֽ���ӿ���dblock�ж�Ӧ��Ԫ������Ԫ��Ϊ��
            end
        end
    end

   %����Ĵ��������������decomp��level�����ѱ��ٴηֽ��Ԫ�ء�
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
   % ����Ĵ�����������dblock�еĿ�Ԫ�����飬�������зǿ�Ԫ�����δ���ddd��
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
   % ����Ĵ���������ddd�е�Ƕ�������������˳�����decomp����һ���� 
    for ii=1:length(ddd)
        for jj=1:4           
            decomp{level+1}{(ii-1)*4+jj}=ddd{ii}{jj};
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%20120221 09��30
end
    