
%%%%%%%%%%%%%%%%%%%  data is splitted into x %%%%%%%%%%%%%%%%%%%%%
xlen = length(x);
xx=x;  

%% Filter implementation

sig_mat = repmat(x,1,har_no) ;

sig_rep = abs(fft(sig_mat));

    if (IN==2)|(IN==4)|(IN==6)
        filt = D_sig60;
        band_low = 59 ; band_high = 61; sig_low =59.5; sig_high =60.5;
        count = 1
    else
        band_low = 46.8;   band_high = 53.2;   sig_low =49;  sig_high =51;
        filt = D_sig50; count = 2
    end    

run('Shifter_SNRCH.m')
all_snr_var(I) = max(snr);

x = gather(x);
    clear x_sig_har
    
for i=1:har_no
    x_sig_har(:,i) = filter(filt(i),x); 
    
    w1=sig_low*i/fn;
    w2=sig_high*i/fn;
    [b,a]=fir1(2500,[w1 w2],'bandpass');
    xf(:,i) = filter(b,a,xx);
    [maxxf(i),indexxf(i)] = max(abs(fft((xf(:,i)))));
end
    clear('xf','xx') 

maxxf=maxxf./max(maxxf);
pval= polyfit([1:har_no],maxxf,3);


%%

%hop size
L = 5000;

%window length & Formation
D = 1;                        %User Defined Parameter in Cooper's paper 
M = L*D;                             
w = hanning(M, 'periodic'); 
% w = rectwin(M);
W = repmat(w,1,har_no);      %window formation
                             %3=harmionc number
k = 0; % k =index
l = 1; % j =result vector index  


%%
 while k + M <= xlen

%window length & Window
               %windowed signal
xw_sig   = x_sig_har(k+1:k+M,:).*W;

%zero padding
b =8;                           %Zero Padding Factor 'b'

xw_sig = [xw_sig; zeros(M*b,har_no)];           % Zero Pad Signal
[nft,c_sig] = size(xw_sig);


%FFT of Signal
X_sig = abs(fft((xw_sig)));

%ENF measure

W_snr = repmat(Snr,size(X_sig,1),1);
P_sig=(X_sig).^2;
Final_sig=P_sig.*W_snr; %W_k*Pb,k(kf)
Final_sig = gather(Final_sig);

run('Shifter_decimate.m')

[value,ind]=max(Sf);

%quadratic Interpolation

alpha = 20*log10(abs(Sf(ind-1)));
beta = 20*log10(abs(Sf(ind)));
lambda = 20*log10(abs(Sf(ind+1)));
p = .5*( (alpha-lambda)/ (alpha-2*beta+lambda) );
index = ind + p;            % QI Peak Bin

%calculation of frequency from Bins
sig(l)  = ((fs/2)/(nft/2)) * index;


k = k+L;
l = l+1;
end


mean(Snr);


% ENF store at a Variable to check:
% ENF{I,z}(K,:)= sig;

sig_index = sig_index+1;


%% features packet wavelet

MEAN=mean(sig);
d_range= log10(max(sig)-min(sig));
v= log10(var(sig)); 


% L level wavelet decomposition

[T] = wpdec(sig,4,'db2');

A00 = wpcoef(T,[0 0]);
vA00= log10(var(A00));

D10 = wpcoef(T,[1 0]);
vD10= log10(var(D10));

D11 = wpcoef(T,[1 1]);
vD11= log10(var(D11));

D20 = wpcoef(T,[2 0]);
vD20= log10(var(D20));

D21 = wpcoef(T,[2 1]);
vD21= log10(var(D21));

D22 = wpcoef(T,[2 2]);
vD22= log10(var(D22));

D23 = wpcoef(T,[2 3]);
vD23= log10(var(D23));

D30 = wpcoef(T,[3 0]);
vD30= log10(var(D30));

D31 = wpcoef(T,[3 1]);
vD31= log10(var(D31));

D32 = wpcoef(T,[3 2]);
vD32= log10(var(D32));

D33 = wpcoef(T,[3 3]);
vD33= log10(var(D33));

D34 = wpcoef(T,[3 4]);
vD34= log10(var(D34));

D35 = wpcoef(T,[3 5]);
vD35= log10(var(D35));

D36 = wpcoef(T,[3 6]);
vD36= log10(var(D36));

D37 = wpcoef(T,[3 7]);
vD37= log10(var(D37));

D40 = wpcoef(T,[4 0]);
vD40= log10(var(D40));

D41 = wpcoef(T,[4 1]);
vD41= log10(var(D41));

D42 = wpcoef(T,[4 2]);
vD42= log10(var(D42));

D43 = wpcoef(T,[4 3]);
vD43= log10(var(D43));

D44 = wpcoef(T,[4 4]);
vD44= log10(var(D44));

D45 = wpcoef(T,[4 5]);
vD45= log10(var(D45));

D46 = wpcoef(T,[4 6]);
vD46= log10(var(D46));


D47 = wpcoef(T,[4 7]);
vD47= log10(var(D47));

D48 = wpcoef(T,[4 8]);
vD48= log10(var(D48));

D49 = wpcoef(T,[4 9]);
vD49= log10(var(D49));

D410 = wpcoef(T,[4 10]);
vD410= log10(var(D410));

D411 = wpcoef(T,[4 11]);
vD411= log10(var(D411));

D412 = wpcoef(T,[4 12]);
vD412= log10(var(D412));

D413 = wpcoef(T,[4 13]);
vD413= log10(var(D413));

D414 = wpcoef(T,[4 14]);
vD414= log10(var(D414));

D415 = wpcoef(T,[4 15]);
vD415= log10(var(D415));


[w,A,C,SBC,FPE,th]=arfit(sig',4,4);

feature = [MEAN v d_range vA00 vD10 vD11 vD20 vD21 vD22 vD23 vD30 vD31 vD32 vD33 vD34 vD35 vD36 vD37 ...
           vD40 vD41 vD42 vD43 vD44 vD45 vD46 vD47 vD48 vD49 vD410 vD411 vD412 vD413 vD414 vD415 ...
           A log10(C) pval maxxf];


  
   
%%
% snr_count = snr_count+1;

varlist = {'sig','Final_sig','P_sig'};
clear(varlist{:})

%% VarName
% 
VarName = {'MEAN', 'v', 'd_range', 'vA00', 'vD10' ,'vD11' ,'vD20', 'vD21' ,'vD22' ,'vD23',...
           'vD30', 'vD31' ,'vD32' ,'vD33' ,'vD34' ,'vD35' ,'vD36', 'vD37' ...
           'vD40', 'vD41', 'vD42', 'vD43', 'vD44', 'vD45', 'vD46', 'vD47', 'vD48', 'vD49', 'vD410', 'vD411', 'vD412', 'vD413', 'vD414', 'vD415', ...
            'A1','A2','A3','A4','log_C','p1','p2','p3','p4',...
            'm1','m2','m3','m4','m5','m6','m7','m8'};



















