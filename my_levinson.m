function [a, E] = my_levinson(r, p)
% r: autocorrelation values [r(0), r(1), ..., r(p)]
% p: LPC order
% a: LPC coefficients [1 a1 ... ap]
% E: prediction error

a = zeros(p+1,1);   % a0...ap
a(1) = 1;           % a0 = 1
E = r(1);           % initial error = r(0)

for i = 1:p
    % computation reflection coefficient k_i
    sum_val = 0;
    for k = 1:i-1
        sum_val = sum_val + a(k+1) * r(i-k+1);
    end
    k_i = -(r(i+1) + sum_val) / E;

    a_prev = a;
    for k = 1:i-1
        a(k+1) = a_prev(k+1) + k_i * a_prev(i-k+1);
    end
    a(i+1) = k_i;

    % prediction error
    E = (1 - k_i^2) * E;
end
