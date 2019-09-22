clear;clc;
p1_data = load('./problem1.mat');

ind = crossvalind('Kfold',500,2);

x_train = p1_data.x(ind == 1);
y_train = p1_data.y(ind == 1);
x_test = p1_data.x(ind == 2);
y_test = p1_data.y(ind == 2);

theta = {};

for i = 1 : 10
    figure(i);
    [err_min, theta{i}, errT_min] = polyreg(x_train, y_train, i, x_test, y_test);
    title(sprintf('d = %d',i-1));
    filename = sprintf('d=%d.png',i-1);
    print(filename,'-dpng');
end

D = 50;
errs = zeros(D,1);
errTs = zeros(D,1);

for d = 1:D
    [errs(d), model, errTs(d)] = polyreg(x_train, y_train, d, x_test, y_test);
end

close all;
figure(11);
plot((0:D-1),errs(1:D),'r');
hold on;
plot((0:D-1), errTs(1:D),'b')
[min_errT_val, min_errT_index] = min(errTs);
hold on;
plot(min_errT_index,min_errT_val,'bX');
legend('train', 'test', 'degree with minimal test error');
text(min_errT_index,min_errT_val,int2str(min_errT_index-1));
title('Cross Validation');
xlabel('polynomial degree');
ylabel('error');
print('CrossValidation.png','-dpng');

