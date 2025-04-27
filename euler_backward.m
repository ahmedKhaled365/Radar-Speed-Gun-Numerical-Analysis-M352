function v = euler_backward(x_func, t, h)
    v = (x_func(t) - x_func(t-h)) / h;
end

