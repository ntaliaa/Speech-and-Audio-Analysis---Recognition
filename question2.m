% "apa" Analysis

clear; clc; close all;

%Record Audio 
fs = 44100; 
nBits = 16;
nChannels = 1;
recObj = audiorecorder(fs, nBits, nChannels);
disp('Get ready to say "apa"...');
pause(1); 
disp('>> START SPEAKING NOW <<');
recordblocking(recObj, 2); 
disp('>> STOP RECORDING <<');
y = getaudiodata(recObj);
T = length(y) / fs; 

%Plot Signal Segments
N_ms = 200; 
N_samples = round(N_ms / 1000 * fs); 
audioData = y; 
numSegments = ceil(length(audioData) / N_samples);
max_amp = max(abs(y)); 
y_limit = max_amp * 1.05; 

figure('Name', 'Task 2: Segmented Plot (Subplots)');
clf; 
sgtitle(['Speech Signal Segments (N = ' num2str(N_ms) ' ms)']);

for k = 1:numSegments
    startIndex = (k - 1) * N_samples + 1;
    endIndex = min(k * N_samples, length(audioData));
    segment = audioData(startIndex:endIndex);
    segmentTime = (0:(length(segment)-1)) / fs;
    
    subplot(numSegments, 1, k);
    plot(segmentTime, segment);
    
    ylim([-y_limit, y_limit]); 
    
    title(['Segment ' num2str(k) ': ' num2str((k-1)*N_ms) 'ms to ' num2str(min(k*N_ms, round(T*1000))) 'ms']);
    ylabel('Amplitude');
    if k == numSegments
        xlabel('Time (s)');
    end
    grid on;
end
set(gcf, 'Position', [100, 100, 800, 800]);

%Standard Plot 
figure('Name', 'Task 3: Full Signal for Analysis');
t_full = (0:length(y)-1) / fs;
plot(t_full, y);
title('Full Signal "apa" for Voiced/Unvoiced Analysis');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
axis tight;

%Slow Down the Sound (Resampling)
slow_factor = 2; % 2x slower
y_slow = resample(y, slow_factor, 1);
t_slow = (0:length(y_slow)-1) / fs;

figure('Name', 'Task 4: Resampled Signal');
plot(t_slow, y_slow);
title('Slowed Down Signal (Resampled 2x)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
axis tight;


disp('Playing "apa"...');
play(recObj);
pause(2.5);
disp('Playing Slowed "apa"...');
player_slow = audioplayer(y_slow, fs);
play(player_slow);


disp('---------------------------------------------');
disp('Step 6: Saving Plots...');


outputDir = 'output_plots';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end


figHandles = findobj('Type', 'figure');

for i = 1:length(figHandles)
    fig = figHandles(i);
    
    figName = get(fig, 'Name'); 
   
    filename = strrep(figName, ' ', '_');
    filename = strrep(filename, ':', ''); 
    
    filePath = fullfile(outputDir, [filename, '.png']);
    
    
    saveas(fig, filePath);
    disp(['Saved: ', filePath]);
end
