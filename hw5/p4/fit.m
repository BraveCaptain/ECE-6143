function [marginals] = fit(potentials)
	marginals = potentials;
	n = size(marginals,1);
	separators = ones(n-1,2);
	for i=1:n-1
		separators(i,:) = sum(marginals{i});
		marginals{i+1} = marginals{i+1}.*(separators(i,:)'*[1,1]);
    end
	for i=1:n-1
		tmp = separators(n-i,:);
		separators(n-i,:) = sum(marginals{n-i+1},2)';
		marginals{n-i} = marginals{n-i}.*([1;1]*(separators(n-i,:)./tmp));
    end
	for i=1:n
		marginals{i} = marginals{i}/sum(sum(marginals{i}));
	end
end
