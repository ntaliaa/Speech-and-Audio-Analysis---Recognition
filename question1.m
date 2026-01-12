% Plot Spectograms and analyze 

% Read audio data (x1) and sampling frequency (fs1) from the file.
[x1, fs1] = audioread('sample1.wav');
windowsize_wide = 48;
windowsize_narrow= 256;

% Wideband Spectrogram (High Time Resolution) 
figure;
% Generate Wideband spectrogram (small window size $N=48$).
spectrogram(x1(:,1),windowsize_wide,windowsize_wide/4,[],fs1,'yaxis');
title('Wideband Spectrogram for Sample1');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colormap jet; 
colorbar; 
caxis([-100 0]); 
saveas(gcf, 'wideband_sample1.png');

% Narrowband Spectrogram (High Frequency Resolution) 
figure;
% Generate Narrowband spectrogram (large window size $N=256$).
spectrogram(x1(:,1),windowsize_narrow,windowsize_narrow/4,[],fs1,'yaxis');
title('Narrowband Spectrogram for Sample1');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colormap jet; 
colorbar; 
% Set the power display range from -100 dB to 0 dB.
caxis([-100 0]); 
saveas(gcf, 'narrowband_sample1.png');

% Read the second audio file (x2) and its sampling frequency (fs2).
[x2, fs2] = audioread('sample2.wav');

% Generate Wideband spectrogram for Sample 2.
figure;
spectrogram(x2(:,1),windowsize_wide,windowsize_wide/4,[],fs2,'yaxis');
title('Wideband Spectrogram for Sample2');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colormap jet; 
colorbar; 
caxis([-100 0]); 
% Save the current figure to the specified file name.
saveas(gcf, 'wideband_sample2.png');

% Generate and save the Narrowband spectrogram for Sample 2.
figure;
spectrogram(x2(:,1),windowsize_narrow,windowsize_narrow/4,[],fs2,'yaxis');
title('Narrowband Spectrogram for Sample2');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colormap jet; 
colorbar; 
caxis([-100 0]); 
saveas(gcf, 'narrowband_sample2.png');