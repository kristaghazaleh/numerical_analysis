format long

for n = 13:25
    A = zeros(n,n);
    b = zeros(n,1);

    for i = 1:n
        b(i) = i - 1;
        for j = 1:n
            A(i,j) = (i - 1)^(j - 1);
        end
    end

    n
    x = A\b
end
