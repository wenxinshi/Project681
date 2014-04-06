close all;clc;clear all;
load('data/TargetData');
load('data/norm_location.mat');
load('data/norm_angle.mat');
warning('off','all');
warning;

norm_location=squeeze([norm_location(:,1,:);norm_location(:,2,:)])'  ;
norm_location(:,[13 62])=[];
feature=[norm_location distance testanglelist];

target=target<10;
data=[feature target];
trainData=data(1:190,:);
testData=data(191:end,:);


classifer.name='FLD';
[auc,selectFeature]=prFeatureSelection(trainData,classifer,'sequential');

classifer=prTrainClassifer([trainData(:,selectFeature) trainData(:,end)],classifer);
ds=prRunClassifer(classifer,testData(:,selectFeature));
ret=[ds testData(:,end)];

