clear;clc;
p2_data = load('./problem2.mat');
ind = crossvalind('Kfold',400,2);
x_train = p2_data.x(ind == 1,:);
y_train = p2_data.y(ind == 1);
x_test = p2_data.x(ind == 2,:);
y_test = p2_data.y(ind == 2);

lambda_max = 1000;
err_train = zeros(lambda_max, 1);
err_test = zeros(lambda_max,1);
for i = 1 : 1: 1000
    [err_train(i), model, err_test(i)] = mutireg(x_train, y_train, i, x_test, y_test);
end

figure(1)
[min_error_test_val, min_lambda] = min(err_test);
hold on;
plot((1:lambda_max),err_train(1:lambda_max),'r');
plot((1:lambda_max), err_test(1:lambda_max),'g')
plot(min_lambda, min_error_test_val,'bX');
text(min_lambda, min_error_test_val,num2str(min_lambda) );
legend('train error','test error','lambda with minimal test error');
xlabel('lambda');
ylabel('error');
print('err&errT.png','-dpng');