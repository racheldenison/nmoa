% rd_runNMOA.m

%% Set up the opts structure
op.stimCenters = [0 50 100];
op.stimWidth = 30;

%% Run model
R = attentionModel1D(op);

% opts.attnGainX = R;
opts = op;