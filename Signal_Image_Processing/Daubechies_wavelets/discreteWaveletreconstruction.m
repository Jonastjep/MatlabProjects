%% s = discreteWaveletReconstruction(a,d,Lp_r,Hp_r)
%
%  Calculates a single scale of the inverse discrete wavelet transform of a
%  and b using the inverse low-pass filter Lp_r and the inverse high-pass 
%  filter Hp_r. The output s is the reconstructed signal.
%
function s = discreteWaveletreconstruction(a,d,Lp_r,Hp_r)

% We start by determining the lengths of the signal S and the filter F.
a=a(:);d=d(:);
m=length(a)+length(d);
n=length(Lp_r);


if(n~=length(Hp_r))
    error('Low-pass and high-pass filter should have the same length');
end
if(floor(n/2)<(n/2))
    error('Filter lengths should be even');
end


% Ensure periodic extension
%wrap=round(n/4)-1;

% Upsample approximation signal

au = reshape(a,1,[]);
au(2,:) = 0;
au = [reshape(au,1,[])];

%p_a=[au(length(au)-wrap+1:end,:);au;au(1:wrap,:)];

a_f = sqrt(2)*filter(fliplr(Lp_r),[1 zeros(1,n-1)],au);

bu = reshape(d,1,[]);
bu(2,:) = 0;
bu = [reshape(bu,1,[])];

%p_d=[bu(length(bu)-wrap+1:end,:);bu;bu(1:wrap,:)];

d_f = sqrt(2)*filter(fliplr(Hp_r),[1 zeros(1,n-1)],bu);

s = a_f + d_f;
