
% Q4 - Apply all LPC effects (normal / robot / whisper) to my recorded voice

clear; clc;

% my voice recording
[inputSig, Fs] = audioread('myvoice.wav');  

% if stereo, keep 1 canal
if size(inputSig,2) > 1
    inputSig = inputSig(:,1);
end

% ORIGINAL
origFile = 'Q4_original_myvoice.wav';
audiowrite(origFile, inputSig, Fs);
fprintf('Saved original: %s\n', origFile);

disp('Playing original voice...');
soundsc(inputSig, Fs);
pause(3);

% NORMAL LPC

disp('Applying NORMAL LPC (analysis-synthesis)...');
out_normal = my_lpc('myvoice.wav');

file_normal = 'Q4_myvoice_normal.wav';
audiowrite(file_normal, out_normal, Fs);
fprintf('Saved normal LPC file: %s\n', file_normal);

disp('Playing normal LPC version...');
soundsc(out_normal, Fs);
pause(3);

% ROBOT LPC

disp('Applying ROBOT LPC effect...');
out_robot = my_lpc_robot('myvoice.wav');

file_robot = 'Q4_myvoice_robot.wav';
audiowrite(file_robot, out_robot, Fs);
fprintf('Saved robot LPC file: %s\n', file_robot);

disp('Playing robot version...');
soundsc(out_robot, Fs);
pause(3);

%  WHISPER LPC 

disp('Applying WHISPER LPC effect...');
out_whisper = my_lpc_whisper('myvoice.wav');

file_whisper = 'Q4_myvoice_whisper.wav';
audiowrite(file_whisper, out_whisper, Fs);
fprintf('Saved whisper LPC file: %s\n', file_whisper);

disp('Playing whisper version...');
soundsc(out_whisper, Fs);
pause(3);

disp('Q4 processing finished. All files saved.');
