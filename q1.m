%% Q1 - RUN THIS (ENSURE THAT THE LPC FILE IS IN THE SAME FOLDER)

out = my_lpc('sample.wav');

[sig, fs] = audioread('sample.wav');

soundsc(sig, fs);      % play original
pause(2);

soundsc(out, fs);      % play LPC reconstructed
pause(2);

audiowrite('Q1_output.wav', out, fs);

disp('Saved file: Q1_output.wav');
