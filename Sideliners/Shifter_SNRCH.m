
%%
clear harmonics
clear Sf

dlen = floor( length(decimate(sig_rep(:,1) ,har_no))/2 );
for i =1:har_no
clear fh1
clear F1

mul=i/1;
har_chan = sig_rep(:,i);
har_chan(length(har_chan)/2+1:end)=[];
fh1=decimate(har_chan,mul);
harmonics{i}(:,1)=fh1;

end
unit = length(sig_rep)/(fs);    % 1Hz = Bin * Unit

%% For whole shifting  
% i=6
f1=floor(unit*band_low);     f2=floor(unit*band_high); 
F1=floor(unit*sig_low);      F2=floor(unit*sig_high);

%% Snr

for i = 1:har_no
carrier = harmonics{i}(:,1);
P_sig = mean( carrier([F1:F2],1).^2 );
P_noise=mean( [carrier([f1:F1],1).^2 ; carrier([F2:f2],1).^2 ] );
carrier=[];
snr(i) = P_sig./P_noise;
end

snr
% [ind1]=find( snr<(0.85*max(snr)) & snr<1 ) ;
[ind1]=find( snr<(max(snr)) & snr<1.03 ) ;
snr(ind1)=0 ; 
Snr = snr./sum(snr)*100