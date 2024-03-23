function [milevel,miab]=lmi_mi(A,B,ass,alpha)
%% ʵ��LMI�еĻ���Ϣ����
levels=length(ass);
milevel=cell(levels,1); % ���ڴ洢ÿһ����ͼ��Ļ���Ϣ
sumsize=0;
miab=0;
for level=1:levels
    ll=length(ass{level});
    for i=1:ll
        if size(ass{level}{i},1)>0
        x0 = ass{level}{i}(1);
        y0 = ass{level}{i}(2);
        h  = ass{level}{i}(3);
        w  = ass{level}{i}(4);
        x1 = x0+h-1;
        y1 = y0+w-1;
        A0=zeros(h,w);
        B0=zeros(h,w);
        for m=x0:x1
            for n=y0:y1
                A0(m-x0+1,n-y0+1)=A(m,n);
                B0(m-x0+1,n-y0+1)=B(m,n);
            end
        end
        ena0=lmi_en(A0);
        enb0=lmi_en(B0);
        hab0=lmi_Hab(A0,B0);
        miab0=2*(ena0+enb0-hab0)/(ena0+enb0+(1e-14));
        milevel{level}{i}(1)=miab0;   %A0��B0�Ļ���Ϣ
        milevel{level}{i}(2)=h*w;   %ͼ���Ĵ�С
                      
        miab=miab+(h*w)^alpha*miab0;
        sumsize=sumsize+(h*w)^alpha;
        end
    end
end

miab=miab/2/sumsize;

                
        