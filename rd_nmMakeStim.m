function stimulus = rd_nmMakeStim(x, stimCenters, stimWidth)
%
% function stimulus = rd_nmMakeStim(stimCenters, stimWidth)
%
% Make stimulus vector (1D) for NMOA
% stimCenters is a vector with the position of each center
% stimWidth is a scalar (same width for all stimuli currently)
%
% Rachel Denison
% Jan 2014

% stimCenters = [100 -100];

for iStim = 1:numel(stimCenters)
    stim(iStim,:) = makeGaussian(x,stimCenters(iStim),stimWidth,1); 
end
stimulus = sum(stim,1);