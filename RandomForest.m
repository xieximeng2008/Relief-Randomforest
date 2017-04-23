function [accuracy,P,R,F1,auc,Femal_R] = RandomForest(data,label)

train_data=data(1:floor(0.8*size(data,1)),:);
train_label=label(1:floor(0.8*size(data,1)),:);
test_data=data(floor(0.8*size(data,1))+1:end,:);
test_label=label(floor(0.8*size(data,1))+1:end,:);
%test_commentNum=comment_num(floor(0.7*size(data,1))+1:end,:);
B = TreeBagger(20,train_data,train_label);
predict_label = predict(B,test_data);
end_p=str2num(cell2mat(predict_label));

accuracy=length(find(end_p == test_label))/length(test_label);
P=length(find(end_p+test_label==0))/length(find(end_p==0));
R=length(find(end_p+test_label==0))/length(find(test_label==0));
Femal_R=length(find(end_p+test_label==2))/length(find(test_label==1));
F1=(2*P*R)/(P+R);
%PF=length(find(end_p+test_label==2))/length(find(end_p==1));
%RF=length(find(end_p+test_label==2))/length(find(test_label==1));
%FF1=(2*PF*RF)/(PF+RF);

auc=plot_roc(end_p,test_label);
end