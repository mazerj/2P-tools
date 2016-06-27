function imc(varargin)
% compare images side-by-side

for n = 1:length(varargin)
  subplot(1,length(varargin),n);
  ims(varargin{n});
end

