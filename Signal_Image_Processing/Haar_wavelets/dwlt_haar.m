function [a,b] = dwlt_haar(x,c,d)

%  Calculates the wavelet transform of x with low-pass filter c and
%  high-pass filter d. x is assumed to be divisible by 2.

a=filter(c,1,x);
b=filter(d,1,x);

%We always take from the second onwards, the first is kind of padding
%(check p.4 at the top Haar wavelet)
a = a(2:2:end);% perform downsampling
b = b(2:2:end);% perform downsampling

