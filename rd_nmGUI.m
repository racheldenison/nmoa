function [nm opts R] = rd_nmGUI(opts)
%
% function [nm R] = rd_nmGUI(opts)
%
% INPUTS:
% opts is an options structure for the model (optional)
% 
% OUTPUTS:
% nm is the gui structure. This is a *required* output argument for the gui
% to work.
% opts is the options structure. This is also a *required* output argument 
%   for the gui to work.
% R is the current response of the model (1 by length of x) and is
% optional.
%
% Rachel Denison
% Jan 2014

if notDefined('opts')
    opts = [];
end

% make figure
nm.ui.fig = figure('Color', 'w',...
                      'Name', 'NOMA',...
                      'Units', 'Normalized',...
                      'Position', [.02 .25 .4 .7],...
                      'NumberTitle', 'off',...
                      'MenuBar', 'none',...
                      'Tag','nmFig');
                              
% make axes
nm.ui.axes = axes('Position', [.15 .35 .75 .60]);

% make brightness and contrast sliders
nm.ui.stimPos(1) = nmMakeSlider('Stim 1 pos', [-200 200], ...
                             [.04 .17 .3 .1], 0, -100);
nm.ui.stimPos(2) = nmMakeSlider('Stim 2 pos', [-200 200], ...
                             [.37 .17 .3 .1], 0, 100);
nm.ui.stimAmp = nmMakeSlider('Stim amp', [0 1], ...
                             [.04 .05 .3 .1], 0, 1);
nm.ui.attnPos = nmMakeSlider('Attn pos', [-200 200], ...
                             [.7 .17 .3 .1], 0, 100);
nm.ui.attnSize = nmMakeSlider('Attn size', [0 100], ...
                             [.7 .05 .3 .1], 0, 30);

% make a checkbox to toggle attention on/off
nm.ui.attnOn = uicontrol('Style', 'checkbox', 'String', 'Attn On',...
          'Units', 'normalized', 'Position', [.77 .02 .2 .05], ...
          'Value', 1, 'FontSize', 10, ...
          'BackgroundColor', 'w', 'Callback', 'nmRefresh(nm, opts);');
      
% set UserData
set(nm.ui.fig,'UserData',nm)

% refresh figure
[nm R] = nmRefresh(nm, opts);
