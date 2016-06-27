function y = roi_extract(s, roi)
%function y = roi_extract(s)
%
% extract time series from roi
%

y = [];
ar = sum(sum(roi.mask > 0));
for n = 1:size(s.g, 3)
  y = [y sum(sum(s.g(:,:,n) .* roi.mask)) ./ ar];
end
