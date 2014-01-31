function [nm opts R] = rd_nmGUI(opts)
%
% function [nm opts R] = rd_nmGUI(opts)
%
% INPUTS:
% opts is an options structure for the model (optional)
% 
% OUTPUTS:
% nm is the gui structure. This is a required output argument for the gui
%   to work, and it must be called 'nm'.**
% opts is the options structure. This is also a required output argument 
%   for the gui to work, and it must be called 'opts'.**
% ** The truth is, these variables just have to exist in the workspace from
%   which you called this function. This is because the refresh functions
%   call these variables from the workspace. But their values don't matter.
% R is the current response of the model (1 by length of x) and is
% optional.
%
% Rachel Denison
% Jan 2014

if nargout < 2
    warning('Be aware! If you did not call this function with nm and opts as output args, they must already exist in the workspace (see the help for this function).')
end

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
nm.ui.stimAmps(1) = nmMakeSlider('Stim 1 amp', [0 1], ...
                             [.04 .05 .3 .1], 0, 1);
nm.ui.stimAmps(2) = nmMakeSlider('Stim 2 amp', [0 1], ...
                             [.37 .05 .3 .1], 0, 1);
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
