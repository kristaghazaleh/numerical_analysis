function [root_approx, f_at_root, iteration_count] = steffensen_method(f_handle, start_x, abs_tol, max_iters)
% f(x)=0 using Steffensen's method: x_{n+1} = x_n - f(x_n)^2 / ( f(x_n + f(x_n)) - f(x_n) )
    if nargin < 3 || isempty(abs_tol), abs_tol = 1e-12; end
    if nargin < 4 || isempty(max_iters), max_iters = 100; end

    current_x = start_x;

    for iteration_count = 1:max_iters
        f_current = f_handle(current_x);

        % stop if already close enough in function value
        if abs(f_current) < abs_tol
            break;
        end

        x_plus_fx = current_x + f_current;
        f_at_x_plus_fx = f_handle(x_plus_fx);
        denominator = f_at_x_plus_fx - f_current;

        if denominator == 0
            error('Steffensen failed: denominator zero at iter %d (x = %.16e).', iteration_count, current_x);
        end

        step_size = (f_current^2) / denominator;

        % cap steps (important for tan(x)-x)
        max_step = 0.5;
        if abs(step_size) > max_step
            step_size = sign(step_size) * max_step;
        end

        next_x = current_x - step_size;

        % stop if step is tiny
        if abs(step_size) < abs_tol * (1 + abs(next_x))
            current_x = next_x;
            break;
        end

        % Stop if machine precision stalls
        if next_x == current_x
            current_x = next_x;
            break;
        end

        current_x = next_x;
    end

    root_approx = current_x;
    f_at_root = f_handle(root_approx);
end
