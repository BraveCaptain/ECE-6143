function g = grad(x, y, theta)
[data_num, ~] = size(x);
sum = 0;
for i = 1:data_num
    E = exp(-1.*x(i,:)*theta);
    frac = x(i,:)* E./(1+E);
    sum = sum + (1 - y(i)) .* (x(i,:) - frac) - y(i) .* frac;
end
g = sum / data_num;
g = g';