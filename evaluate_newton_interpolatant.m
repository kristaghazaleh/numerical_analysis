function u = evaluate_newton_interpolant(x, y, t)
    c = newton_interpolation_constants(x, y);
    u = zeros(size(t)) + c(end);

    n = length(y) - 1;

    for i = n : -1 : 1
        u = (t - x(i)) .* u + c(i);
    end
end
