function [XDATA, fs] = processMFCC(dire)
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
        XDATA(:,kk) = Samples;
    end    
end