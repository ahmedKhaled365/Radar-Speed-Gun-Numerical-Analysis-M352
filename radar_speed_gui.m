function radar_speed_gui()
    % Create the figure
    f = figure('Position', [300, 300, 800, 600], 'Name', 'Radar Speed Gun GUI');

    % Position function input
    uicontrol('Style', 'text', 'Position', [50 550 100 30], 'String', 'x(t) =');
    x_input = uicontrol('Style', 'edit', 'Position', [150 550 200 30]);

    % Derivative (exact velocity) input
    uicontrol('Style', 'text', 'Position', [400 550 100 30], 'String', 'v(t) =');
    v_input = uicontrol('Style', 'edit', 'Position', [500 550 200 30]);

    % Time input
    uicontrol('Style', 'text', 'Position', [50 500 100 30], 'String', 't =');
    t_input = uicontrol('Style', 'edit', 'Position', [150 500 100 30]);

    % Step size input
    uicontrol('Style', 'text', 'Position', [400 500 100 30], 'String', 'h =');
    h_input = uicontrol('Style', 'edit', 'Position', [500 500 100 30]);

    % Dropdown menu for methods
    uicontrol('Style', 'text', 'Position', [50 450 150 30], 'String', 'Choose Method:');
    methods = {'Euler Forward', 'Euler Backward', 'Heun''s Method', 'Midpoint Method', 'Runge-Kutta 4', 'Adams-Bashforth', 'Adams-Moulton'};
    method_menu = uicontrol('Style', 'popupmenu', 'Position', [200 450 200 30], 'String', methods);

    % Calculate button
    uicontrol('Style', 'pushbutton', 'Position', [450 450 150 30], 'String', 'Calculate', ...
              'Callback', @(src, event) calculate_callback());

    % Results display
    result_text = uicontrol('Style', 'text', 'Position', [50 400 700 30], 'String', 'Result: ', 'HorizontalAlignment', 'left');

    % Axes for plotting
    ax = axes('Units', 'pixels', 'Position', [100 50 600 300]);

    % Callback function
    function calculate_callback()
        % Get user inputs
        x_func_str = get(x_input, 'String');
        v_func_str = get(v_input, 'String');
        t = str2double(get(t_input, 'String'));
        h = str2double(get(h_input, 'String'));
        method_idx = get(method_menu, 'Value');

        % Convert strings to function handles
        try
            x_func = str2func(['@(t)', x_func_str]);
            v_func = str2func(['@(t)', v_func_str]);
        catch
            errordlg('Error in function syntax. Check your x(t) and v(t) definitions.');
            return;
        end

        % Compute numerical speed based on method
        switch method_idx
            case 1
                v_numerical = euler_forward(x_func, t, h);
            case 2
                v_numerical = euler_backward(x_func, t, h);
            case 3
                v_numerical = heun_method(x_func, t, h);
            case 4
                v_numerical = midpoint_method(x_func, t, h);
            case 5
                v_numerical = rk4_method(x_func, t, h);
            case 6
                v_numerical = adams_bashforth(x_func, t, h);
            case 7
                v_numerical = adams_moulton(x_func, t, h);
        end

        % Compute exact speed
        v_exact = v_func(t);

        % Display results
        error_val = abs(v_numerical - v_exact);
        set(result_text, 'String', sprintf('Result: Numerical = %.5f, Exact = %.5f, Error = %.5f', v_numerical, v_exact, error_val));

        % Plot
        times = t-2*h:h/10:t+2*h; % small range around t
        exact_values = arrayfun(v_func, times);
        numerical_values = arrayfun(@(ti) apply_method(x_func, ti, h, method_idx), times);

        cla(ax);
        plot(ax, times, exact_values, 'b-', 'LineWidth', 2); hold on;
        plot(ax, times, numerical_values, 'r--', 'LineWidth', 2);
        legend(ax, 'Exact Solution', 'Numerical Approximation');
        title(ax, 'Exact vs Numerical Speed');
        xlabel(ax, 'Time (s)');
        ylabel(ax, 'Speed');
        grid(ax, 'on');
        hold off;
    end

    function v_approx = apply_method(x_func, t, h, method_idx)
        % Helper to apply the selected method in plotting
        switch method_idx
            case 1
                v_approx = euler_forward(x_func, t, h);
            case 2
                v_approx = euler_backward(x_func, t, h);
            case 3
                v_approx = heun_method(x_func, t, h);
            case 4
                v_approx = midpoint_method(x_func, t, h);
            case 5
                v_approx = rk4_method(x_func, t, h);
            case 6
                v_approx = adams_bashforth(x_func, t, h);
            case 7
                v_approx = adams_moulton(x_func, t, h);
        end
    end

end

