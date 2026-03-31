clear;
clc;

% 13 nodes from the parametrization
i = -6:6;
theta = i * pi / 14;

x = 0.5 * tan(theta);
y = sin(2 * theta);

% Fine grid for plotting
xx = linspace(min(x), max(x), 1000);

% Original serpentine curve
yy_true = xx ./ (0.25 + xx.^2);

% Interpolation polynomial in Newton form
yy_poly = evaluate_newton_interpolant(x, y, xx);

% Natural cubic spline
yy_spline = cubic_spline_vector(x, y, xx);

% Plot all together for comparison
figure;
plot(xx, yy_true, 'k-', 'LineWidth', 2);
hold on;
plot(xx, yy_poly, 'r--', 'LineWidth', 2);
plot(xx, yy_spline, 'b-.', 'LineWidth', 2);
plot(x, y, 'ko', 'MarkerFaceColor', 'k');
grid on;
legend('Original serpentine curve', 'Interpolation polynomial', ...
       'Natural cubic spline', '13 nodes', 'Location', 'best');
title('Problem 1: Serpentine Curve Interpolation');
xlabel('x');
ylabel('y');
hold off;
