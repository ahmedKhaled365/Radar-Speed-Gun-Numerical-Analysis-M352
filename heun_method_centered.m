function v = heun_method_centered(x_func, t, h)
    v_forward = (x_func(t+h) - x_func(t)) / h;
    v_backward = (x_func(t) - x_func(t-h)) / h;
    v = (v_forward + v_backward) / 2;
end

