function B = my_bpj(sino,thetas,mov)
if mov
  figure;colormap gray;
  figure;
  mkdir('output');
end
%% Back Projection 
[nth,ns] = size(sino);
nx = ns;ny = ns;
xoff = round(ns/2); 
yoff = xoff;
dx = 1;dy = dx;
radius = xoff;
B = zeros(ny,nx);
xc = ((0:nx-1)-xoff)*dx;
yc = ((0:ny-1)-yoff)*dy;
[xcoord,ycoord] = meshgrid(xc,yc);
fov = find((xcoord.^2+ycoord.^2)<(radius*radius));
soff = floor(ns/2);
ds = 1;
sc = ((0:ns-1)-soff)*ds;
for ith = 1:nth %backproject each projection angle
  sxy = xcoord(fov)*cos(thetas(ith)*pi/180)+ycoord(fov)*sin(thetas(ith)*pi/180);
  B(fov) = B(fov)+interp1(sc',sino(ith,:),sxy,'spline',0)*pi/nth;
  if mov
    imagesc(B);axis image;colormap gray;
    title('Backprojection');axis off;
    fname = sprintf('output%sbp_%d.png',filesep,ith);
    saveas(gcf,fname);
%     pause(0.0001);
  end
end
end
