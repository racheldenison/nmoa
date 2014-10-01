% rd_runNMOA.m

%% Set up the opts structure
op.stimCenters = -150:50:150;
op.stimAmps = ones(size(op.stimCenters));
op.stimWidth = 30;

%% Run model
R = attentionModel1D(op);

% opts.attnGainX = R;
opts = op;