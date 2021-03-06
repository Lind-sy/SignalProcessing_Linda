function [xDataNumbers,XDATA, fs] = processMFCC2v(dire)
%*************************************************************************%
%Ievade:
%dire - skanas signalu direktorija
%Izvade:
%XDATA - cepstralo koeficentu matrica katram skanas signalam
%*************************************************************************%
wav_folder = {dire};
%Atrod visus wav failus attiecigaja direktorija
for i = 1:length(wav_folder)
    aa = dir(fullfile(wav_folder{i}, '*.wav'));
end

for kk = 1:length(aa)
    %atrod audio faila nosaukumu
    acq_fn_1 = fullfile(wav_folder{i}, aa(kk).name);
    %Ielasa audio failu
    [Samples, fs] = audioread(acq_fn_1);
    [segments1, fs] = detectVoiced(Samples, fs);
    [ceps5,freqresp1,fb1,fbrecon1,freqrecon1]=mfcc(segments1{:},fs);
    
    XDATA{kk} = ceps5;
    if kk <=11
        xDataNumbers{kk} = '1';
    elseif kk <=22 && kk>11
        xDataNumbers{kk} = '2';
    elseif kk <=33 && kk>22
        xDataNumbers{kk} = '3';
    elseif kk <=44 && kk>33
        xDataNumbers{kk} = '4';
    end
end