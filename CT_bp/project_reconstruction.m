clc;clear;close all;
%% create phantom
im = phantom('Modified Shepp-Logan',400);
figure;
imshow(im);
title('Phantom');
%% radon transform
theta = linspace(0,180,300);
sino = radon(im,theta);
figure;
imagesc(sino);axis image;colormap gray;
title('Sinogram');
%% ramp filtering
[sinof,n,hs] = my_ramp(sino');
sinob = sinof(:,end:-1:1);
figure;
imagesc(sinob);axis image;colormap gray;
title('Filtered Sinogram');
%% back projection
FB = my_bpj(sinob,theta,1);

