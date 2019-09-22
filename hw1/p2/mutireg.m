function [err_train,model,err_test] = mutireg(x_train,y_train,lambda,x_test,y_test)

[rows_train, column_train] = size(x_train);
model = inv(x_train'*x_train+lambda*eye(column_train))*x_train'*y_train;
err_train   = (1/(2*rows_train))*sum((y_train-x_train*model).^2);

[rows_test, ~] = size(x_test);

err_test  = (1/(2*rows_test))*sum((y_test-x_test*model).^2);

