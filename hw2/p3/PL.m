function s = PL(x,y,theta)
sum = 0;
for i = 1:200
    if y(i)*x(i,:)*theta < 0
        sum = sum + y(i)*x(i,:)*theta;
    end
end
s = -sum ./ 200;