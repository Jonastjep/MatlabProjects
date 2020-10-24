%% [a,d] = discreteWaveletTransform(s,Lp,Hp)
%
%  Calculates a single scale of the discrete wavelet transform of _s_, 
%  using the low-pass filter _Lp_ and high-pass filter _Hp_. The output _a_
%  are the approximation coefficients and _d_ the detail coefficients.
%  Periodic extension is used and it assumed that the length of the signal
%  _s_ is a power of 2.
%  Note that the high-pass filter usually relates to the low-pass filter by
%  means of the "alternating flip" construction.
%  For image processing purposes _s_ can be a matrix. The wavelet transform
%  is then calculated along the columns of _s_.
%
%  Joel Karel
%  Dept. Mathematics
%  Universiteit Maastricht
%  03-10-2006
function [a,d] = discreteWaveletTransformCausal(s,Lp,Hp)
 
% We start by determining the lengths of the signal S and the filter F.
m=size(s,1);
if(m==1)
    s=s';
    m=size(s,1);
end
n=length(Lp);
 
% Check some conditions
if(rem(log2(m),1)~=0)
    %error('Length of the input signal should be a power of 2');
    s=[s; zeros(2^ceil(log2(m))-m,size(s,2))];
    m=size(s,1);
end
if(size(s,2)~=1)%image
    if(rem(log2(size(s,2)),1)~=0)
        s=[s zeros(size(s,1),2^ceil(log2(size(s,2)))-size(s,2))];
    end
end
if(m<n)
    error('Length of the input signal should at least be as long as the length of the filter');
end
if(n~=length(Hp))
    error('Low-pass and high-pass filter should have the same length');
end
if(floor(n/2)<(n/2))
    error('Filter lengths should be even');
end
 
% Ensure periodic extension
wrap=n;
p=[s;s(1:wrap-1,:)];
 
% Low-pass filtering
a = sqrt(2)*filter(Lp,[1 zeros(1,n-1)],p);
% Downsampling
a = a(wrap:2:end,:);
       
% High-pass filtering
d = sqrt(2)*filter(Hp,[1 zeros(1,n-1)],p);
% Downsampling
d = d(wrap:2:end,:);