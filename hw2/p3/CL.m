function s = CL(x,y,theta)
sum = 0;
for i = 1 : 200
    sum = sum + stp(-y(i)*x(i,:)*theta);
end
s = sum ./ 200;

function s = stp(x)
if x >= 0
    s = 1;
end

if x < 0
    s = 0;
end