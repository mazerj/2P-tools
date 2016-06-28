function [y,yt] = roi_extract(s, roi)
%function [y,yt] = roi_extract(s)
%
% extract time series from roi
%

y = [];
ar = sum(sum(roi.mask > 0));
for n = 1:size(s.g, 3)
  y = [y sum(sum(s.g(:,:,n) .* roi.mask)) ./ ar];
end

z = (y - mean(y)) ./ std(y);
yt = max(1, z) - 1;
yt = z > 2;

