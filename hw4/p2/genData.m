function [data] = genData(mu,covar,numpts)
%[data] = genData(mu,covar,numpts)
%
%GENERATE DATA FROM GIVEN GAUSSIAN CLUSTERS
%This function generates random datapoints drawn from the specified
%gaussian clusters.
%
%  mu        are the means of the clusters (cols are dimensions)
%  covar     is either a single covariance DxD matrix or a stack of M DxD
%  numpts    is either a vector M long or a single number

M = size(mu,1);
D = size(mu,2);

if (size(numpts,2)==1) numpts=ceil(numpts(1)/M)*ones(1,M); end

if (size(covar,1)<(M*D)) 
  tmpcovar=covar;
  covar=zeros(M*D,D);
  for i=1:M
    covar((i-1)*D+1:i*D,:)=tmpcovar;
  end
end

A = zeros(M*D,D);
for i=1:M
  cvi = covar((i-1)*D+1:i*D,:);
  [vv,dd] = eig(cvi);
  A((i-1)*D+1:i*D,:)=(vv*sqrt(dd))';
end


data = zeros(sum(numpts),D);

p = 1;
for i=1:M
  Ai = A((i-1)*D+1:i*D,:);
  for n=1:numpts(i)
    z = randn(1,D);
    data(p,:) = z*Ai+mu(i,:);
    p=p+1;
  end
end

