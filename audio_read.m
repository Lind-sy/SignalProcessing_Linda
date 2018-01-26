function [y,Fs] = audio_read()
%AUDIO_READ Summary of this function goes here
%   Detailed explanation goes here
Fs = 16000;
nBits = 24;
nChannels = 1;

recorder = audiorecorder(Fs, nBits, nChannels);%define the audio recorder
T=2; %time how long the audio signal will be
recordblocking(recorder,T);%records audio from an input device, such as a microphone connected to your system
play(recorder);
y = getaudiodata(recorder);% returns recorded audio data associated with audiorecorder 

filename = 'new_number.wav';
audiowrite(filename,y,Fs);

t = 1/Fs:1/Fs:T;
plot(t,y);xlabel('Seconds'); ylabel('Amplitude');

end

