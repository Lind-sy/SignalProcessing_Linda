function YPred = predictWhichNumber(y, fs, net, number)

    [segments1, fs] = detectVoiced(y, fs);
    [ceps5,freqresp1,fb1,fbrecon1,freqrecon1]=mfcc(segments1{:},fs);
    kk = 1;
    
    XDATA{kk} = ceps5;
    if number ==1
        xDataNumbers{kk} = '1';
    elseif number == 2
        xDataNumbers{kk} = '2';
    elseif number ==3
        xDataNumbers{kk} = '3';
    elseif number == 4
        xDataNumbers{kk} = '4';
    end
    
xDataNumbers = categorical(xDataNumbers);
xDataNumbers=xDataNumbers';
XDATA=XDATA';

miniBatchSize = 1;
YPred = classify(net,XDATA, ...
    'MiniBatchSize',miniBatchSize);

acc = sum(YPred == xDataNumbers)./numel(xDataNumbers);

end


