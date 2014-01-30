function [nm R] = rd_nmGUI

% make figure
nm.ui.fig = figure('Color', 'w',...
                      'Name', 'NOMA',...
                      'Units', 'Normalized',...
                      'Position', [.02 .25 .3 .4],...
                      'NumberTitle', 'off',...
                      'MenuBar', 'none',...
                      'Tag','nmFig'); %, ...
%                       'CloseRequestFcn', 'closereq; nmRefresh;');
                        
                         
% make axes
nm.ui.axes = axes('Position', [.15 .22 .75 .72]);

% make brightness and contrast sliders
nm.ui.stimPos = nmMakeSlider('Stim pos', [-200 200], ...
                             [.37 .12 .3 .1], 0, 0);
nm.ui.attnPos = nmMakeSlider('Attn pos', [-200 200], ...
                             [.7 .12 .3 .1], 0, 0);

% make a checkbox to toggle drawing Rx
nm.ui.attnOn = uicontrol('Style', 'checkbox', 'String', 'Attn On',...
          'Units', 'normalized', 'Position', [.77 .05 .2 .05], ...
          'Value', 1, 'FontSize', 10, ...
          'BackgroundColor', 'w', 'Callback', 'nmRefresh;');
      
% set UserData
set(nm.ui.fig,'UserData',nm)

% refresh figure
nm = nmRefresh(nm);