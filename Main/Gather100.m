
%% Message
% disp(For Training The Classification System Press 1)

%% Load Designed Filters

% band_low60 = 59.6 ; band_high60 = 60.4; sig_low60 =59.9; sig_high60 =60.08;
% band_low50 = 47   ; band_high50 = 53  ; sig_low50 =49.1 ; sig_high50 =50.9 ;
% run('Filter_creator8th.m')
% break

load('filter_8th.mat')

powerfile_no=[9 10 11 11 11 8 11 11 11];  % For PowerFile Only

%% Normal Data Gather Start From Here
sig_index = 1;   % Comment This.. This is a counter for variable "sig" in PreProcess

grid_no =9;              % grid Numbers
load('Range_JAN4.mat')

%%  Gathers All the Data from A to 'grid_no' Grids
file='Train_Grid_A_P%d.wav';    

for gather_index=1:4
    
    clear MotherPower
    for z =1:grid_no               % z Loops through the z=1,2,3..grid_no; Grids       
    run('SplitterNew.m')
    all_feat{z}=MotherPower;
    file(12)=char(z+65);           % Changes The Letter of Grid in File Names                              
    end

    if gather_index==1
        Power_Feat = all_feat;  N=2;
        all_feat=[];
        file='Train_Grid_A_A%d.wav';
    
    else if gather_index==2
        Audio_Feat = all_feat; grid_no =1; N=50;   % N=50
        all_feat=[];
        file='Practice_%d.wav';
    else if gather_index==3
        Practice_Feat = all_feat; grid_no =1; N=100;  % N=100
        file='Test_%d.wav';
    else 
        Test_Feat = all_feat;
        
    end
    end
end
end
%% New Normalization

% For Practice Data
run('AudioPowerDetect.m')

[ALabel]= ANormal(Power_Feat, Audio_Feat,Practice_Feat,AudioIn);
[PLabel]= PNormal(Power_Feat,Practice_Feat,PowerIn);

LABEL(PowerIn) = PLabel;
LABEL(AudioIn) = ALabel;
PracticeLABEL = LABEL;

clear PowerIn
clear AudioIn

% For Test Data
run('AudioPowerDetect100.m')

[ALabelT]= ANormal(Power_Feat, Audio_Feat,Test_Feat,AudioIn);
[PLabelT]= PNormal(Power_Feat,Test_Feat,PowerIn);

LABELT(PowerIn) = PLabelT;
LABELT(AudioIn) = ALabelT;
TestLABEL = LABELT;
 

PracticeLABEL
TestLABEL















