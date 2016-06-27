function args = pargin(defaults, varargs)
%function args = pargin(defaults, varargs)
%
% Parse args - arguments must all be (name, value) pairs
%
%INPUT
%   defaults - struct() of default values
%   varargs - varargin from caller
%
%OUPUT
%   args - filled in struct with defaults + varargins
%

if isempty(defaults)
  defaults = struct();
end

argn = 1;
while argn < length(varargs)
  defaults = setfield(defaults, varargs{argn}, varargs{argn+1});
  argn = argn + 2;
end
args = defaults;

