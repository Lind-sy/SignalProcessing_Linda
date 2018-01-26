[dataDir, fs] = processMFCC('C:\Users\linda.kalasnikova\Documents\MATLAB\Matlab_magister\project\project\5');
%%
cellArray = num2cell(dataDir', 2);
%%
hiddenSize = 25;
autoenc = trainAutoencoder(cellArray',hiddenSize,...
    'EncoderTransferFunction','satlin',...
    'DecoderTransferFunction','purelin',...
    'MaxEpochs', 1000, ...
    'L2WeightRegularization',0.01,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.10);

xReconstructed = predict(autoenc,cellArray');
%%

for i = 1: 11
    filename = sprintf('5_reconstructed_%d.wav', i);
    audiowrite(filename,xReconstructed{i},fs);
end


%%
sound(xReconstructed{1}, fs);

%% remove delay
for i = 1:11
    [xhat,delay] = cceps(xReconstructed{i});
    data1 = icceps(xhat,1);
    data1(30000:40000) = 0;
    filename = sprintf('5_reconstructed_%d.wav', i);
    audiowrite(filename,data1,fs);
end
    