
fn = s.filename;
[mixedsig, mixedfilters, CovEvals, covtrace, movm, movtm] = ...
    CellsortPCA(fn, [1 600], 100, 1, '/tmp/', []);
[PCuse] = CellsortChoosePCs(fn, mixedfilters);
CellsortPlotPCspectrum(fn, CovEvals, PCuse)
[ica_sig, ica_filters, ica_A, numiter] = CellsortICA(mixedsig, mixedfilters, PCuse, mu, nIC, ica_A_guess, termtol, maxrounds)