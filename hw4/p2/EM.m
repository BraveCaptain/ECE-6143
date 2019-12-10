function [train_like,test_like, theta] = EM(K, dataset)

permutation = randperm (1000);
test_data = dataset(permutation (501:1000) ,:);
train_data = dataset(permutation (1:500) ,:);

[train_data_size, train_data_dim] = size(train_data);
tau = zeros(train_data_size, K);
theta = zeros(K,1);
Pi = ones(K) / K;

X_train = sum(train_data')';
X_test = sum(test_data')';

for k = 1 : K
    theta(k) = 0.5*k/K;
end

for i = 1 : 10
    for n = 1:train_data_size
        S = 0;
        for l = 1 : K
            S = S + Pi(l)*theta(l)^X_train(n)*(1-theta(l))^(train_data_dim-X_train(n));
        end
        
        for k = 1 : K
            tau(n,k) = Pi(k)*theta(k)^X_train(n)*(1- theta(k))^(train_data_dim-X_train(n))/S;
        end
    end
    
    for k = 1 : K
        theta(k) = sum(tau(:,k) .* X_train)/train_data_dim/sum(tau(:,k));
    end
    Pi = sum(tau)/train_data_size;
    
    train_like = 0;
    for n = 1:train_data_size
        p = 0;
        for k = 1:K
            p = p + Pi(k)*theta(k)^X_train(n)*(1-theta(k))^(train_data_dim-X_train(n));
        end
        train_like = train_like + log(p);
    end
    
    test_like = 0;
    for n = 1:train_data_size
        p = 0;
        for k = 1 : K
            p = p + Pi(k)*theta(k)^X_test(n)*(1-theta(k))^(train_data_dim-X_test(n));
        end
        test_like = test_like + log(p);
    end
end
