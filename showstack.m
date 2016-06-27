function showstack(stack, imax)

if ~exist('imax', 'var')
  imax = 1;
end

if isfield(stack, 'ttl');
  subplot(1,2,2);
  plot(stack.ttl,'.');
  title('TTL/Red');
  axis tight;
  yrange(-1,2);
  xlabel('time (frames)');
  ylabel('16 bit range')
end

subplot(1,2,1);
if imax
  imagesc(max(stack.g, [], 3));
  title('Green Chan - max');
else
  imagesc(mean(stack.g, 3));
  title('Green Chan - mean');
end
axis image;
xlabel('X pix');
ylabel('Y pix');
icolormap([0 0 0; 0 1 0]);
%colormap(gray);
colorbar;
