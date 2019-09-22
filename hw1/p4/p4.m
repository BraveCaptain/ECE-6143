clear;clc;
load('./dataset4.mat');

step = 0.2;
tol = 0.001;

theta_prev = rand(3,1);
theta = theta_prev + step * grad(X,Y,theta_prev);

risk = [];
err = [];

risk(1) = ER(X,Y,theta_prev);
risk(2) = ER(X,Y,theta);

err(1) = errCal(X,Y,theta_prev);
err(2) = errCal(X,Y,theta);


max_iter = 500000;
iter = 3;

while norm(theta - theta_prev) > tol
    if iter > max_iter
        break;
    end
    theta_prev = theta;
    theta = theta - step * grad(X,Y,theta);
    risk(iter) = ER(X,Y,theta);
    err(iter) = errCal(X,Y,theta);
    iter = iter + 1;
end

figure(1);
plot(1:iter-1,risk,'r');
hold on;
plot(1:iter-1,err,'b');
legend('empirical risk','binary classification error');
xlabel('number of iterations');
filename1 = sprintf('err&risk_step=%f_tol=%f.png',step,tol);
print(filename1,'-dpng');
figure(2);
for i = 1:length(Y)
    if Y(i) == 0
        plot(X(i,1),X(i,2),'bX');
    end
    if Y(i) == 1
        plot(X(i,1),X(i,2),'rO');
    end
    hold on;
end

boundry = zeros(100,1);
for i = 1:100
    boundry(i) = -(theta(1).*i/100 + theta(3) ) ./ theta(2);
end
plot(0.01:0.01:1, boundry,'g');

filename2 = sprintf('DecisionBoundry_step=%f_tol=%f.png',step,tol);
print(filename2,'-dpng');
filename3 = sprintf('theta_step=%f_tol=%f.mat',step,tol);
save (filename3,'theta');
