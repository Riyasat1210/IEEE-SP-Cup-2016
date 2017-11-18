clear all_harmonics
clear Sf

dlen =  length(decimate(Final_sig(:,1) ,har_no));

for i =1:har_no
clear fh1
clear F1

mul=i/1;
har_chan = Final_sig(:,i);

fh1=decimate(har_chan,mul);
fh1(dlen+1:end)=[];
all_harmonics(:,i)=fh1;

end

%% For Only Max Point Shifting
% [mm,ii] =  max(all_harmonics);
% Sf= zeros(length(all_harmonics),1);
% Sf(ii) = mm;
% all_harmonics(ii) = 0;
%% For whole shifting  
Sf = sum(all_harmonics,2);

% % Sf( (length(Sf)/2 )+1 : end)=[];
% figure(3);plot(linspace(0,1000,length(Final_sig)), Final_sig)
% figure(3);plot(linspace(0,1000,length(Sf)), Sf)