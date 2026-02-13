format long e
%finds smallest, answering a and b at the same time
x = 1;                 
% initialize loop
while x < 2            
    % stay in interval [1,2)
    x = x + eps(1);    
    % move to the next double above x

    y = x*(1/x);       
    % MATLAB rounding; IEEE double
    if y ~= 1          
        % stops it if y is not equal to 1
        disp('x*(1/x) ~= 1:')
        format long e
        disp(x)
        disp(y)
        disp(y - 1)

        format hex     
        % show the stored bit patterns
        disp(x)
        disp(y)
        break
    end
end
