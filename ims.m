function ims(im, ti)
%function ims(im, ti)
%
% Show image nicely with optional title. If image
% is actual a volume, then it gets compressed (mean)
% along the 3rd dimension and drawn.
%

if ~exist('ti', 'var')
  ti = '';
end

if length(size(im)) == 3
  im = mean(im, 3);
  ti = ['(mean)' ti];
end

imagesc(im);
axis image;
colorbar;

if exist('ti', 'var')
  title(ti);
end

