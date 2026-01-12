function out = my_lpc_whisper(file)

[sig, Fs] = audioread(file);
if size(sig,2) > 1
    sig = sig(:,1);
end

Horizon   = round(30 * Fs / 1000);
OrderLPC  = 48; %i tried 24 too
Shift     = Horizon/2;
Win       = hanning(Horizon);

Lsig  = length(sig);
slice = 1:Horizon;
tosave = 1:Shift;
Nfr   = floor((Lsig-Horizon)/Shift)+1;

out    = zeros(size(sig));
Buffer = zeros(Shift,1);

for l = 1:Nfr
    sigLPC = Win .* sig(slice);
    en = sum(sigLPC.^2);

    r_full = xcorr(sigLPC, OrderLPC, 'biased');
    r = r_full(OrderLPC+1:end);

    [a, E_lev] = my_levinson(r, OrderLPC); 
    G = sqrt(E_lev);

    % WHISPER
    ex = randn(Horizon,1);

    s = filter(G, a, ex);

    ens = sum(s.^2);
    g = sqrt(en / (ens + 1e-12));
    s = s * g;

    s(1:Shift) = s(1:Shift) + Buffer;
    out(tosave) = s(1:Shift);
    Buffer = s(Shift+1:Horizon);

    slice  = slice + Shift;
    tosave = tosave + Shift;
end
