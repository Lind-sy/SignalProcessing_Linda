fs = 16000;
nBits = 24;
nChannels = 1;
recorder = audiorecorder(fs, nBits, nChannels);%define the audio recorder
T=2.5; %time how long the audio signal will be
recordblocking(recorder,T);%records audio from an input device, such as a microphone connected to your system
y = getaudiodata(recorder);% returns recorded audio data associated with audiorecorder 
%%
sound(y,fs)
%%
yPred = predictWhichNumber(y, fs, net, 1);