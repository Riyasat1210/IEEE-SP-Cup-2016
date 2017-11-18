
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


%% 16 features adi-hajj

MEAN=mean(sig);
d_range= log10(max(sig)-min(sig));
v= log10(var(sig)); 


% L level wavelet decomposition

[C,L] = wavedec(sig,9,'db2');

cA1 = appcoef(C,L,'db2',1);
[cD1,cD2,cD3,cD4,cD5,cD6,cD7,cD8,cD9] = detcoef(C,L,[1,2,3,4,5,6,7,8,9]);


A9 = wrcoef('a',C,L,'db2',9);
vA9= log10(var(A9));

D1 = wrcoef('d',C,L,'db2',1);
vD1= log10(var(D1));

D2 = wrcoef('d',C,L,'db2',2);
vD2= log10(var(D2));

D3 = wrcoef('d',C,L,'db2',3);
vD3= log10(var(D3));

D4 = wrcoef('d',C,L,'db2',4);
vD4= log10(var(D4));

D5 = wrcoef('d',C,L,'db2',5);
vD5= log10(var(D5));

D6 = wrcoef('d',C,L,'db2',6);
vD6= log10(var(D6));

D7 = wrcoef('d',C,L,'db2',7);
vD7= log10(var(D7));

D8 = wrcoef('d',C,L,'db2',8);
vD8= log10(var(D8));

D9 = wrcoef('d',C,L,'db2',9);
vD9= log10(var(D9));

[a e] = aryule(sig,2);
log_v = log10(e);

feature = [MEAN v d_range vA9 vD1 vD2 vD3 vD4 vD5...
                vD6 vD7 vD8 vD9 a(2:3) log_v];


  
   
%%
% snr_count = snr_count+1;

varlist = {'sig','Final_sig','P_sig'};
clear(varlist{:})

%% VarName
% 
VarName = {'MEAN', 'v', 'd_range', 'vA9' ,'vD1' ,'vD2' ,'vD3' ,'vD4' ,'vD5',...
                'vD6', 'vD7', 'vD8', 'vD9', 'a1', 'a2', 'log_v'};



















