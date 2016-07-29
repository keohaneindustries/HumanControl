
w = linspace(pi / 20, 3 * pi / 20, 19);
peaks = zeros(length(w));
freqs = linspace(0.01, 20, 100);

for j = 1:length(w)
    par = par_text_to_struct('parameters/BenchmarkPar.txt');
    par.lam = w(j);
    [A, B, C, D] = whipple_pull_force_abcd(par, 5.0);
    data = generate_data('Benchmark', 5.0, ...
                         'simulate', false, ...
                         'loopTransfer', false, ...
                         'forceTransfer', {}, ...
                         'fullSystem', false, ...
                         'stateSpace', {A, B, C, D});
    num = data.handlingMetric.num;
    den = data.handlingMetric.den;
    [mag, ~, ~] = bode(tf(num, den), freqs);
    peaks(j) = max(mag);
end

plot(w, peaks)