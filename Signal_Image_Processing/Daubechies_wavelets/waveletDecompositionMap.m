%% waveletDecompositionMap
%
% Creates a graphical representation of the discrete wavelet decomposition
% of a signal.
% 
% Parameters:
%   wd      The wavelet decomposition of the signal up to a given level.
%           The format is equal to the output format of the 'wavedec'
%           functions with periodic extension mode.
%   levels  The number of levels over which the wavelet decomposition has
%           been calculated
%   slength The original signal length, which is a power of two
%
% Return values:
%   im     A representation of the wavelet decomposition that can be
%           displayed with imagesc(im)
%
% Version 1.1
% 3 May 2005
% Created for Matlab 7 (R14) sp1
%
% Copyright
% Joël Karel
% Universiteit Maastricht
% Dept. Mathematics
% 25 April 2005
% joelkarel@ieee.org
% http://www.math.unimaas.nl/biosens/
%
function im = waveletDecompositionMap(wd,levels,slength)

% Initialize the map
im = zeros(levels+1,slength);

%% Create the representation
for cnt1 = 1:levels,
    start=slength/(2^cnt1);
    for cnt2 = 1:slength/(2^cnt1),
        im(2+levels-cnt1,1+(cnt2-1)*2^cnt1:cnt2*2^cnt1)=wd(start+cnt2);
    end
end

for cnt2 = 1:slength/(2^cnt1),
    im(1,1+(cnt2-1)*2^cnt1:cnt2*2^cnt1)=wd(cnt2);
end

% eof