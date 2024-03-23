function R=SD(A)

A=double(A);
R = mean(std(A)); %an approximation of std(A(:)) is used
