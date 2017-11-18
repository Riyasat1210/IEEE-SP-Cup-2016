%% Gatherer For test File

load('filter_8th.mat')
gather_index=3;
%% Normal Data Gather Start From Here
sig_index = 1;   % Comment This.. This is a counter for variable "sig" in PreProcess

grid_no =1;              % grid Numbers
load('Range_JAN4.mat')

%%  Gathers All the Data from A to 'grid_no' Grids
 
N = 100;
file='Test_%d.wav';                  
clear MotherPower
clear all_feat 
              % z Loops through the z=1,2,3..grid_no; Grids       
run('SplitterNew.m')
all_feat{1}=MotherPower;



Practice_Feat = all_feat;    
%% New Normalization
break
run('AudioPowerDetect100.m')

[ALabel]= ANormal(Power_Feat, Audio_Feat,Practice_Feat,AudioIn);
[PLabel]= PNormal(Power_Feat,Practice_Feat,PowerIn);

LABEL(PowerIn) = PLabel;
LABEL(AudioIn) = ALabel;

TestLABEL = LABEL 




