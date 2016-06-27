function preprocess(fname, force)
%function preprocess(fname, force)
%
% preprocess tiff image stack
%
%  - median filter each image in stack
%  - do simple motion correction
%

if ~exist('force', 'var')
  force = 0;
end
%out = [dirname(fname) '/_' basename(fname)];
out = strrep(fname, '.tif', '.mat');


if exist(out, 'file') && ~force
  fprintf('skipped %s\n', fname);
else
  fprintf('loading %s\n', fname);
  s = loadstack(fname);
  fprintf(' %d frames\n', size(s.g, 3));
  fprintf(' median filtering\n');
  s = mfstack(s);
  fprintf(' motion correcting to mean - pass 1\n');
  s = mcorrect2(s, mean(s.g, 3));
  fprintf(' motion correcting to first - pass 2\n');
  s = mcorrect2(s, s.g(:,:,1));
  
  fprintf(' saving to: %s\n', out);
  %saveastiff(uint16([s.g; s.r] .* bitshift(1,16)), out);
  save(out, 's');
end

