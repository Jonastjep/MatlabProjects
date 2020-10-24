function C = wldecom_Db(s,N,n)

[h,g] = dbfilter(n)

C = [];
a = s;
b = [];
for n = 1:N
    [a,b] = discreteWaveletTransformCausal(a,h,g);
    C = [b.' C];
end
C = [a.' C];