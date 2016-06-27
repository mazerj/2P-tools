[~, filenames] = unix('find ../Data -name m*-*.tif');
filenames = strsplit(filenames(1:end-1), 10);

for n = 1:length(filenames)
  preprocess(filenames{n});
end
