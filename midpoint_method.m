function v = midpoint_method(x_func, t, h)
    v = (x_func(t+h/2) - x_func(t-h/2)) / h;
end

