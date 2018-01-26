addpath('C:\Users\linda.kalasnikova\Documents\MATLAB\Matlab_magister\project\project\AuditoryToolbox');
addpath('C:\Users\linda.kalasnikova\Documents\MATLAB\Matlab_magister\project\project\Klusuma_iznemsana');
%%
[Y, X, fs] = pococessMFCC3v('C:\Users\linda.kalasnikova\Documents\MATLAB\Matlab_magister\project\project\generatedFiles\genSamp');
%%
Y = categorical(Y);
Y=Y';
X=X';
%%

numObservations = numel(X);
for i=1:numObservations
    sequence = X{i};
    sequenceLengths(i) = size(sequence,2);
end

%%
[sequenceLengths,idx] = sort(sequenceLengths);
X = X(idx);
Y = Y(idx);
figure
bar(sequenceLengths)
ylim([0 300])
xlabel("Sequence")
ylabel("Length")
title("Sequence Lengths")
%%
miniBatchSize = 25;
miniBatchLocations = miniBatchSize+1:miniBatchSize:numObservations;

XLocations = repmat(miniBatchLocations,[2 1]);
YLocations = repmat([0;300],[1 35]);
hold on
line(XLocations,YLocations, ...
    'Color','r', ...
    'LineStyle','--')
%% Training

inputSize = 13;
outputSize = 150;
outputMode = 'last';
numClasses = 4;



%lstm layers
layers = [ ...
    sequenceInputLayer(inputSize)
    %convolution2dLayer(100,12);
    %    reluLayer();
    % maxPooling2dLayer(2,'Stride',2);
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]


maxEpochs = 3000;
miniBatchSize = 25;
shuffle = 'never';

options = trainingOptions('sgdm', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle', shuffle, ...
    'InitialLearnRate', 0.001);

net = trainNetwork(X,Y,layers,options);

%%
[YTest, XTest, fs]=processMFCC2v('C:\Users\linda.kalasnikova\Documents\MATLAB\Matlab_magister\project\project\generatedFiles\realSamp');
YTest = categorical(YTest);
YTest=YTest';
XTest=XTest';

%% Clasification
miniBatchSize = 27;

YPred = classify(net,XTest,'MiniBatchSize',miniBatchSize);

acc = sum(YPred == YTest)./numel(YTest)
%%

save('net_6v_withrealSamples22.mat','net');