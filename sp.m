function d = sp(s, b)

s = mfstack(s);

% 6 horiz bars (y-map), followed by 8 vertical bars (x-map)
ncond = 6+8;
conds = mod((1:length(s.stim_onsets))-1,ncond)+1;

d = zeros([size(s.g, 1) size(s.g, 1) ncond]);
dnf = zeros([1 ncond]);

for k = 1:min(length(s.stim_onsets), length(s.stim_offsets))
  a = s.stim_onsets(k);
  b = s.stim_offsets(k) - 3;            % -3 to elim blank time
  for f = a:b
    d(:,:,conds(k)) = d(:,:,conds(k)) + s.g(:,:,f);
    dnf(conds(k)) =  dnf(conds(k)) + 1;
  end
end
% divide by # frames in each condition for mean
for k = 1:ncond
  d(:,:,k) = d(:,:,k) ./ dnf(k);
end

if 0
  % normalize
  d = (d - min(d(:))) ./ (max(d(:)) - min(d(:)));
else
  % use thresholded binarized dataset
  
  % this generates a binarized data matrix, where the maximally
  % activated pixels in each condition are 1, everything else is 0.
  dm = repmat(max(d,[],3), [1 1 size(d,3)]) == d;
  for k = 1:ncond
    dm(:,:,k) = medfilt2(dm(:,:,k));
  end
  d = dm;
end

w = 10;
for k = 1:ncond
  for x = 1:w
    for y = 1:w
      d(w+x,w+y+((k-1)*w),:) = 0;
      d(w+x,w+y+((k-1)*w),k) = 1;
    end
  end
end

if 1
  cmap = cmapper(6);
  im = [];
  for k = 1:6
    c = cmap(k,:);
    im(:,:,:,k) = cat(3, c(1)*d(:,:,k), c(2)*d(:,:,k), c(3)*d(:,:,k));
  end
  subplot(1,3,1);
  im = mean(im,4);
  im = (im - min(im(:))) ./ (max(im(:)) - min(im(:)));
  imagesc(im);
  axis image;
  axis off;
  title('y');

  cmap = cmapper(8);
  im = [];
  for k = 1:8
    c = cmap(k,:);
    kk = k+6;
    im(:,:,:,k) = cat(3, c(1)*d(:,:,kk), c(2)*d(:,:,kk), c(3)*d(:,:,kk));
  end
  subplot(1,3,2);
  im = mean(im,4);
  im = (im - min(im(:))) ./ (max(im(:)) - min(im(:)));
  imagesc(im);
  axis image;
  axis off;
  title('x');
  
  subplot(1,3,3);
  imagesc(max(s.g, [], 3));
  axis image;
  axis off;  
  colormap(icolormap([0 0 0; 0 1 0]));
  title('max proj');
end

if 0
  % make montage

  im = [];

  row = [baseline];
  for k = 1:7
    row = [row 0*d(:,:,1)];
  end
  im = [im; row];

  row = [];
  for k = 1:8
    if k <= 6
      row = [row d(:,:,k)];
    else
      row = [row 0*d(:,:,1)];
    end
  end
  im = [im; row];

  row = [];
  for k = 1:8
    row = [row d(:,:,6+k)];
  end
  im = [im; row];
  
  imagesc(im);
  axis image;
end

function c = cmapper(n)
%c = icolormap('redgreen', n);
c = hsv(n); c = c / 2 + .5;

