function Im = idwlt2_Daubechies(B,H,V,D,n)

[h,g] = dbfilter(n);

%upsampling
Iml = [B;H];
Imr = [V;D];
Im = [B V;H D];

%discreteWaveletreconstruction(a,d,Lp_r,Hp_r)
%opposite to creation, so first Rows
for i = 1:size(Im,1)
    x = discreteWaveletreconstruction(Iml(i,:),Imr(i,:),h,g);
    Im(i,:) = x;
end

Imu = [Im(1:size(Im,1)/2,1:end)];
Imd = [Im(size(Im,1)/2+1:end,1:end)];

%Now columns
for i = 1:size(Im,2)
    x = discreteWaveletreconstruction(Imu(:,i),Imd(:,i),h,g);
    Im(:,i) = x.';
end