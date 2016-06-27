function [ccimage]=volumetric_xcorr(volume)
% http://labrigger.com/blog/2013/06/13/local-cross-corr-images/

w=1; % window size

% Initialize and set up parameters
ymax=size(volume,1);
xmax=size(volume,2);
numFrames=size(volume,3);
ccimage=zeros(ymax,xmax);

for y=1+w:ymax-w
  for x=1+w:xmax-w
    % Center pixel
    thing1 = reshape(volume(y,x,:)-mean(volume(y,x,:),3),[1 1 numFrames]); % Extract center pixel's time course and subtract its mean
    ad_a   = sum(thing1.*thing1,3);    % Auto corr, for normalization later
    
    % Neighborhood
    a = volume(y-w:y+w,x-w:x+w,:);         % Extract the neighborhood
    b = mean(volume(y-w:y+w,x-w:x+w,:),3); % Get its mean
    thing2 = bsxfun(@minus,a,b);       % Subtract its mean
    ad_b = sum(thing2.*thing2,3);      % Auto corr, for normalization later
    
    % Cross corr
    ccs = sum(bsxfun(@times,thing1,thing2),3)./sqrt(bsxfun(@times,ad_a,ad_b)); % Cross corr with normalization
    ccs((numel(ccs)+1)/2) = [];        % Delete the middle point
    ccimage(y,x) = mean(ccs(:));       % Get the mean cross corr of the local neighborhood
  end
end
