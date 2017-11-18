
% load('C:\Users\Samin Yeasar\Desktop\SP\DO NOT ALTER\Data Testing\AudioPowerIn.mat');
% load('C:\Users\Samin Yeasar\Desktop\SP\DO NOT ALTER\Data Testing\Audio_Feat.mat');
% load('C:\Users\Samin Yeasar\Desktop\SP\DO NOT ALTER\Data Testing\Practice_Feat_Audio.mat');
%% Audio and Power Normalizer
 function [ALabel]= ANormal(Power_Feat, Audio_Feat,Practice_Feat,AudioIn);
 
 MotherOfAllFeat=[ Power_Feat Audio_Feat];
 
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

%% Calculate Length of Power & Audio Files
for i = 1:length(Power_Feat)
PowerLen(i)= size(Power_Feat{i},1); % minL = Minimum Length
end
PowerLen;

for i = 1:length(Audio_Feat)
AudioLen(i)= size(Audio_Feat{i},1); % minL = Minimum Length
end
ClassLen = [PowerLen AudioLen]; 

%% Table Creation

VarName = {'MEAN','v','dyn_range','vA00','vD10','vD11','vD20','vD21','vD22','vD23',...
                    'vD30','vD31','vD32','vD33','vD34','vD35','vD36','vD37',...
                    'vD40','vD41','vD42','vD43','vD44','vD45','vD46','vD47','vD48','vD49','vD410','vD411','vD412','vD413','vD414','vD415',...
                     'A1','A2','A3','A4','log_C',...
                     'p1','p2','p3','p4','skew','kurt',...
                     'L0','L1','m1','m2','m3','m4','m5','m6','m7','m8'};


TabFeat = array2table(MegaFeat,...
    'VariableNames',VarName);
                 
TabFeat.Grid = [ repmat({'A'},ClassLen(1),1); repmat({'B'},ClassLen(2),1);...
                 repmat({'C'},ClassLen(3),1); repmat({'D'},ClassLen(4),1);...
                 repmat({'E'},ClassLen(5),1); repmat({'F'},ClassLen(6),1);...
                 repmat({'G'},ClassLen(7),1); repmat({'H'},ClassLen(8),1);...
                 repmat({'I'},ClassLen(9),1);...
                 repmat({'A'},ClassLen(10),1); repmat({'B'},ClassLen(11),1);...
                 repmat({'C'},ClassLen(12),1); repmat({'D'},ClassLen(13),1);...
                 repmat({'E'},ClassLen(14),1); repmat({'F'},ClassLen(15),1);...
                 repmat({'G'},ClassLen(16),1); repmat({'H'},ClassLen(16),1);...
                 repmat({'I'},ClassLen(18),1)];


TabFeat.Grid=categorical(TabFeat.Grid);



%%  Practice Normalizer
Practice_Feat_Audio{1}=Practice_Feat{1}([AudioIn],:);
MotherPracFeat=[Practice_Feat_Audio];
  
 for i = 1:length(MotherPracFeat)
 TrainDataNo= size(MotherPracFeat{i},1); % minL = Minimum Length
 end
  
grid_no = size( MotherPracFeat,2);

Feat = [];     
for i=1:grid_no
Meu = repmat(meu,TrainDataNo(i),1);    
Feat{i} = MotherPracFeat{i}-Meu;   
end

MotherFeat=[];
for i=1:grid_no
    MotherFeat = cat(1,MotherFeat,Feat{i});
end
MotherFeat = gather(MotherFeat);

MAX = max(max_feat) ; % Max from Previous power_audio calculation

max_feat = repmat( MAX,size(MotherFeat,1),1 );
PracFeat = MotherFeat./max_feat*100;



%% For Prediction of Data
[Mdl, VA] = GaussianMdl35(TabFeat)
[label,NegLoss,PBScore,Posterior] = predict(Mdl,PracFeat);


for i= 1:length(label)
   mataudio(:,i) =label(i,1);
end


MM = max(Posterior,[],2); %probability
% sort(MM)
[M,I] = find(MM < 0.4) ;  % Threshold probability

mataudio(M) = 'N';
result = char(mataudio);
ALabel=result';

end
