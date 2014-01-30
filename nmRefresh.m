function [nm R] = nmRefresh(nm)


%% Get the nm structure
if ~exist('nm', 'var') || isempty(nm)
    cfig = findobj('Tag','nmFig');
    nm = get(cfig,'UserData');
end

%% Get settings from UI controls 
% stim position
stimPos = get(nm.ui.stimPos.sliderHandle,'Value');

% attention position
attnPos = get(nm.ui.attnPos.sliderHandle,'Value');

% attention on
attnOn = get(nm.ui.attnOn,'Value');


%% Set opts
opts.stimCenters = stimPos;

if attnOn
    opts.Ax = attnPos;
else
    opts.Ax = NaN;
end

opts.axHandle = nm.ui.axes;

R = attentionModel1D([],[],opts);