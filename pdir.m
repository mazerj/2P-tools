function r = pdir(s, r)
%function pdir(s, r)
%  s - image stack from loadstack etc
%  r - roi from roi_def
%
%example usage:
%  >> s = mcorrect2(loadstack(....));
%  >> r = pdir(sc, roi_def(sc));
%

% from:
%  dirs = unique(arrayfun(@(x) x.params.ori, pf.rec))
% to:
dirs = linspace(0,360,13); dirs = dirs(1:end-1);

[~, ca] = roi_extract(s, r);
x = [];
y = [];
for n = 1:length(s.stim_onsets)
  a = s.stim_onsets(n);
  b = s.stim_offsets(n);
  d = dirs(1 + mod(n-1, length(dirs)));
  x(n) = d;
  y(n) = sum(ca(a:b));
end
yy = [];
ye = [];
for d = dirs
  ix = find(x == d);
  yy = [yy mean(y(ix))];
  ye = [ye sem(y(ix))];
end
roi_show(s, r);

subplot(2,2,1);
imagesc(max(s.g, [], 3)); axis image;

subplot(2,2,3);
imagesc(r.mask); axis image;

colormap(gray);

subplot(2,2,2);
plot(x,y,'.');
hold on;
plot(dirs, yy, 'o');
errorbar(dirs, yy, ye);
axis tight;
xlabel('dir');
ylabel('sum(Ca)');
hold off;

subplot(2,2,4);
boxplot(y, x);
xlabel('dir');
ylabel('sum(Ca)');

boxtitle(s.filename);
return
