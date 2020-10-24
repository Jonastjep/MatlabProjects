%  Calculates the wavelet transform of x with (decomposition) low-pass filter c and
%  (decomposition) high-pass filter d. x is assumed to be divisible by 2.
function s = idwlt_haar(a,b,c,d)

% upsample
au = reshape(a,1,[]);
au(2,:) = 0;
au = [reshape(au,1,[])];

bu = reshape(b,1,[]);
bu(2,:) = 0;
bu = [reshape(bu,1,[])];

% reconstruct
ar=filter(c,1,au);
%had to inverse the signs of the lowpass filter
br=filter(-d,1,bu);

% combine
s = ar+br;