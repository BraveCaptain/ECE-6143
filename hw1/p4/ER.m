function risk = ER(x,y,theta)
    sum = 0;
    for i = 1 : 200
        LogReg = 1./(1 + exp(-x(i,:)*theta) );
        left = (y(i) - 1) * log(1-LogReg);
        right = y(i) * log(LogReg);
        sum = sum + left - right;
    end
    risk = sum / 200;
    