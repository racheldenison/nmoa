function [nm R] = nmRefresh(nm, opts)
%
% function [nm R] = nmRefresh(nm, opts)
%
% Refresh the nm figure window after recomputing the model.
%
% nm is the nm struture containing all the figure/model data
% opts is the options structure (optional)


%% Get the nm structure
if ~exist('nm', 'var') || isempty(nm)
    cfig = findobj('Tag','nmFig');
    nm = get(cfig,'UserData');
end

%% Get settings from UI controls 
for i = 1:numel(nm.ui.stimPos)
    % stim position
    stimPos(i) = get(nm.ui.stimPos(i).sliderHandle,'Value');
    % stim amp
    stimAmps(i) = get(nm.ui.stimAmps(i).sliderHandle,'Value');
end

% attention position
attnPos = get(nm.ui.attnPos.sliderHandle,'Value');

% attention size
attnSize = get(nm.ui.attnSize.sliderHandle,'Value');

% attention on
attnOn = get(nm.ui.attnOn,'Value');

%% Set opts
opts.stimCenters = stimPos;

opts.stimAmps = stimAmps;

if attnOn
    opts.Ax = attnPos;
else
    opts.Ax = NaN;
end
opts.AxWidth = attnSize;

opts.axHandle = nm.ui.axes;

%% Run model
R = attentionModel1D(opts);

