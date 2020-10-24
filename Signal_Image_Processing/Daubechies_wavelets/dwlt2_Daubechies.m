function [B,H,V,D] = dwlt2_Daubechies(I,n)

[h,g] = dbfilter(n);

Im = I;

%COLUMNS

for i = 1:size(I,2)
    [a,b] = discreteWaveletTransformCausal(Im(:,i).',h,g);
    Im(:,i) = [a.' b.'].';
end

%ROWS
for i = 1:size(I,1)
    [a,b] = discreteWaveletTransformCausal(Im(i,:),h,g);
    Im(i,:) = [a.' b.'];
end

B = Im(1:size(I,1)/2,1:size(I,2)/2);
V = Im(1:size(I,2)/2,size(I,1)/2+1:end);
H = Im(size(I,1)/2+1:end,1:size(I,2)/2);
D = Im(size(I,1)/2+1:end,size(I,2)/2+1:end);