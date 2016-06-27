function defaults = getopt(defaults, varargin)

argn = 1;
while argn < length(varargin)
  defaults = setfield(defaults, varargin{argn}, varargin{argn+1});
  argn = argn + 2;
end
  