function [sl, sh] = lowpass1(s, lambda, npad)

% lowpass -- Lowpass filter image and return low and high frequency
%            components, consisting of the lowpass filtered image and
%            its difference with the input image. The lowpass filter
%            is equivalent to Tikhonov regularization with lambda as
%            the regularization parameter and a discrete gradient as
%            the operator in the regularization term.
%
% Usage:
%       [sl, sh] = lowpass(s, lambda, npad)
%
% Input:
%       s         Input image or 3d array of images
%       lambda    Regularization parameter controlling lowpass filtering
%       npad      Number of samples to pad at image boundaries
%  
% Output:
%       sl        Lowpass component
%       sh        Highpass component
%
%   
% Author: Brendt Wohlberg <brendt@lanl.gov>  Modified: 2015-04-09
%
% This file is part of the SPORCO library. Details of the copyright
% and user license can be found in the 'License' file distributed with
% the library.


if nargin < 3,
  npad = 16;
end

grv = [-1 1];
gcv = [-1 1]';
g1m = [-1 0; 0  1];
g2m = [ 1 0; 0 -1];
g3m = [0  1;-1 0];
g4m = [0 -1; 1 0];
Gr = fft2(grv, size(s,1)+2*npad, size(s,2)+2*npad);
Gc = fft2(gcv, size(s,1)+2*npad, size(s,2)+2*npad);
G1 = fft2(g1m, size(s,1)+2*npad, size(s,2)+2*npad);
G2 = fft2(g2m, size(s,1)+2*npad, size(s,2)+2*npad);
G3 = fft2(g3m, size(s,1)+2*npad, size(s,2)+2*npad);
G4 = fft2(g4m, size(s,1)+2*npad, size(s,2)+2*npad);
A = 1 + lambda*conj(Gr).*Gr + lambda*conj(Gc).*Gc+ lambda*conj(G1).*G1+ lambda*conj(G2).*G2+ lambda*conj(G3).*G3+ lambda*conj(G4).*G4;
sp = padarray(s, [npad npad], 'symmetric', 'both');
slp = ifft2(bsxfun(@rdivide, fft2(sp), A), 'symmetric');
sl = slp((npad+1):(size(slp,1)-npad), (npad+1):(size(slp,2)-npad), :);
sh = s - sl;

return
