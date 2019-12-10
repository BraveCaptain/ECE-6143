clear
clc
psis = cell(4, 1);
for i = 1:4
	psis{i} = rand(2,2);
end
es = fit(psis);

test = cell(4,1);
test{1} = [0.1, 0.7; 0.8, 0.3];
test{2} = [0.5, 0.1; 0.1, 0.5];
test{3} = [0.1, 0.5; 0.5, 0.1];
test{4} = [0.9, 0.3; 0.1, 0.3];
[res] = fit(test);