function g = grad(x,y,theta)
sum = 0;
[data_num, ~] = size(x);
for i = 1:data_num
    if y(i)*x(i,:)*theta < 0
        sum = sum + y(i)*x(i,:)';
    end
end
g = -1.* sum ./ data_num;