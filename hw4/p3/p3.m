raw_im = Tiff('trees.tif','r');
im = raw_im. readRGBAImage ();
im = im2double(im (1:200 ,1:200 , :));
figure(1);
imshow(im);
[height , width , ~] = size(im);

K_max = 5;
for K=3:K_max
    mu = zeros ([K 3]);
    for k = 1:K
        mu_h = randi ([1 height ]);
        mu_w = randi ([1 width ]);
        mu(k, :) = im(mu_h,mu_w, :);
    end

    Z = zeros(height, width, K);
    n_iteration = 0;
    while true
        old_Z = Z;
        for n_h = 1: height
            for n_w = 1: width
                distance_to_mu = Inf;
                for k = 1:K
                    if norm(mu(k, :) - squeeze(im(n_h, n_w, :))') < distance_to_mu
                        distance_to_mu = norm(mu(k, :) - squeeze(im(n_h,n_w, :))');
                        Z(n_h, n_w, :) = 0;
                        Z(n_h, n_w, k) = 1;
                    end
                end
            end
        end
        n_iteration = n_iteration + 1;
        if isequal(Z, old_Z)
            break
        end
        for k = 1:K
            for channel = 1:3
                mu(k, channel) = (sum(sum(im(:, :, channel) .* Z(:,:,k))))/sum(sum(Z(:, :, k)));
            end
        end
    end
    ind = find(isnan(mu));
    n_unused_means = length(ind)/3;
    mu(ind)= 0;
    segmented_image = zeros(size(im));
    for k = 1:K
        for channel = 1:3
            segmented_image(:, :, channel) = segmented_image(:, :,channel) + mu(k, channel) * Z(:,:,k);
        end
    end
    figure(K-1);
    imshow(segmented_image);
end
