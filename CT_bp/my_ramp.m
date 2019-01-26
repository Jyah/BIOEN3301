function [sinof,n,hs] = my_ramp(sino)
%% Ramp Filter
[nth, ns] = size(sino); % assuming y-axis is projection angles
dp = 0.1;
n = -floor(ns-1)/2:floor(ns-1)/2;
hs = zeros(length(n),1);
hs(1:ns) = -2./(pi.^2*dp.^2*(4.*n.*n-1)).*dp.*dp;
sinof = zeros(nth,ns); % filtered sinogram
filter = repmat(hs,[1 nth]);
for ith = 1: nth
  ft = conv(sino(ith,:),filter(:,ith),'full');
  sinof(ith,:) = ft(floor(ns/2+1):floor(3/2*ns));
end
end
