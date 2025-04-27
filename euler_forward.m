function v = euler_forward(x_func, t, h)
    v = (x_func(t+h) - x_func(t)) / h;
end

