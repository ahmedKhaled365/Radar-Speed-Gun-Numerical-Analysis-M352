## 2 step
function v = adams_bashforth(x_func, t, h)
    v_now = (x_func(t) - x_func(t-h)) / h;
    v_prev = (x_func(t-h) - x_func(t-2*h)) / h;
    v = v_now + (h/2)*(3*v_now - v_prev);
end

