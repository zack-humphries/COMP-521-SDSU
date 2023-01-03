%% Zack Humphries
% COMP 521
% HW5

clc;       % clear command window
clear;     % removes all saved variables
close all; % close any open windows


%% 1(a)
ga = @(x) (x+2)^(1/2);
tol = 10^(-9);

p0 = [2.5 0.15 1.5];
plot_color_setting = ["-or", "-ob", "-og"];
fprintf("Fixed Point Iteration:\n")
fprintf("a)\n")
for n=1:3
    [root, iterations, guess_list] = fixed_point_iteration(ga, tol, p0(n));
    fprintf("With p0=%.2f, the root is %.2f and it took %i iterations to find the root\n", p0(n), root, iterations)
    plot([0:1:iterations], guess_list, plot_color_setting(n))
    hold on
end

ga = @(x) -(x+2)^(1/2);
for n=1:3
    [root, iterations, guess_list] = fixed_point_iteration(ga, tol, p0(n));
    fprintf("With p0=%.2f, the root is %.2f and it took %i iterations to find the root\n", p0(n), root, iterations)
    plot([0:1:iterations], guess_list, plot_color_setting(n))
    hold on
end
title("1(a) Fixed Point Iteration")
xlabel("Number of Iterations")
ylabel("Root Estimation (p)")
legend("p0 = 2.5", "p0 = 0.15", "p0 = 1.5")
fprintf("\n")
hold off


% 1(b)
gb = @(x) exp(x)-2;
plot_color_setting = ["-ob", "-om"];
fprintf("b)\n")
figure(2)
p0 = [0.15 0.25]; % 2.5 doesn't work
for n=1:2
    [root, iterations, guess_list] = fixed_point_iteration(gb, tol, p0(n));
    fprintf("With p0=%.2f, the root is %.2f and it took %i iterations to find the root\n", p0(n), root, iterations)
    plot([0:1:iterations], guess_list, plot_color_setting(n))
    hold on
end
title("1(b) Fixed Point Iteration")
xlabel("Number of Iterations")
ylabel("Root Estimation (p)")
legend("p0 = 0.15", "p0 = 0.25")
fprintf("\n")
hold off

%% 2(a)
fa = @(x) -(x^2)+x+2;
fb = @(x) exp(x)-x-2;
figure(3)

range1 = [-4.0 1.0];
range2 = [0.5 3.0];
fprintf("Bisection Method:\n")
fprintf("a)\n")
[root, iterations, guess_list] = bisection_method(fa, range1(1),range1(2), tol);
plot([1:1:iterations], guess_list, '-or')
fprintf("With a=%.2f and b=%.2f, the root is %.2f and it took %i iterations to find the root\n", range1(1), range1(2), root, iterations)
hold on
[root, iterations, guess_list] = bisection_method(fa, range2(1),range2(2), tol);
plot([1:1:iterations], guess_list, '-ob')
fprintf("With a=%.2f and b=%.2f, the root is %.2f and it took %i iterations to find the root\n", range2(1), range2(2), root, iterations)
fprintf("\n")
title("2(a) Bisection Method")
xlabel("Number of Iterations")
ylabel("Root Estimation (p)")
legend("a=-4.0 & b=1.0", "a=0.5 & b=3.0")
hold off

%2(b)
figure(4)
fprintf("b)\n")
[root, iterations, guess_list] = bisection_method(fb, range1(1),range1(2), tol);
plot([1:1:iterations], guess_list, '-ob')
fprintf("With a=%.2f and b=%.2f, the root is %.2f and it took %i iterations to find the root\n", range1(1), range1(2), root, iterations)
hold on
[root, iterations, guess_list] = bisection_method(fb, range2(1),range2(2), tol);
plot([1:1:iterations], guess_list, '-or')
fprintf("With a=%.2f and b=%.2f, the root is %.2f and it took %i iterations to find the root\n", range2(1), range2(2), root, iterations)
fprintf("\n")
title("2(b) Bisection Method")
xlabel("Number of Iterations")
ylabel("Root Estimation (p)")
legend("a=-4.0 & b=1.0", "a=0.5 & b=3.0")
hold off


%% 3(a)
fprimea = @(x) -2*x+1;
fprimeb = @(x) exp(x)-1;
figure(5)

p0 = [-3.0 0.0 6.0];
plot_color_setting = ["-or", "-ob", "-og"];
fprintf("Newton's Method:\n")
fprintf("a)\n")
for n=1:3
    [root, iterations, guess_list] = newtons_method(fa, fprimea, p0(n), tol);
    plot([0:1:iterations], guess_list, plot_color_setting(n))
    hold on
    fprintf("With p0=%.2f, the root is %.2f and it took %i iterations to find the root\n", p0(n), root, iterations)
end
fprintf("\n")
title("3(a) Newton's Method")
xlabel("Number of Iterations")
ylabel("Root Estimation (p)")
legend("p0 = -3.0", "p0 = 0.0", "p0 = 6.0")
fprintf("\n")
hold off

% 3(b)
fprintf("b)\n")
figure(6)
for n=1:3
    [root, iterations, guess_list] = newtons_method(fb, fprimeb, p0(n), tol);
    if (isnumeric(root))
        plot([0:1:iterations], guess_list, plot_color_setting(n))
        hold on
    end
    fprintf("With p0=%.2f, the root is %.2f and it took %i iterations to find the root\n", p0(n), root, iterations)
end
fprintf("\n")
fprintf("\n")
title("3(b) Newton's Method")
xlabel("Number of Iterations")
ylabel("Root Estimation (p)")
legend("p0 = -3.0", "p0 = 6.0")



