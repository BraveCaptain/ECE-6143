function err = errCal(x,y,theta)
    LogReg = 1./(1+exp(-x*theta));
    for i = 1:200
        if LogReg(i) > 0.5
            LogReg(i) = 1;
        end
        if LogReg(i) <= 0.5
            LogReg(i) = 0;
        end
    end
    err = norm(sum(y-LogReg)/200);
end