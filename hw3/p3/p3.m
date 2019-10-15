clear;clc;
load teapots.mat;
conv = cov(teapotImages);
[v,d] = eig(conv);
[~,index]=sort(diag(d),'descend'); 
v=v(:,index);
c=(teapotImages-mean(teapotImages))*v(:,[1,2,3]);
x_hat=c*v(:,[1,2,3])';

for i = 1:10
    figure(i);
    imagesc(reshape(mean(teapotImages)+x_hat(i,:),38,50));
    colormap gray;
    filename = sprintf('pca%d.png',i);
    %print(filename,'-dpng');
end

for i = 1:10
    figure(10+i);
    imagesc(reshape(teapotImages(i,: ),38,50));
    colormap gray;
    filename = sprintf('ori%d.png',i);
    %print(filename,'-dpng');
end
figure(21);
imagesc(reshape(v(:,1 ),38,50));
colormap gray;
print("vec1.png",'-dpng');
figure(22);
imagesc(reshape(v(:,2 ),38,50));
colormap gray;
print("vec2.png",'-dpng');
figure(23);
imagesc(reshape(v(:,3 ),38,50));
colormap gray;
print("vec3.png",'-dpng');
figure(24);
imagesc(reshape(mean(teapotImages),38,50));
colormap gray;
print("mean.png",'-dpng');
