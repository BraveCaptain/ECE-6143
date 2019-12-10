clear; clc;
load 'datasetA.txt';
load 'datasetB.txt';
figure (1);
[like,~,~,~]=mixmodel(datasetA,3,100);
figure (2);
plot(like);
xlabel('iteration');
ylabel('likehood');

figure (3);
[like,~,~,~]=mixmodel(datasetB,3,100);
figure (4);
plot(like);
xlabel('iteration');
ylabel('likehood');