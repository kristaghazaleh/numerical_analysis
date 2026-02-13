%% Alternating series test summation
format long e

epsilon = 1e-6;          %absolute error tolerance
ratio   = 0.99;          
% alternating series term
term = @(n) (-1)^(n+1) * (ratio^n);
% initialize variables
partialSum = 0;
n = 0;
% |R_n| <= |x_{n+1}|
errorBound = Inf;       % loop runs at least once

% sum until epsilon
while errorBound >= epsilon
    n = n + 1;
    partialSum = partialSum + term(n);
    nextTermMagnitude = abs(term(n+1));
    errorBound = nextTermMagnitude;
end

% Results from the algorithm
disp('Approximation (partial sum):')
disp(partialSum)

disp('Number of terms summed (n):')
disp(n)

disp('Guaranteed error bound (|R_n| <= errorBound):')
disp(errorBound)

% Exact value: sum_{n=1}^\infty (-1)^(n+1) ratio^n = ratio/(1+ratio)
exactSum = ratio/(1+ratio);
actualError = abs(exactSum - partialSum);

disp('Exact sum (for verification):')
disp(exactSum)

disp('Actual error |exactSum - partialSum|:')
disp(actualError)

disp('Check actualError <= errorBound (should be 1):')
disp(actualError <= errorBound)
