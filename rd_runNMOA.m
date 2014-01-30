% rd_runNMOA.m

%% Set up
% Sampling of space
x = -200:200;

% Set stimulus and attention fields in opts
opts.stimCenters = [100 -100];
opts.Ax = opts.stimCenters(1);

%% Run model
R = attentionModel1D(x, [], opts);