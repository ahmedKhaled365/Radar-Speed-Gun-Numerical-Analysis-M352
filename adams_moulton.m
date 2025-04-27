## 2 step
function v = adams_moulton(x_func, t, h)
    v_now = (x_func(t) - x_func(t-h)) / h;
    v_next = (x_func(t+h) - x_func(t)) / h;
    v = v_now + (h/2)*(v_now + v_next);
end

