function roi_show(s, r)

subplot(2,2,1);
ims(max(s.g, [], 3), s.filename);

subplot(2,2,2);
imagesc(r.mask);
axis image;
colorbar;
title('roi mask');

subplot(2,2,3);
plot(roi_extract(s, r));
ylabel('F');
xlabel('frame #');



