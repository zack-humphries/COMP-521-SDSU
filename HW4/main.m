%% Zack Humphries
% COMP 521
% HW4

% Use numerical integration to approximate the integral of a function f(x)
% over the interval x \in [a,b]
close all; clear all; clc;

a = 0;
b = 3.5;
n_list = [20 40 80 160];
length_n_list = length(n_list);
trapl_array = zeros(1,length_n_list);
simprl_array = zeros(1,length_n_list);

for n_index=1:length_n_list

    n = n_list(n_index);
    % Part 1
    % Apply the somposite trapezoidal rule to calculate the integral
    Itc = traprl(@Fx, a, b, n);
    fprintf("The result for the integral with n = %f using Trapezoidal is %.16f \n", n, Itc);
    
    
    % Part 2
    % Apply the somposite Simpson's Rule to calculate the integral
    Isc = simprl(@Fx, a, b, n);
    fprintf("The result for the integral with n = %f using Simpson's is %.16f \n", n, Isc);
    
        
    trapl_array(n_index) = Itc;
    simprl_array(n_index) = Isc;
end

% Part 3
% Apply adadptive quadrature to calculate the integral
tol = 1e-4;
[SRmat, Ias, err] = adapt(@Fx, a, b, tol);
x = SRmat(2,:);
fprintf("The result for the integral using Adaptive Simpson's is %.16f \n", Ias);

actual = 0.1446445197;

trapl_error = abs(actual - trapl_array);
simprl_error = abs(actual - simprl_array);
adapt_error = abs(actual-Ias);
actual_list = repmat(actual, 1, length_n_list);

adapt_list = repmat(Ias, 1, length_n_list);
adapt_error_list = repmat(adapt_error, 1, length_n_list);

var_names = ['Subinterval', "Actual", "Trapeziodal: Estimated", "Trapezoidal: Absolute Error", "Simpsons: Estimated", "Simpsons: Absolute Error", "Quadrature: Estimated", "Quadrature: Absolute Error"];

T = table(n_list.', actual_list.', trapl_array.', trapl_error.', simprl_array.', simprl_error.', adapt_list.', adapt_error_list.', VariableNames=var_names)
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
    'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);


function result = Fx(x)
    part1 = exp(-2*x);
    part2 = sin(2*pi*x);
    result = part1.*part2;
end

