function out = my_lpc_robot(file)
%
% INPUT: input filename of a wav file
% OUTPUT: a vector contaning the output signal
%
% Example:
%   out = my_lpc('speechsample.wav');
%   [sig,fs]= wavread('speechsample.wav');
%   sound(out,fs);
%   sound(sig,fs);
%   sound([out [zeros(2000,1);sig(1:length(sig)-2000)]],fs); % create echo


[sig, Fs] = audioread(file);

if size(sig,2) > 1
    sig = sig(:,1);
end

Horizon = 30;  %30ms - window length
OrderLPC=32;   %i tried 16,24 and 32
Buffer = 0;    % initialization
out = zeros(size(sig)); % initialization

Horizon = Horizon*Fs/1000;
Shift = Horizon/2;       % frame size - step size
Win = hanning(Horizon);  % analysis window

Lsig = length(sig);
slice = 1:Horizon;
tosave = 1:Shift;
Nfr = floor((Lsig-Horizon)/Shift)+1;  % number of frames

% analysis frame-by-frame
for l=1:Nfr
    
  sigLPC = Win.*sig(slice);
  en = sum(sigLPC.^2); % get the short - term energy of the input
  
  % LPC analysis
  r_full = xcorr(sigLPC, OrderLPC, 'biased');   % correlation
  r = r_full(OrderLPC+1 : end); 
  [a, E_lev] = my_levinson(r, OrderLPC); 
  G = sqrt(E_lev); % gain
  
  pitch = 120;                     %  pitch (Hz)
  period = round(Fs / pitch);

  ex = zeros(Horizon,1);           % impulse train
  ex(1:period:end) = 1;

  % synthesis
  s = filter(G,a, ex);
  ens = sum(s.^2);   % get the short-time energy of the output
  g = sqrt(en/ens);  % normalization factor
  s  =s*g;           % energy compensation
  s(1:Shift) = s(1:Shift) + Buffer;  % Overlap and add
  out(tosave) = s(1:Shift);           % save the first part of the frame
  Buffer = s(Shift+1:Horizon);       % buffer the rest of the frame
  
  slice = slice+Shift;   % move the frame
  tosave = tosave+Shift;
  
end

