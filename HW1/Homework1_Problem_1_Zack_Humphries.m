%% Zack Humphries
% COMP 521
% HW1 Problem 1

clc;       % clear command window
clear;     % removes all saved variables
close all; % close any open windows

%% Problems a, b, & c
% a)
[finalsum_a, x_list_a, sum_list_a] = loop_problem('a', 1, 50);
plot_a = plot(x_list_a, sum_list_a, '--r');
title("Series A")
xlabel("n")
ylabel("Sum of Series")

% b)
[finalsum_b, x_list_b, sum_list_b] = loop_problem('b', 1, 50);
x_list_b = x_list_b - 1;
figure(2)
plot_b = plot(x_list_b, sum_list_b, '--b');
title("Series B")
xlabel("n")
ylabel("Sum of Series")


% c)
[finalsum_c, x_list_c, sum_list_c] = loop_problem('c', 1, 50);
figure(3)
plot_c = plot(x_list_c, sum_list_c, '--g');
title("Series C")
xlabel("n")
ylabel("Sum of Series")


%% Functions Used for a, b, & c

function [finalsum, x_list, sum_list] = loop_problem(problem, n_start, n_end)
    x_list = [n_start: n_end];
    sum = 0.0;
    sum_list = [];

    for n=n_start: n_end
        sum = sum + function_to_use(problem, n);
        sum_list(n) = sum;
    end
    finalsum = sum;
end

function answer = function_to_use(problem, n)
    if strcmp('a', problem)
        answer = problem_a(n);
    elseif strcmp('b', problem)
        answer = problem_b(n);
    elseif strcmp('c', problem)
        answer = problem_c(n);
    end
end

function ans_a = problem_a(n)
    ans_a = ((factorial(n))^2)/(factorial(2*n));
end

%Note: Using n-1, starting at n=1 instead of using n, staring at n=0
%Is corrected for @ x_list_b = x_list_b - 1
function ans_b = problem_b(n)
    ans_b = (3^(2*(n-1)))/(10^(n-1));
end

function ans_c = problem_c(n)
    ans_c = exp(-1*(n^2));
end