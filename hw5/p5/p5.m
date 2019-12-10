clc;clear;
T = [0.8, 0.2; 0.2, 0.8]';
E = [0.4, 0.1; 0.1, 0.4; 0.3, 0.2; 0.2, 0.3]';
O = [1,4,2,2,3];
I = E(:,O(1)).*[1;0];
state = [0,1]; % 0 for happy and 1 for angry
observe = [1,2,3,4]; %1 smile 2 frown 3 laugh 4 yell
H = fit(T, E, O, I);
res = state(H);