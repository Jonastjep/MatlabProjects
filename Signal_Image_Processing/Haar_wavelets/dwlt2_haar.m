%  Calculates the 2D wavelet transform of image I with low-pass filter c 
%  and high-pass filter d. I is assumed to have dimensions divisible by 2.
function [B,H,V,D] = dwlt2_haar(I,c,d)

Im = I;

%COLUMNS
for i = 1:size(I,2)
    [a,b] = dwlt_haar(Im(:,i).',c,d);
    Im(:,i) = [a b].';
end

%ROWS
for i = 1:size(I,1)
    [a,b] = dwlt_haar(Im(i,:),c,d);
    Im(i,:) = [a b];
end

B = Im(1:size(I,1)/2,1:size(I,2)/2);
V = Im(1:size(I,2)/2,size(I,1)/2+1:end);
H = Im(size(I,1)/2+1:end,1:size(I,2)/2);
D = Im(size(I,1)/2+1:end,size(I,2)/2+1:end);