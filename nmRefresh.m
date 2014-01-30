function [nm R] = nmRefresh(nm)


%% Get the nm structure
if ~exist('nm', 'var') || isempty(nm)
    cfig = findobj('Tag','nmFig');
    nm = get(cfig,'UserData');
end

%% Get settings from UI controls 
% stim position
for i = 1:numel(nm.ui.stimPos)
    stimPos(i) = get(nm.ui.stimPos(i).sliderHandle,'Value');
end

% attention position
attnPos = get(nm.ui.attnPos.sliderHandle,'Value');

% attention size
attnSize = get(nm.ui.attnSize.sliderHandle,'Value');

% attention on
attnOn = get(nm.ui.attnOn,'Value');

%% Set opts
opts.stimCenters = stimPos;

if attnOn
    opts.Ax = attnPos;
else
    opts.Ax = NaN;
end
opts.AxWidth = attnSize;

opts.axHandle = nm.ui.axes;

%% Run model
R = attentionModel1D([],[],opts);

