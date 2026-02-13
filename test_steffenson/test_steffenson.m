% test_steffensen_tanx_equals_x.m
format long e

abs_tol = 1e-12;
max_iters = 100;

% tan(x) = x  <=>  f(x) = tan(x) - x
f_handle = @(x) tan(x) - x;

%% Problem 1: roots nearest 4.5 and 7.7
start_values = [4.5, 7.7];

fprintf('Roots nearest the given starting values:\n');
for idx = 1:numel(start_values)
    start_x = start_values(idx);

    [root_approx, f_at_root, iteration_count] = steffensen_method( ...
        f_handle, start_x, abs_tol, max_iters);

    fprintf('\nstart_x = %.16e\n', start_x);
    fprintf('root_approx = %.16e\n', root_approx);
    fprintf('f(root_approx) = %.3e\n', f_at_root);
    fprintf('iterations = %d\n', iteration_count);
end

%% Problem 2: first ten positive roots of tan(x)=x
% Safer initial guess: just to the right of n*pi (stays away from asymptote)
root_count = 10;
roots = zeros(root_count, 1);

fprintf('\n\nFirst ten positive roots of tan(x) = x:\n');

for n = 1:root_count
    start_x = n*pi + 0.1;   % safe starting point inside (n*pi, (n+1/2)pi)

    [root_approx, f_at_root, iteration_count] = steffensen_method( ...
        f_handle, start_x, abs_tol, max_iters);

    roots(n) = root_approx;

    fprintf('n=%2d  start_x=%.12f  root=%.16f  f(root)=%.3e  iters=%d\n', ...
        n, start_x, root_approx, f_at_root, iteration_count);
end

fprintf('\nroots = \n');
disp(roots);
