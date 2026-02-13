format long e

abs_tol = 1e-12;
max_iters = 100;

% tan(x) = x  <=>  f(x) = tan(x) - x
f_handle = @(x) tan(x) - x;

%% problem 1: roots nearest 4.5 and 7.7
start_values = [4.5, 7.7];

fprintf('Roots nearest the given starting values:\n');
for idx = 1:numel(start_values)
    start_x = start_values(idx);
    [root_approx, f_at_root, iteration_count] = steffensen_method(f_handle, start_x, abs_tol, max_iters);

    fprintf('\nstart_x = %.16e\n', start_x);
    fprintf('root_approx = %.16e\n', root_approx);
    fprintf('f(root_approx) = %.16e\n', f_at_root);
    fprintf('iterations = %d\n', iteration_count);
end

%% problem 2: first ten positive roots of tan(x)=x
% reliable initial guess is (n + 1/2)pi - 0.1.
root_count = 10;
roots = zeros(root_count, 1);

fprintf('\n\nFirst ten positive roots of tan(x) = x:\n');

for n = 1:root_count
    asymptote_x = (n + 0.5) * pi;
    start_x = asymptote_x - 0.1;  % small step left of asymptote

    [root_approx, f_at_root, iteration_count] = steffensen_method_simple(f_handle, start_x, abs_tol, max_iters);

    roots(n) = root_approx;

    fprintf('n = %2d  start_x = %.12f  root = %.16e  f(root)=%.3e  iters=%d\n', ...
        n, start_x, root_approx, f_at_root, iteration_count);
end

disp('roots = ');
disp(roots);
