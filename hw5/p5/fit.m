function [H] = argMaxInfer(T, E, O, I)
    t = size(T, 1);
    n = size(O, 2);
    psi= zeros(t, t, n);
    phi = zeros(t, n);
    phi(:,1) = I;
    for i=2:n
        k=O(1,i);
        psi(:, :, i) = diag(phi(:, i - 1)) * T * diag(E(:,k));
        phi(:, i) = max(psi(:, :, i));
    end
    for i= n-1 : -1 : 1
        phi_new = max(psi(:, :, i + 1), [], 2);
        psi(:, :, i) = psi(:, :, i) * diag(phi_new ./ phi(:, i));
        phi(:, i) = phi_new;
    end
        [~, H] = max(phi);
end