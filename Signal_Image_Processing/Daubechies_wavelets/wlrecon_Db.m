function C_rec = wlrecon_Db(C,N,n)

[h,g] = dbfilter(n);

C_rec = C;

for i = N:-1:1
    nbVal = length(C)/2^i;
    C_rec(1:2*nbVal) = discreteWaveletreconstruction(C_rec(1:nbVal),C_rec(nbVal+1:2*nbVal),h,g);
end