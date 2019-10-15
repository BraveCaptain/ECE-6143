clear;clc;
load shoesducks.mat;

index_train = randsample(size(X,1),size(X,1)/2);
index_test = setdiff(1:size(X,1),index_train)';

x_train = X(index_train,:);
y_train = Y(index_train,:);

x_test = X(index_test,:);
y_test = Y(index_test,:);
global p1;

%linear
err_l = zeros(20,1);
margin_l = zeros(20,1);
nsv_l = zeros(20,1);
alpha_l = zeros(72,20);
for C = 1:20
    [nsv_l(C),alpha_l(:,C),bias,margin_l(C)] = svc(x_train,y_train,'linear',C);
    err_l(C) = svcerror(x_train,y_train,x_test,y_test,'linear',alpha_l(:,C),bias);
end
figure(1);
plot(1:20, err_l);
xlabel('C');
ylabel('error');
title('error VS C');
print('linear_error.eps','-depsc');
figure(2);
plot(1:20, margin_l);
xlabel('C');
ylabel('margin');
title('margin VS C');
print('linear_margin.eps','-depsc');
figure(3);
plot(1:20, nsv_l);
xlabel('C');
ylabel('nsv');
title('nsv VS C');
print('linear_nsv.eps','-depsc');
%alpha
[~,max_index_margin_l] = max(margin_l);
a = alpha_l(:,max_index_margin_l);
save("alpha_linear.mat",'a');

%polynomial
err_p = zeros(20,20);
margin_p = zeros(20,20);
nsv_p = zeros(20,20);
alpha_p = zeros(72,20,20);
for p1=1:20
    for C=1:20
        [nsv_p(p1,C),alpha_p(:,p1,C),bias,margin_p(p1,C)] = svc(x_train,y_train,'poly',C);
        err_p(p1,C) = svcerror(x_train,y_train,x_test,y_test,'poly',alpha_p(:,p1,C),bias);
    end
end
[max_index1,max_index2] = find(margin_p==max(margin_p(:)));
figure(4);
[i,j] = meshgrid(1:20, 1:20);
meshz(i,j,err_p);
xlabel('polynomial order');
ylabel('C');
zlabel('error');
title('error VS C & order');
print('poly_error.eps','-depsc');
figure(5);
meshz(i,j,margin_p);
xlabel('polynomial order');
ylabel('C');
zlabel('margin');
title('margin VS C & order');
print('poly_margin.eps','-depsc');
figure(6);
meshz(i,j,nsv_p);
xlabel('polynomial order');
ylabel('C');
zlabel('nsv');
title('nsv VS C & order');
print('poly_nsv.eps','-depsc');
a = alpha_p(:,max_index1,max_index2);
save("alpha_poly.mat",'a');

%RBF
err_r = zeros(20,20);
margin_r = zeros(20,20);
nsv_r = zeros(20,20);
alpha_r = zeros(72,20,20);
for p1=1:20
    for C=1:20
        [nsv_r(p1,C),alpha_r(:,p1,C),bias,margin_r(p1,C)] = svc(x_train,y_train,'rbf',C);
        err_r(p1,C) = svcerror(x_train,y_train,x_test,y_test,'rbf',alpha_r(:,p1,C),bias);
    end
end
[max_index1,max_index2] = find(margin_p==max(margin_p(:)));
figure(7);
meshz(i,j,err_r);
xlabel('sigma');
ylabel('C');
zlabel('error');
title('error VS C & sigma');
print('rbf_error.eps','-depsc');
figure(8);
meshz(i,j,margin_r);
xlabel('sigma');
ylabel('C');
zlabel('margin');
title('margin VS C & sigma');
print('rbf_margin.eps','-depsc');
figure(9);
meshz(i,j,nsv_r);
xlabel('sigma');
ylabel('C');
zlabel('nsv');
title('nsv VS C & sigma');
print('rbf_nsv.eps','-depsc');
a = alpha_p(:,max_index1,max_index2);
save("alpha_rbf.mat",'a');
