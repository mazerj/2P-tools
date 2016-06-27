function roi = roi_def(s)
%function roi = roi_def(s)
%
% define roi
%

f = figure;
try
  imagesc(max(s.g, [], 3));
  %imagesc(mean(s.g, 3));
  axis image;
  [roi.mask, roi.x, roi.y] = roipoly;
end
if f == gcf
  close(f);
end

