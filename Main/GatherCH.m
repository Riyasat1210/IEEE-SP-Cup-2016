%% Load Designed Filters

% band_low60 = 59.6 ; band_high60 = 60.4; sig_low60 =59.9; sig_high60 =60.08;
% band_low50 = 47   ; band_high50 = 53  ; sig_low50 =49.1 ; sig_high50 =50.9 ;
% run('Filter_creator8th.m')

% break

load('C:\Users\Samin Yeasar\Desktop\Final Program\filter_8th.mat')
powerfile_no=[9 10 11 11 11 8 11 11 11];  % For PowerFile Only

%% Normal Data Gather Start From Here
sig_index = 1;   % Comment This.. This is a counter for variable "sig" in PreProcess
% % 
  N=50;                     % Number of Files Audio & Practice
grid_no =1;              % grid Numbers
load('Range_JAN4.mat')

%%  Gathers All the Data from A to 'grid_no' Grids
% 
%  file='Train_Grid_A_A%d.wav';
  file='Practice_%d.wav';  
% file='Recorded_Data_%d.wav';  
                   
clear MotherPower
for z =1:grid_no                 % z Loops through the Grid       

run('SplitterCH.m')
all_feat{z}=MotherPower;
file(12)=char(z+65);           % Uncomment this For Training
                           % Tracks Which Grid Runs 1==A,2==B ....
end

Practice_Feat = all_feat;


%% Extract First 30 or Minimum Number of Data Containing Features
break

% for i = 1:length(all_feat)
%   MinLen(i)= size(all_feat{i},1); % minL = Minimum Length
% end
% ML = min(MinLen);  % contains Minimum Length
% 
% for i = 1:length(all_feat)
%   all_feat{i} = all_feat{i}([1:ML],:);
% end

%% New Normalization
 MotherOfAllFeat=[ Power_Feat];
 
 for i = 1:length(MotherOfAllFeat)
  TrainDataNo(i)= size(MotherOfAllFeat{i},1); % minL = Minimum Length
 end
 
 
 grid_no = size( MotherOfAllFeat,2);
 summ=0; 
for i=1:grid_no
    summ =summ + mean(MotherOfAllFeat{i},1);
end
    meu = summ/grid_no;

     
for i=1:grid_no
    
Meu = repmat(meu,TrainDataNo(i),1);    
Feat{i} = MotherOfAllFeat{i}-Meu;   
end

MotherFeat=[];

for i=1:grid_no
    MotherFeat = cat(1,MotherFeat,Feat{i});
end
MotherFeat = gather(MotherFeat);

max_feat = repmat( max(abs(MotherFeat)),size(MotherFeat,1),1 );
MegaFeat = MotherFeat./max_feat*100;

%%
% Tables
VarName = {'MEAN','v','dyn_range','vA9','vD1','vD2',...
                    'vD3','vD4','vD5','vD6','vD7','vD8','vD9',...
                     'A1','A2','A3','A4','log_C',...
                     'SBC','FPE','Aerr1','Aerr2','Aerr3','Aerr4','werr',...
                     'p1','p2','p3','p4','skew','kurt',...
                     'pvalue1','pvalue2','pvalue3','dev'};



TabFeat = array2table(MegaFeat,'VariableNames',VarName);
%     'VariableNames',{'MEAN','v','dyn_range','vA9','vD1','vD2',...
%     'vD3','vD4','vD5','vD6','vD7','vD8','vD9','a2','a3','log_v','A1','A2','A3','A4','log_C',...
%     'SBC', 'FPE' ,'Aerr1','Aerr2','Aerr3','Aerr4','werr'});


TabFeat.Grid = [ repmat({'A'},TrainDataNo(1),1); repmat({'B'},TrainDataNo(2),1); repmat({'C'},TrainDataNo(3),1);...
                 repmat({'D'},TrainDataNo(4),1); repmat({'E'},TrainDataNo(5),1); repmat({'F'},TrainDataNo(6),1);...
                 repmat({'G'},TrainDataNo(7),1); repmat({'H'},TrainDataNo(8),1); repmat({'I'},TrainDataNo(9),1)];

TabFeat.Grid=categorical(TabFeat.Grid);

%% ENF Checking
% signal = [];
% for i =37:48
% signal = cat(2,signal,ENF{4}(i,:));
% end
% figure(11);plot(signal)

% TabFeat = array2table(MegaFeat,...
%     'VariableNames',{'MEAN','v','dyn_range','vA9','vD1','vD2',...
%     'vD3','vD4','vD5','vD6','vD7','vD8','vD9',...
%      'A1','A2','A3','A4','log_C',...
%     'SBC', 'FPE' ,'Aerr1','Aerr2','Aerr3','Aerr4','werr'});