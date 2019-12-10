clear;clc;
load problem2.mat;
N = 10;
train_likes = zeros(N,5);
test_likes = zeros(N,5);
thetas = zeros(N,3);
for i = 1 : N
    for j = 1 : 5
        [train_likes(i,j), test_likes(i,j), theta ] = EM(j, dataset);
        if j == 3
            thetas(i,:) = theta;
        end
    end
end
figure(1);
boxplot(train_likes);
figure(2)
boxplot(test_likes);
figure(3)
boxplot(thetas)
