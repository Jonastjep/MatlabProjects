%% plotWaveletDecompositionMap
%
% plotWaveletDecompositionMap(wd,levels,signal)
%   Creates and displays a graphical representation of the discrete wavelet 
%   decomposition of a signal
% plotWaveletDecompositionMap(wd,levels,signal,noAppCoeff)
%   Creates and displays a graphical representation of the discrete wavelet 
%   decomposition of a signal, without showing the approximation coeffi-
%   cient in case the parameter noAppCoeff is equal to one.
% 
% Parameters:
%   wd      The wavelet decomposition of the signal up to a given level.
%           The format is equal to the output format of the 'wavedec'
%           functions with periodic extension mode. So it has the structure
%           wd      = [app. coef.(N)|det. coef.(N)|... |det. coef.(1)]
%   levels  The number of levels over which the wavelet decomposition has
%           been calculated
%   slength The length of the original signal, which is a power of two
%   noAppCoeff
%           1: Do not display approximation coefficient
%           0: Display approximation coefficient (default)
%           2: Auto
%
% Version 1.0
% 9 May 2005
% Created for Matlab 7 (R14) sp1
%
% Copyright
% Joël Karel
% Universiteit Maastricht
% Dept. Mathematics
% 9 May 2005
% joelkarel@ieee.org
% http://www.math.unimaas.nl/biosens/
%
function wm = plotWaveletDecompositionMap(varargin)

%% Determine parametrization and process parameters
if(length(varargin)>=3)
    wd=varargin{1};
    levels=varargin{2};
    slength=varargin{3};
    if(length(varargin)==4)
        noAppCoeff=varargin{4};
    else
        noAppCoeff=0;
    end
else
    error('Insufficient number of input parameters');
end


%% Create the map
wm=waveletDecompositionMap(wd,levels,slength);

%% Check potential problems
if(max(abs(wm(1,:)))>2*max(max(abs(wm(2:levels+1,:)))))
    warning('Approximation coefficient large in respect to detail coefficients; set noAppCoeff-parameter to 1 for better contrast');
    if(noAppCoeff==2)
        noAppCoeff=1;
        warning('noAppCoeff automatically adjusted to 1');
    end
end

    %% Display the representation
%create the ticks
if((noAppCoeff==0)|(noAppCoeff==2))
    ytcks=1:levels+1;
    ytckl=cell(1,levels+1);
    ytckl{1}=['A_' num2str(levels)];
    for cnt=1:levels,
        ytckl{levels-cnt+2}=['D_' num2str(cnt)];
    end
    imagesc(wm);
else
    ytcks=1:levels;
    ytckl=cell(1,levels);
    for cnt=1:levels,
        ytckl{levels-cnt+1}=['D_' num2str(cnt)];
    end
    imagesc(wm(2:levels+1,:));
end
set(gca,'YTickLabel',ytckl,'YTick',ytcks);
title('wavelet coefficients');

% eof