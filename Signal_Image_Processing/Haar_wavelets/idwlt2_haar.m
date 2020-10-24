function Im = idwlt2_haar(B,H,V,D,c,d)

%upsampling
Iml = [B;H];
Imr = [V;D];
Im = [B V;H D];

%opposite to creation, so first Rows
for i = 1:size(Im,1)
    x = idwlt_haar(Iml(i,:),Imr(i,:),c,d);
    Im(i,:) = x;
end

Imu = [Im(1:size(Im,1)/2,1:end)];
Imd = [Im(size(Im,1)/2+1:end,1:end)];

%Now columns
for i = 1:size(Im,2)
    x = idwlt_haar(Imu(:,i),Imd(:,i),c,d);
    Im(:,i) = x.';
end