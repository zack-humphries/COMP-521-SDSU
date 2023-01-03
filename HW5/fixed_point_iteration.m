%% Zack Humphries
% COMP 521
% HW5

function [root, iteration, guess_list] = fixed_point_iteration(g, tolerance, guess)
    x0 = guess;
    flag = true;
    iteration = 0;
    max_iterations = 1000;
    guess_list = [guess];

    while (flag || (iteration<max_iterations))
        x = g(x0);
        if(abs(x-x0)<tolerance)
            flag = false;
            root = x;
            break
        end
        x0=x;
        guess_list = [guess_list, x0];
        iteration = iteration + 1;
    end
end

