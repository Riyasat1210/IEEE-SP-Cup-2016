
%%
% grid_no = 9; z=9; I=34;        %fr_range =4;

% m='Train_Grid_I_A%d.wav';
for I = 1:150
% m='Practice_%d.wav'; 
 m='Test_%d.wav';
h = sprintf(m,I)     
[sig_x,fs] = audioread(h);

%% 50 vs 60 Hz File Identification

fn = fs/2;
w1= 48/fn; w2 = 52/fn;
[b,a]=fir1(1000,[w1 w2],'bandpass');
x50 = filter(b,a,sig_x);

fn = fs/2;
w1= 59.4/fn; w2 = 60.6/fn;
[b,a]=fir1(1000,[w1 w2],'bandpass');
x60 = filter(b,a,sig_x);

fn = fs/2;
w1= 97.5/fn; w2 = 102.5/fn;
[b,a]=fir1(1000,[w1 w2],'bandpass');
x100 = filter(b,a,sig_x);

fn = fs/2;
w1= 117.5/fn; w2 = 122.5/fn;
[b,a]=fir1(1000,[w1 w2],'bandpass');
x120 = filter(b,a,sig_x);

fn = fs/2;
w1= 199/fn; w2 = 204/fn;
[b,a]=fir1(1000,[w1 w2],'bandpass');
x200 = filter(b,a,sig_x);

fn = fs/2;
w1= 238/fn; w2 = 242/fn;
[b,a]=fir1(1000,[w1 w2],'bandpass');
x240 = filter(b,a,sig_x);

%**** Convert Bins to Freq****

Xft50 = abs(fft(x50));
XFT50=Xft50(floor((1:length(Xft50)/2)));
% p5 = linspace(1,500,length(XFT50));
% subplot(2,4,2); plot(p5,XFT50)
[q50,ind] = max(XFT50);
x50  = ((fs/2)/(length(sig_x)/2)) * ind;
q50;

Xft60 = abs(fft(x60));
XFT60=Xft60(floor((1:length(Xft60)/2)));
% p6 = linspace(1,500,length(XFT60));
% subplot(2,4,3); plot(p6,XFT60)
[q60,ind] = max(XFT60);
sig_freq60  = ((fs/2)/(length(sig_x)/2)) * ind;
q60;

Xft100 = abs(fft(x100));
Xft100=Xft100(floor((1:length(Xft100)/2)));
% p10 = linspace(1,500,length(Xft100));
% subplot(2,4,4); plot(p10,Xft100)
[q100,ind] = max(Xft100);
sig_freq100  = ((fs/2)/(length(sig_x)/2)) * ind;
q100;

Xft120 = abs(fft(x120));
Xft120=Xft120(floor((1:length(Xft120)/2)));
% p12 = linspace(1,500,length(Xft120));
% subplot(2,4,5); plot(p12,Xft120)
[q120,ind] = max(Xft120);
sig_freq120  = ((fs/2)/(length(sig_x)/2)) * ind;
q120;

Xft200 = abs(fft(x200));
Xft200=Xft200(floor((1:length(Xft200)/2)));
% p12 = linspace(1,500,length(Xft100b));
% subplot(2,4,5); plot(p12,Xft100b)
[q200,ind] = max(Xft200);
sig_freq200  = ((fs/2)/(length(sig_x)/2)) * ind;
q200;

Xft240 = abs(fft(x240));
Xft240=Xft240(floor((1:length(Xft240)/2)));
% p12 = linspace(1,500,length(Xft100b));
% subplot(2,4,5); plot(p12,Xft100b)
[q240,ind] = max(Xft240);
sig_freq240  = ((fs/2)/(length(sig_x)/2)) * ind;
q240;

[M,IN] = max([q50 q60 q100 q120 q200 q240])

if (IN == 1)|(IN == 2)
    type(I) = ('P');
else    
    type(I) = ('A');
end


if (IN == 1)|(IN == 3)|(IN == 5)
    freq(I) = 50;
else    
    freq(I) = 60;
end

end

%% Create Vector Index of Power and Audio Files

 PowerIn = find(type=='P');
 AudioIn = find(type=='A');
 clearvars -except PowerIn  AudioIn IN Audio_Feat Power_Feat Practice_Feat Test_Feat PracticeLABEL
 



