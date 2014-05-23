% rd_runNMOA.m

Axs = -200:200;
AxWidths = 1:50;

op.stimCenters = [-50 50];
stimOnsets = op.stimCenters+200-25 + [0 1]; % -left of timeline - stim width, add 1 for stim 2 offset from 0

op.plotFigs = 0;

for iAx = 1:numel(Axs)
    for iAxW = 1:numel(AxWidths)
        %% Set up the opts structure
        % op.stimCenters = [0 50 100];
        % op.stimWidth = 30;
        op.Ax = Axs(iAx);
        op.AxWidth = AxWidths(iAxW);
        
        %% Run model
        R = attentionModel1D(op);
        
        %% Read out max responses
        rMax(iAxW,iAx,1) = max(R(1:round(numel(R)/2)));
        rMax(iAxW,iAx,2) = max(R(round(numel(R)/2)+1:end));
    end
end

%% Calculate baseline (no attention)
op.Ax = NaN;
R = attentionModel1D(op);
rMaxBaseline(1) = max(R(1:round(numel(R)/2)));
rMaxBaseline(2) = max(R(round(numel(R)/2)+1:end));
rMax0(:,:,1) = repmat(rMaxBaseline(1),size(rMax(:,:,1)));
rMax0(:,:,2) = repmat(rMaxBaseline(2),size(rMax(:,:,2)));

%% Calculate difference from baseline (attention - no attention)
rMaxDiff = rMax - rMax0;
rMaxPctChange = (rMax./rMax0 - 1).*100;

%% Caclulate change when center of attention field is at stim onset
onsetPctChange(:,1) = rMaxPctChange(:,stimOnsets(1),1);
onsetPctChange(:,2) = rMaxPctChange(:,stimOnsets(2),2);

%% Show response maps
figure
subplot(2,2,1)
imagesc(rMax(:,:,1))
colorbar
title('stim 1 max response')
subplot(2,2,2)
imagesc(rMax(:,:,2))
colorbar
title('stim 2 max response')
subplot(2,2,3)
imagesc(rMaxPctChange(:,:,1))
colorbar
title('stim 1 % change')
subplot(2,2,4)
imagesc(rMaxPctChange(:,:,2))
colorbar
title('stim 2 % change')

%% Plot change at stim onset
figure
plot(onsetPctChange)
xlabel('AxWidth')
ylabel('percent change')
title('center of attention field at stim onset')
legend('stim 1','stim 2')
