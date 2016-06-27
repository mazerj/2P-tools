function playstacks(varargin)
%function playstacks(varargin)
%
%INPUTS
%  varargin - all stack to play in sync
%
%OUTPUT
%  none
%

N = length(varargin);
fp = ones([1 N]);

for n = 1:N
  range{n} = [min(unravel(varargin{n}.g)), ...
              max(unravel(varargin{n}.g))];
end

set(gcf, 'WindowKeyPressFcn', @pause)
set(gcf, 'WindowButtonDownFcn', @halt);
set(gcf, 'color', [.8 1 .8]);
while isempty(get(gcf, 'UserData'))
  for n = 1:N
    subplot(1, N, n);
    ims(varargin{n}.g(:,:,fp(n)), ...
        sprintf('[%d/%d] button:stop key:pause', fp(n), size(varargin{n}.g,3)));
    caxis(range{n});
    fp(n) = fp(n) + 1;
    if fp(n) > size(varargin{n}.g, 3)
      fp(n) = 1;
    end
    hold on;
    [xx,yy]=meshgrid(get(gca, 'XTick'),get(gca, 'yTick'));
    plot(xx, yy, 'r.');
    hold off;
    colormap(gray);
  end
  drawnow;
  fprintf('x');
end
set(gcf, 'color', [.8 .8 .8]);
set(gcf, 'UserData', []);

function halt(varargin)
set(gcf, 'UserData', 1);

function pause(varargin)
set(gcf, 'color', [1 .8 .8]);
ginput(1);
set(gcf, 'color', [.8 1 .8]);

