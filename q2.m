%% Q2 - RUN THIS (ENSURE THAT THE LPC FILE IS IN THE SAME FOLDER)

out_robot = my_lpc_robot('sample.wav');

[~, Fs] = audioread('sample.wav');   

audiowrite('Q2_robot.wav', out_robot, Fs);
soundsc(out_robot, Fs);
