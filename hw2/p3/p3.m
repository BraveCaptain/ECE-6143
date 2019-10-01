clear;clc;

step = 2.5;
tol = 0.0001;

load ('./data3.mat');
x(:,1:2) = data(:,1:2);
x(:,3) = 1;
y = data(:,3);
theta_prev = rand(3,1);
theta = theta_prev - step * grad(x,y,theta_prev);
iter = 3;

CLs(1) = CL(x,y,theta_prev);
CLs(2) = CL(x,y,theta);
PLs(1) = PL(x,y,theta_prev);
PLs(2) = PL(x,y,theta);


while norm(theta-theta_prev) > tol
    theta_prev = theta;
    theta = theta - step * grad(x,y,theta);
    CLs(iter) = CL(x,y,theta);
    PLs(iter) = PL(x,y,theta);
    iter = iter + 1;
end
CLs = CLs';
PLs = PLs';
figure(1);
for i = 1:200
    if data(i,3)==1
        plot(data(i,1),data(i,2),'bx');
        hold on;
    end
    if data(i,3)==-1
        plot(data(i,1),data(i,2),'g*');
        hold on;
    end
end


j=zeros(1000,1);
for i = 1:1000
    j(i) = -(theta(1)./theta(2)*i/1000 + theta(3)./theta(2) );
end

plot(0.001:0.001:1, j,'r');
print('boundry.png','-dpng');

figure(2);
plot(1:iter-1, CLs, 'b');
hold on;
plot(1:iter-1, PLs, 'r');
legend('Classification Loss','Perceptron Loss');
print('CL&PL.png','-dpng');