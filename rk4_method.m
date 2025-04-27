function v = rk4_method(x_func, t, h)
    k1 = (x_func(t+h) - x_func(t)) / h;
    k2 = (x_func(t+h/2) - x_func(t-h/2)) / h;
    k3 = (x_func(t+h/2) - x_func(t-h/2)) / h;
    k4 = (x_func(t+h) - x_func(t)) / h;
    v = (k1 + 2*k2 + 2*k3 + k4) / 6;
end

