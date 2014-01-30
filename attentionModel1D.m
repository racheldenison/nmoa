function R = attentionModel1D(x,stimulus,varargin)
%
% R = attentionModel(x,stimulus,[param1],[value1],[param2],[value2],...,[paramN],[valueN])
%
% Required arguments
% x is a row vector of spatial coordinates
% stimulus is 1xM where M is the length of x. Leave empty to generate
% default stimulus.
%
% Optional parameters are passed as string/value pairs. If any of them are
% not specified then default values are used. Valid parameters are as
% follows.
%
% ExWidth: spatial spread of stimulation field
% IxWidth: spatial spread of suppressive field
% Ax: spatial center of attention field
% AxWidth: spatial extent/width  attention field
% Apeak: peak amplitude of attention field
% Abase: baseline of attention field for unattended locations/features
% Ashape: either 'oval' or 'cross'
% sigma: constant that determines the semi-saturation contrast
% baselineMod: amount of baseline added to stimulus drive
% baselineUnmod: amount of baseline added after normalization
% showActivityMaps: if non-zero, then display activity maps
% showModelParameters: if non-zero, then display stimulus, stimulation
%    field, suppressive field, and attention field.
%
% If Ax is NaN or not specified then attention is spread evenly
% such that attnGain = 1 (a constant) for all spatial positions.
%
% Returns the population response (R), same size as stimulus, for neurons
% with receptive fields centered at each spatial position.

%% Initializations for testing
% stimWidth = 5;
% AxWidth = 30;
%
% % Sampling of space
% x = -200:200;
%
% % Make stimuli
% stimCenters(1) = 100;
% stimCenters(2) = -100;
% for iStim = 1:2
%     stim(iStim,:) = makeGaussian(x,stimCenters(iStim),stimWidth,1);
% end
% stimulus = sum(stim,1);
%
% % Position attention field
% Ax = stimCenters(1);


%% Parse varargin to get parameters and values
%% Allow option to pass all the parameters and values in a structure called
% 'opts'
if isstruct(varargin{1})
    opts = varargin{1};
    fieldNames = fields(opts);
    inIdx = 1;
    for iOpts = 1:numel(fieldNames)
        fieldName = fieldNames{iOpts};
        inputs{inIdx} = fieldName;
        inputs{inIdx+1} = opts.(fieldName);
        inIdx = inIdx+2;
    end
else
    inputs = varargin;
end

%% Cycle through the inputs, whether they come from varargin or opts
for index = 1:2:length(inputs)
    field = inputs{index};
    val = inputs{index+1};
    switch field
        case 'x'
            x = val;
        case 'ExWidth'
            ExWidth = val;
        case 'IxWidth'
            IxWidth = val;
        case 'Ax'
            Ax = val;
        case 'AxWidth'
            AxWidth = val;
        case 'Apeak'
            Apeak = val;
        case 'Abase'
            Abase = val;
        case 'sigma'
            sigma = val;
        case 'baselineMod'
            baselineMod = val;
        case 'baselineUnmod'
            baselineUnmod = val;
        case 'showActivityMaps'
            showActivityMaps = val;
        case 'showModelParameters'
            showModelParameters = val;
        case 'stimCenters'
            stimCenters = val;
        case 'stimWidth'
            stimWidth = val;
        case 'axHandle'
            axHandle = val;
        otherwise
            warning(['attentionModel: invalid parameter: ',field]);
    end
end

%% Choose default values for unspecified parameters
if notDefined('x')
    x = -200:200;
end
if notDefined('ExWidth')
    ExWidth = 5;
end
if notDefined('IxWidth')
    IxWidth = 20;
end
if notDefined('Ax')
    Ax = NaN;
end
if notDefined('AxWidth')
%     AxWidth = ExWidth;
    AxWidth = 30;
end
if notDefined('Apeak')
    Apeak =  2;
end
if notDefined('Abase')
    Abase = 1;
end
if notDefined('sigma')
    sigma = 1e-6;
end
if notDefined('baselineMod')
    baselineMod = 0;
end
if notDefined('baselineUnmod')
    baselineUnmod = 0;
end
if notDefined('showModelParameters')
    showModelParameters = 0;
end
if notDefined('stimCenters')
    stimCenters = [100 -100];
end
if notDefined('stimWidth')
    stimWidth = 5;
end
if notDefined('stimulus')
    stimulus = rd_nmMakeStim(x, stimCenters, stimWidth);
end
if notDefined('axHandle')
    axHandle = [];
end

%% Stimulation field and suppressive field
ExKernel = makeGaussian(x,0,ExWidth);
IxKernel = makeGaussian(x,0,IxWidth);

%% Attention field
if isnan(Ax)
    attnGain = ones(size(stimulus));
    attnGainX = ones(size(x));
else
    attnGainX = makeGaussian(x,Ax,AxWidth,1);
    attnGain = (Apeak-Abase)*attnGainX + Abase;
end

%% Stimulus drive
Eraw = conv2sepYcirc(stimulus,ExKernel) + baselineMod;
Emax = max(Eraw(:));
E = attnGain .* Eraw;

%% Suppressive drive
I = conv2sepYcirc(E,IxKernel);
Imax = max(I(:));

%% Normalization
R = E ./ (I + sigma) + baselineUnmod;

Rmax = max(R(:));

%% Plot figs
if isempty(axHandle)
    gca
else
    axes(axHandle)
end
cla;
hold on
plot(x, stimulus,'k')
plot(x, attnGain,'k')
plot(x, Eraw,'c')
plot(x, E,'g')
plot(x, I,'r')
plot(x, R,'b')
xlabel('position')
ylabel('activity')

legend('stim','attn','Eraw','E','I','R')

%% Plot more figs
if showModelParameters == 1
    figure(1); clf;
    subplot(1,2,1); plot(x,ExKernel,x,-IxKernel);
    grid on;
    subplot(1,2,2); plot(x,attnGainX);
    grid on;
    drawnow
end

return





