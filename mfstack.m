function s = mfstack(s, scale)
%function s = mfstack(s, scale)
%
% Median filter stack by median filtering each scan -- really
% continuous appliation of 2D median filtering.. This is actually
% appropriate, since it these are the points that are most proximal
% time.
%
%INPUT
%  s - input stack
%  scale - [scale scale] square filter region (default: 3x3)
%
%OUTPUT
%  s - filtered stack
%
if ~exist('scale', 'var')
  scale = 3;
end

for k = 1:size(s.g, 3)
  s.g(:, :, k) = medfilt2(s.g(:, :, k), [scale scale]);
end
