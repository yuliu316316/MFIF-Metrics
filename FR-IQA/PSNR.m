function  [psnr rmse]=PSNR(A,B)

if size(A)~=size(B)
    error('two images are not the same size')
end

if A==B
    error('two images are the same,their PSNR has infinite value')
end

A=double(A);
B=double(B);
diff=A-B;

rmse=sqrt(mean(mean(diff.*diff)));
psnr=20*log10(255/rmse);
