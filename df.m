function s = df(s, b)
% convert raw stack to delta-F values on the range 0-1, where 0.5
% is no change in F

if nargin > 1
  baseline = mean(b.g,3);
else
  % estimate baseline as mean-3sigma
  baseline = mean(s.g, 3) - 3.0 * std(s.g, 0, 3);
end

% compute fractional change in F re baseline -- these can now be
% +/- and is no longer bounded..
for k = 1:size(s.g, 3)
  s.g(:, :, k) = medfilt2((s.g(:, :, k) - baseline) ./ baseline);
end

% 'normalize' to keep in range [0,1] -- 0.5 = baseline
s.g = max(0, min(1, (s.g ./ (10 * std(s.g(:)))) + .5));
