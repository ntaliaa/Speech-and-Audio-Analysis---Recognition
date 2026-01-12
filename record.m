% Q4 - Record MY voice 

clear; clc;

Fs = 16000;                       
recObj = audiorecorder(Fs, 16, 1); % Fs, bits, mono

disp('Start speaking... (recording 3 seconds)');
recordblocking(recObj, 3);
disp('Recording finished.');

sig = getaudiodata(recObj);

% save original recording
audiowrite('myvoice.wav', sig, Fs);
disp('Saved: myvoice.wav');