%==========================================================================
%Abstracts: Relief+RandomForest
%Auther: Ziqiang Li
%Finish time: 2017/4/23
%==========================================================================
%% Initialize Parameters
clear;
Acc = 0;
P = 0;
R = 0;
F1 = 0;
Auc = 0;
Dim = 0;
Epoch = 100;
Feature = [];
Data = [];
Label = [];
i = 0;
Name_index = [21];
%% Loop of total frequency
for l = 1: length(Name_index)
%% Load Data and Set Parameters
load(['E:\selected_samping',num2str(Name_index(l)),'.mat']);
Data = s_data;
Label = s_label;
Dim = size(s_data,2);
%% Selecting Loop
while(i<Epoch)
    Random_num = floor(rand(1)*Dim);
    Random_index = randperm(Dim);
    Tem_data = Data(:,Random_index(1:Random_num));
    Tem_label = Label;
    Tem_dim = size(Tem_data,2);
    [Tem_accuracy,Tem_P,Tem_R,Tem_F1,Tem_auc,Tem_Femal_R] = RandomForest(Tem_data,Tem_label);
    if(Tem_accuracy>Acc)||((Acc == Tem_accuracy)&&(Tem_dim<Dim))
        i = 0;
        Acc = Tem_accuracy;
        P = Tem_P;
        R = Tem_R;
        Auc = Tem_auc;
        F1 = Tem_F1;
        Feature = Tem_data;
        disp([num2str(i),'-th, find the temperate best Feature, Acc=',num2str(Acc),'Dim=',num2str(Tem_dim)]);
    else
        i = i+1;
        disp(['continue',num2str(i)]);
    end
    
end
save(['E:\Relief_RandomForest_Feature_Ratio',num2str(Name_index(l)),'.mat'],'Feature','Acc','Auc','P','R','F1');
end
%%