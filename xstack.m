function wi = xstack(s, rad)
% explore stack

if ~exist('rad', 'var')
  rad = 5;
end

mask = ones([size(s.g, 1) size(s.g, 2)]);

mx = size(s.g, 1) / 2;
my = size(s.g, 2) / 2;

first = 1;
while 1
  if ~first
    while isempty(get(f, 'UserData'))
      drawnow;
    end
    u = get(f, 'UserData');
    if ischar(u)
      switch u
        case {'escape', 'q'}
          return;
        case 'hyphen'
          rad = max(1, rad - 1);
        case 'equal'
          rad = rad + 1;
        case 'downarrow'
          my = my + 1;
        case 'uparrow'
          my = my - 1;
        case 'leftarrow'
          mx = mx - 1;
        case 'rightarrow'
          mx = mx + 1;
        otherwise
          u
      end
    else
      mx = u(1);
      my = u(2);
    end
    set(f, 'UserData', []);
    [xx, yy] = meshgrid(1:size(mask,1), 1:size(mask,2));
    mask = mask .* 0;
    mask0 = mask;
    mask((((xx - mx).^2 + (yy - my).^2).^0.5) <= rad) = 1;
    mask0((((xx - mx).^2 + (yy - my).^2).^0.5) <= 2*rad) = 1;
    mask0 = max(0, mask0 - mask);
    subplot(2,2,3);
    imagesc(mask0);
    axis image;
    
    y = [];
    dy = [];
    ar0 = sum(sum(mask0 > 0));
    ar = sum(sum(mask > 0));
    for n = 1:size(s.g, 3)
      f0 = sum(sum(s.g(:,:,n) .* mask0)) ./ ar0;
      f = sum(sum(s.g(:,:,n) .* mask)) ./ ar;
      y = [y f];
      dy = [dy f/f0];
    end

    subplot(4,2,6);
    plot(y);
    for n = 1:length(s.stim_onsets);
      vline(s.stim_onsets(n), 'LineStyle', '-');
    end
    ylabel('F');

    subplot(4,2,8);
    plot(dy);
    for n = 1:length(s.stim_onsets);
      vline(s.stim_onsets(n), 'LineStyle', '-');
    end
    ylabel('F/Fo');
    yrange(0, 5);
    
  end
  first = 0;

  alpha = 0.5 + (mask/2);
  subplot(2,2,1);
  ims(alpha.*mean(s.g,3), 'imean');
  set(get(gca, 'Children'), 'ButtonDownFcn', @onclick);
  
  subplot(2,2,2);
  ims(alpha.*max(s.g,[],3), 'imax');
  
  f = gcf;
  set(f, 'UserData', []);
  set(f, 'WindowKeyPressFcn', @onkeypress);
end


function onkeypress(f, varargin)
set(f, 'UserData', varargin{1}.Key);

function onclick(varargin)
p = get(gca,'CurrentPoint');
set(gcf, 'UserData', p(1,1:2));