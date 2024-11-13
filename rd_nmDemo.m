% rd_nmDemo.m

%% Make contrast response function
% set stimulus contrasts
contrasts = logspace(-3,2,20);

% set sigma
opts.sigma = 0.1;

% get model response at each contrast
Rmax = [];
for i=1:numel(contrasts)
    c = contrasts(i);
    opts.stimAmps = [c c];
    [R, Rmax(i)] = attentionModel1D(opts);
end

% plot CRF
figure
semilogx(contrasts, Rmax)
xlabel('Contrast')
ylabel('Response')
