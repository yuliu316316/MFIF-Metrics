function [dblock]=lmi_dblocks(block,x11,y11,r,c)
%% LMI的子函数，实现块的分割 
% block:待分割的图像块；r,c为该图像块的行数和列数
% x11，y11为其左上角初始位置的行号和列号
% 输出dblock为元胞数组，用来存储分割得到的四个子图像的初始行号、列号和高、宽、熵
% 11：左上角   12：右上角   21：左下角   22：右下角   

dblock=cell(1,4);   % dblock为1*4的元胞数组，用来存储分割后的四个子图像的相关信息

    if r>2 & c>2
        w11=floor(c/2);   %左上角子图像的宽
        h11=floor(r/2);   %左上角子图像的高
        block11=zeros(h11,w11);
        for i=x11:x11+h11-1    %行
            for j=y11:y11+w11-1    %列
                block11(i-x11+1,j-y11+1)=block(i,j);
            end
        end
        b11=uint8(block11);
        en11=entropy(b11);
        dblock{1}=[x11,y11,h11,w11,en11];  %左上角子图像的初始位置行号、列号和高、宽、熵
        
        x12=x11;  %右上角子图像的初始行号/纵坐标
        y12=y11+w11;      %右上角子图像的初始列号/横坐标        
        h12=h11;
        w12=ceil(c/2);
        block12=zeros(h12,w12);
        for i=x12:x12+h12-1
            for j=y12:y12+w12-1
                block12(i-x12+1,j-y12+1)=block(i,j);
            end
        end
        b12=uint8(block12);
        en12=entropy(b12);
        dblock{2}=[x12,y12,h12,w12,en12];  %右上角子图像的初始位置行号、列号和高、宽、熵
        
        x21=x11+h11;   %左下角子图像的初始行号
        y21=y11;       %左下角子图像的初始列号
        w21=w11;
        h21=ceil(r/2);
        block21=zeros(h21,w21);
        for i=x21:x21+h21-1
            for j=y21:y21+w21-1
                block21(i-x21+1,j-y21+1)=block(i,j);   %这一行有问题，行号溢出，待查17：18，已
                                        
            end
        end
        b21=uint8(block21);
        en21=entropy(b21);
        dblock{3}=[x21,y21,h21,w21,en21];  %%左下角子图像的初始位置行号、列号和高、宽、熵
        
        x22=x21;
        y22=y12;
        w22=w12;
        h22=h21;
        block22=zeros(h22,w22);
        for i=x22:x22+h22-1
            for j=y22:y22+w22-2
                block22(i-x22+1,j-y22+1)=block(i,j);
            end
        end
        b22=uint8(block22);
        en22=entropy(b22);
        dblock{4}=[x22,y22,h22,w22,en22];  %右下角子图像的初始位置行号、列号和高、宽、熵
    end
    
        % 分割得到的四个子图像块的长宽规律：
    %       左上角和左下角（右上角和右下角）图像同宽
    %       左上角和右上角（左下角和右下角）图像同高
    % 20120216 09：00 
