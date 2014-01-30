% rd_runNMOA.m

%% Set up the opts structure
opts.stimCenters = [0];
opts.stimWidth = 30;
% opts.Ax = opts.stimCenters(1);

%% Run model
R = attentionModel1D(opts);