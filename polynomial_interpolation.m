%[text] # Interpolating the exponential function at the integers 0, 1, 2, ...
n = 4;
x = [0 : n];
% the function we are interpolating
f = @(x) exp(x);
y = f(x);
% the positions where we will evaluate the interpolating polynomial
xi = linspace(0, n, 100);
yi = evaluate_newton_interpolant(x, y, xi)
%%
p = plot(xi, f(xi), xi, yi);
p(1).LineWidth = 3;
p(2).LineWidth = 3;
%%
%[text] # Higher Order Approximation is Better? Computer Problem 6.2.1
clear all;
n = 20
a = -5;
b = 5;

x = linspace(a, b, n);
f = @(x) 1 ./ (1 + x.^2);
y = f(x);

xi = linspace(a, b, 75);
yi = evaluate_newton_interpolant(x, y, xi);

p = plot(xi, f(xi), xi, yi);
p(1).LineWidth = 3;
p(2).LineWidth = 3;
error = abs(f(xi) - yi)';
x = xi';
table(x, error)
%%
%[text] # Example from bottom of page 311
x = [5 -7 -6 0];
p3 = @(x) 4 * x.^3 + 35 * x.^2 - 84 * x - 954;
y = p3(x)
c = newton_interpolation_constants(x, y)
yt = evaluate_newton_interpolant(x, y, 1/2)
p3(1/2)
%%
function u = evaluate_newton_interpolant(x, y, t)
% u = evaluate_newton_interpolant(x, y, t)
%
% Horner's method for evaluating an interpolating polynomial in Newton's form
% at a position.  Based on the pseudo-code on page 311 from Kincaid and Cheney.
%
% Input:
% x - the nodes where the interpolation will occur
% y - the value of the function at the given node
% t - the position vector where we are evaluating the interpolating polynomial
%
% Output:
% u - u = p_k(t) -the value of the interpolating polynomial at the positions 
% described by t

    c = newton_interpolation_constants(x, y);
    u = zeros(size(t)) + c(end);
    
    % we have n + 1 points ranging from y0 to yn, so n is the length of y
    % minus 1
    n = length(y) - 1;
       
    % shift the index by 1 since MATLAB is 1-indexed
    for i = n : -1 : 1
        u = (t - x(i)) .* u + c(i);
    end
end

function c = newton_interpolation_constants(x, y)
% c = newton_interpolation_constants(x, y)
%
% Calculates the coefficients c_k of the Newton form of the
% interpolating polynomial p_k where
% p_k(x) = c0 + c1 (x - x0) + ... cn (x - x0)...(x - xn)
%
% Input:
%
% x - the nodes where the interpolation will occur
% y - the value of the function at the given node
%
% Output:
% c - the coefficients c_k of the interpolating polynomial

    c = zeros(size(y));
    c(1) = y(1);

    % we have n + 1 points ranging from x0 to xn, so n is the length of y
    % minus 1
    n = length(y) - 1;
    
    % shift the index by 1 since MATLAB is 1-indexed
    for k = 2 : n + 1
        d = x(k) - x(k - 1);
        u = c(k - 1);
        % shift only the final index from 0 to 1 since k - 2 has already
        % been shifted by 1 in the outer for-loop
        for i = k - 2 : -1 : 1
            u = u * (x(k) - x(i)) + c(i);
            d = d * (x(k) - x(i));
        end
        c(k) = (y(k) - u) / d;
    end
end


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline","rightPanelPercent":40}
%---
