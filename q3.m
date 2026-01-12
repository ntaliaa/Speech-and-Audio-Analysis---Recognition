%% Q3 - RUN THIS (ENSURE THAT THE LPC FILE IS IN THE SAME FOLDER)

out_whisper = my_lpc_whisper('sample.wav');

[~, Fs] = audioread('sample.wav');  

audiowrite('Q3_whisper.wav', out_whisper, Fs);
soundsc(out_whisper, Fs);
