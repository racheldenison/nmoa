function stimulus = rd_nmMakeStim(x, stimCenters, stimWidth, stimAmp)
%
% function stimulus = rd_nmMakeStim(x, stimCenters, stimWidth, stimAmp)
%
% Make stimulus vector (1D) for NMOA
% stimCenters is a vector with the position of each center
% stimWidth is a scalar (same width for all stimuli currently)
% stimAmp (optional) is the amplitude of the Gaussians, a scalar (same amp for all
%   stimuli currently)
%
% Rachel Denison
% Jan 2014

% stimCenters = [100 -100];

if nargin < 4 || isempty(stimAmp)
    stimAmp = 1;
end

for iStim = 1:numel(stimCenters)
    stim(iStim,:) = makeGaussian(x,stimCenters(iStim),stimWidth,stimAmp); 
end
stimulus = sum(stim,1);