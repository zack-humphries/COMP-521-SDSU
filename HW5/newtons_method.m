%% Zack Humphries
% COMP 521
% HW5

function [root, iterations, guess_list] = newtons_method(f, fprime, guess1, delta)
    iterations = 0;
    tol=1;
    guess = guess1;
    guess_list = [guess];
    while (tol>delta || abs(f(guess))>delta)
        iterations = iterations+1;
        x = guess;
        prime = fprime(x);
        guess = x-(f(x)/prime);
        if (isnan(guess)|| isinf(guess))
            fprintf("x=%.2f is or is near a local maximum or minimum so results in an error\n",guess1)
            root = "N/A";
            return;
        end
        guess_list = [guess_list, guess];
        tol = abs(f(guess)-f(x));
    end
    root=guess;
end